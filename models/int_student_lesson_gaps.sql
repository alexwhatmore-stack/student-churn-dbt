with base as (
    select
        student_id,
        completed_date,
        lag(completed_date) over (
            partition by student_id
            order by completed_date
        ) as previous_date
    from {{ ref('stg_lessons') }}
)

select
    *,
    date_diff(completed_date, previous_date, day) as days_since_last_lesson
from base