// ── DB row types ─────────────────────────────────────────────

export interface MaintainerBySkillRow {
  maintainer_id: number
  first_name: string
  last_name: string
  gender: string
  age: number
  maintainance_skill: string
  skill_description: string | null
  company_name: string
  specialization: string
}

export interface LaborByCostRow {
  maintainance_id: number
  maintainance_name: string
  maintainance_date: Date
  maintainance_status: string
  labor_task: string
  maintainance_cost: number
  first_name: string
  last_name: string
}

export interface CostByLocationRow {
  location_name: string
  location_code: string
  total_cost: string
  total_tasks: string
}

// ── Clean API types ───────────────────────────────────────────

export interface MaintainerBySkill {
  maintainerId: number
  firstName: string
  lastName: string
  gender: string
  age: number
  maintenanceSkill: string
  skillDescription: string | null
  companyName: string
  specialization: string
}

export interface LaborByCost {
  maintainanceId: number
  maintainanceName: string
  maintainanceDate: string
  maintainanceStatus: string
  laborTask: string
  maintainanceCost: number
  firstName: string
  lastName: string
}

export interface CostByLocation {
  locationName: string
  locationCode: string
  totalCost: number
  totalTasks: number
}

// ── Mappers ──────────────────────────────────────────────────

export const toMaintainerBySkill = (row: MaintainerBySkillRow): MaintainerBySkill => ({
  maintainerId: row.maintainer_id,
  firstName: row.first_name,
  lastName: row.last_name,
  gender: row.gender,
  age: row.age,
  maintenanceSkill: row.maintainance_skill,
  skillDescription: row.skill_description,
  companyName: row.company_name,
  specialization: row.specialization,
})

export const toLaborByCost = (row: LaborByCostRow): LaborByCost => ({
  maintainanceId: row.maintainance_id,
  maintainanceName: row.maintainance_name,
  maintainanceDate: row.maintainance_date.toISOString(),
  maintainanceStatus: row.maintainance_status,
  laborTask: row.labor_task,
  maintainanceCost: Number(row.maintainance_cost),
  firstName: row.first_name,
  lastName: row.last_name,
})

export const toCostByLocation = (row: CostByLocationRow): CostByLocation => ({
  locationName: row.location_name,
  locationCode: row.location_code,
  totalCost: Number(row.total_cost),
  totalTasks: Number(row.total_tasks),
})
