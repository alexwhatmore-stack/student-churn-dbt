select
    r.student as student_id,
    l.subject_id,
    date(c.finish_at) as completed_date

from `interview-test-494014.student_analysis_tutorful.raw_churn_data` c

join `interview-test-494014.student_analysis_tutorful.raw_lessons` l
    on c.lesson_id = l.id

join `interview-test-494014.student_analysis_tutorful.raw_relationship` r
    on l.relationship_id = r.id

where c.status = 'completed'