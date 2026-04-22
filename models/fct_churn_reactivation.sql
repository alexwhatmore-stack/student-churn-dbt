-- purpose: identify churn and reactivation events based on lesson inactivity
-- churn_event: gap between lessons >= 30 days
-- reactivation_event: first lesson after a 30+ day gap

with base as (
    select
        student_id,
        completed_date,
        days_since_last_lesson,

        lag(days_since_last_lesson) over (
            partition by student_id
            order by completed_date
        ) as previous_gap

    from {{ ref('int_student_lesson_gaps') }}
)

select
    student_id,
    completed_date,
    days_since_last_lesson,

    case 
        when days_since_last_lesson >= 30 then 1 
        else 0 
    end as churn_event,

    case 
        when previous_gap >= 30 then 1 
        else 0 
    end as reactivation_event

from base