create or replace function total_actions_by_location(
 start_date date,
 end_date date
) returns table ("Location Name" text, "Total Actions Taken" bigint) 
language sql stable as
$$
select pl.name as "Location Name",
       count(pi.id) as "Total Actions Taken"
from PrisonerIncidents pi
join PrisonLocation pl on pi.prison_location_id = pl.id
where pi.incident_datetime between start_date and end_date
group by pl.name
order by "Total Actions Taken" DESC;
$$;

SELECT * from total_actions_by_location('2025-01-01', '2025-12-31');