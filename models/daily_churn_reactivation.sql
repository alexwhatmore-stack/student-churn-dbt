select
    completed_date as day,

    sum(churn_event) as churn,
    sum(reactivation_event) as reactivation

from {{ ref('fct_churn_reactivation') }}

where completed_date between '2026-02-01' and '2026-02-28'

group by 1
order by 1