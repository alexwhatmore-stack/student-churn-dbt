select
    student_id,
    completed_date,
    days_since_last_lesson,

    case 
        when days_since_last_lesson >= 30 then 1 
        else 0 
    end as churn_event,

    case 
        when days_since_last_lesson >= 30
         and lag(days_since_last_lesson) over (
                partition by student_id
                order by completed_date
            ) < 30
        then 1 else 0
    end as reactivation_event

from {{ ref('int_student_lesson_gaps') }}