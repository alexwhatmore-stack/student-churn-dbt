select
    subject_id,

    count(*) as total_lessons,

    sum(case when days_since_last_lesson >= 30 then 1 else 0 end) as churn_events,

    safe_divide(
        sum(case when days_since_last_lesson >= 30 then 1 else 0 end),
        count(*)
    ) as churn_rate

from {{ ref('int_subject_gaps') }}

group by 1
order by churn_rate desc