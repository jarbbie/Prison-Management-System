-- Author: Phurithip Paisanwaorajit 67070503437

-- Simple QUERY
-- List confiscated items for each prisoner intake.
-- Output includes prisoner code, intake date, item name, quantity, and remarks.

create or replace function list_confiscated_items()
returns table (
    "Prisoner Code" text,
    "Intake Date" date,
    "Item Name" text,
    "Quantity" int,
    "Remarks" text
)
language sql stable as
$$
select 
    p.code as "Prisoner Code",
    pi.intake_date as "Intake Date",
    ci.item_name as "Item Name",
    ci.quantity as "Quantity",
    ci.remarks as "Remarks"
from confiscateditem ci
join prisonerintake pi on ci.prisonerintake_id = pi.id
join prisoner p on p.prison_intake_id = pi.id
order by pi.intake_date desc, ci.item_name asc;
$$;

-- call function
select * from list_confiscated_items();