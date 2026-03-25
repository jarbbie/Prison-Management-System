-- Author: Phurithip Paisanwaorajit 67070503437

-- Analysis QUERY
-- Calculate total confiscated items per prisoner intake.
-- This helps identify which intake has the highest number of confiscated items.

create or replace function total_confiscated_items_per_intake()
returns table (
    "Intake ID" int,
    "Prisoner Code" text,
    "Intake Date" date,
    "Total Items" int
)
language sql stable as
$$
select 
    pi.id as "Intake ID",
    p.code as "Prisoner Code",
    pi.intake_date as "Intake Date",
    sum(ci.quantity) as "Total Items"
from confiscateditem ci
join prisonerintake pi on ci.prisonerintake_id = pi.id
join prisoner p on p.prison_intake_id = pi.id
group by pi.id, p.code, pi.intake_date
order by "Total Items" desc;
$$;

-- call function
select * from total_confiscated_items_per_intake();