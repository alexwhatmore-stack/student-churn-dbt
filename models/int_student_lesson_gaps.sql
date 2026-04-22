select
    student_id,
    completed_date,

    lag(completed_date) over (
        partition by student_id
        order by completed_date
    ) as previous_date,

    date_diff(
        completed_date,
        lag(completed_date) over (
            partition by student_id
            order by completed_date
        ),
        day
    ) as days_since_last_lesson

from {{ ref('stg_lessons') }}