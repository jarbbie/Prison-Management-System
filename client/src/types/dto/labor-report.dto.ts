export const MAINTENANCE_SKILLS = [
  'Plumbing',
  'Electrical',
  'HVAC',
  'Carpentry',
  'Masonry',
  'Welding',
  'Locksmithing',
  'Painting',
  'General Maintenance',
] as const

export type MaintenanceSkill = (typeof MAINTENANCE_SKILLS)[number]

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
