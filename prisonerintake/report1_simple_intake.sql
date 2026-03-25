-- Author: Phurithip Paisanwaorajit 67070503437

-- Simple QUERY
-- List all prisoner intake records including prisoner code, full name,
-- intake date, and initial health status.

create or replace function list_prisoner_intakes()
returns table (
    "Prisoner Code" text,
    "Prisoner Name" text,
    "Intake Date" date,
    "Initial Health Status" text
)
language sql stable as
$$
select 
    p.code as "Prisoner Code",
    pe.first_name || ' ' || pe.last_name as "Prisoner Name",
    pi.intake_date as "Intake Date",
    pi.initial_health_status as "Initial Health Status"
from prisoner p
join person pe on p.person_id = pe.id
join prisonerintake pi on p.prison_intake_id = pi.id
order by pi.intake_date desc;
$$;

-- call function
select * from list_prisoner_intakes();