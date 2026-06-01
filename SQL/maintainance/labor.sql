select
  ma.id as maintainance_id,
  ma.maintainance_name,
  ma.maintainance_date,
  ma.status as maintainance_status,
  l.labor_task,
  ma.maintainance_cost,
  p.first_name,
  p.last_name
from labor l
join maintainance ma ON ma.id = l.maintainance_id
join maintainer m ON m.id = l.maintainer_id
join person p ON p.id = m.person_id
where ma.maintainance_cost >= 500 and ma.maintainance_date >= '2023-12-01' and ma.maintainance_date <= '2023-12-15';
