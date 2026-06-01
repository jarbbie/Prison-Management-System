select 
  m.id as maintainer_id,
  p.first_name,
  p.last_name,
  p.age,
  p.gender,
  m.maintainance_skill,
  m.skill_description,
  p.contact_no,
  m.company_name,
  m.specialization
from maintainer m
join person p on p.id = m.person_id
where m.maintainance_skill = 'Electrical';
