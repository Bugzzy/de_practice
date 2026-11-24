-- ============================================
-- Lesson 2: агрегатные функции, GROUP BY, HAVING
-- ============================================

-- 1. Средняя оценка по каждому городу
SELECT 
    city, 
    ROUND(AVG(grade), 2) AS avg_grade
FROM students
GROUP BY city
ORDER BY city;

-- 2. Города, где средняя оценка строго больше 4
-- (HAVING работает после агрегации; AVG игнорирует NULL, поэтому Егор не ломает среднюю)
SELECT city
FROM students
GROUP BY city
HAVING AVG(grade) > 4;

-- 3. Для каждого города: всего студентов, с известной оценкой, средняя оценка
-- COUNT(*) vs COUNT(grade) → разница = число NULL в grade (Егор)
SELECT 
    city,
    COUNT(*)             AS students_total,
    COUNT(grade)         AS grades_known,
    ROUND(AVG(grade), 2) AS avg_grade
FROM students
GROUP BY city
ORDER BY city;

-- Пояснение к заданию 3:
-- COUNT(*) = все строки группы (включая NULL)
-- COUNT(grade) = только не-NULL значения grade
-- AVG(grade) = тоже игнорирует NULL → не сломается на Егоре
