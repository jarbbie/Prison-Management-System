import pool from '../db/pool.js'
import type { CreateMaintainanceDto, UpdateMaintainanceDto } from '../dto/maintainance.dto.js'
import type {
  LaborItemRow,
  MaintainanceDetail,
  MaintainanceDetailRow,
  MaintainanceRow,
} from '../models/maintainance.model.js'
import { toLaborItem, toMaintainanceDetail } from '../models/maintainance.model.js'

export const maintainanceRepository = {
  async findAll(): Promise<MaintainanceRow[]> {
    const result = await pool.query<MaintainanceRow>(`
      SELECT
        ma.id,
        ma.maintainance_name,
        ma.prison_location_id,
        ma.maintainance_date,
        ma.maintainance_cost,
        ma.status,
        pl.name AS location_name,
        pl.code AS location_code,
        COUNT(l.maintainer_id)::int AS labor_count
      FROM maintainance ma
      JOIN prisonlocation pl ON pl.id = ma.prison_location_id
      LEFT JOIN labor l ON l.maintainance_id = ma.id
      GROUP BY ma.id, ma.maintainance_name, pl.name, pl.code
      ORDER BY ma.maintainance_date DESC
    `)
    return result.rows
  },

  async findById(id: number): Promise<MaintainanceDetail | null> {
    const headerResult = await pool.query<MaintainanceDetailRow>(
      `SELECT ma.id, ma.maintainance_name, ma.prison_location_id, ma.maintainance_date,
              ma.maintainance_cost, ma.status, pl.name AS location_name
       FROM maintainance ma
       JOIN prisonlocation pl ON pl.id = ma.prison_location_id
       WHERE ma.id = $1`,
      [id]
    )
    if (!headerResult.rows[0]) return null

    const itemsResult = await pool.query<LaborItemRow>(
      `SELECT l.maintainer_id, l.labor_task,
              p.first_name, p.last_name,
              m.maintainance_skill, m.skill_description, m.company_name, m.specialization
       FROM labor l
       JOIN maintainer m ON m.id = l.maintainer_id
       JOIN person p     ON p.id = m.person_id
       WHERE l.maintainance_id = $1
       ORDER BY l.maintainer_id`,
      [id]
    )

    return toMaintainanceDetail(headerResult.rows[0], itemsResult.rows.map(toLaborItem))
  },

  async create(dto: CreateMaintainanceDto): Promise<MaintainanceDetail | null> {
    const client = await pool.connect()
    try {
      await client.query('BEGIN')

      const result = await client.query<{ id: number }>(
        `INSERT INTO maintainance (maintainance_name, prison_location_id, maintainance_date, maintainance_cost, status)
         VALUES ($1, $2, $3, $4, $5) RETURNING id`,
        [
          dto.maintainanceName,
          dto.prisonLocationId,
          dto.maintainanceDate,
          dto.maintainanceCost,
          dto.status,
        ]
      )
      const id = result.rows[0].id

      for (const item of dto.laborItems) {
        await client.query(
          `INSERT INTO labor (maintainance_id, maintainer_id, labor_task) VALUES ($1, $2, $3)`,
          [id, item.maintainerId, item.laborTask]
        )
      }

      await client.query('COMMIT')
      return this.findById(id)
    } catch (err) {
      await client.query('ROLLBACK')
      throw err
    } finally {
      client.release()
    }
  },

  async update(id: number, dto: UpdateMaintainanceDto): Promise<MaintainanceDetail | null> {
    const client = await pool.connect()
    try {
      await client.query('BEGIN')

      const check = await client.query<{ id: number }>(
        'SELECT id FROM maintainance WHERE id = $1',
        [id]
      )
      if (!check.rows[0]) {
        await client.query('ROLLBACK')
        return null
      }

      await client.query(
        `UPDATE maintainance
         SET maintainance_name = $1, prison_location_id = $2, maintainance_date = $3,
             maintainance_cost = $4, status = $5
         WHERE id = $6`,
        [
          dto.maintainanceName,
          dto.prisonLocationId,
          dto.maintainanceDate,
          dto.maintainanceCost,
          dto.status,
          id,
        ]
      )

      // Replace labor items entirely
      await client.query('DELETE FROM labor WHERE maintainance_id = $1', [id])
      for (const item of dto.laborItems) {
        await client.query(
          `INSERT INTO labor (maintainance_id, maintainer_id, labor_task) VALUES ($1, $2, $3)`,
          [id, item.maintainerId, item.laborTask]
        )
      }

      await client.query('COMMIT')
      return this.findById(id)
    } catch (err) {
      await client.query('ROLLBACK')
      throw err
    } finally {
      client.release()
    }
  },

  async delete(id: number): Promise<boolean> {
    const client = await pool.connect()
    try {
      await client.query('BEGIN')

      const check = await client.query<{ id: number }>(
        'SELECT id FROM maintainance WHERE id = $1',
        [id]
      )
      if (!check.rows[0]) {
        await client.query('ROLLBACK')
        return false
      }

      await client.query('DELETE FROM labor WHERE maintainance_id = $1', [id])
      await client.query('DELETE FROM maintainance WHERE id = $1', [id])

      await client.query('COMMIT')
      return true
    } catch (err) {
      await client.query('ROLLBACK')
      throw err
    } finally {
      client.release()
    }
  },
}
