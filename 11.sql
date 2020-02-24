    #query to find budget and expense of project region district and territory wise
SELECT budget.project_id, project_budget_by_rdt, budget.rdt,region_name,district_name,territory_name, project_expense
FROM
(
SELECT
PROJECT_ID,
rdt,
AMOUNT as project_budget_by_rdt
FROM mf_budget
)budget
LEFT JOIN
(
select
project_id, rdt, sum(expense_value) as project_expense
from mf_meeting m
LEFT join mf_expense_item e on m.meeting_id = e.meeting_id
group by project_id,rdt
)expense on budget.project_id = expense.project_id and budget.rdt=expense.rdt
LEFT JOIN (
    SELECT xpp.project_id, p.rdt, p.region_name, p.district_name, p.territory_name
    FROM xref_position_project xpp
    JOIN ref_position p ON xpp.position_id = p.position_id   
    ) po on budget.rdt = po.rdt AND budget.project_id = po.project_id
    where budget.project_id =323 and budget.rdt = ''
group by budget.project_id,budget.rdt,region_name,district_name,territory_name
order by budget.project_id,budget.rdt;
 