-- ============================================
-- Lesson 4: подзапросы, CTE, UNION
-- ============================================

-- Задание 1: починить бонус через CTE (дедупликация cities)
WITH dedup_cities AS (
    SELECT DISTINCT city, population FROM cities
)
SELECT s.name, s.city, c.population
FROM students s
JOIN dedup_cities c ON s.city = c.city;
-- prediction: по Москве снова 3 студента, всего 6 строк

-- Задание 2: студенты с оценкой выше средней
SELECT * FROM students
WHERE grade > (SELECT AVG(grade) FROM students);
-- prediction: 2 строки (Аня 5, Глеб 5). Егор не проходит: NULL > AVG = UNKNOWN

-- Задание 3: скалярный подзапрос в SELECT
SELECT name, grade,
       grade - (SELECT AVG(grade) FROM students) AS diff
FROM students
ORDER BY name;
-- prediction: у Егора diff = NULL, потому что арифметика с NULL всегда даёт NULL

-- Задание 4: UNION vs UNION ALL
SELECT city FROM students
UNION
SELECT city FROM cities;
-- prediction: 4 уникальных города (Москва, Казань, Сочи, Самара)

SELECT city FROM students
UNION ALL
SELECT city FROM cities;
-- prediction: 11 строк = 6 (students) + 5 (cities, Москва дважды)

-- Задание 5: CTE дважды в одном запросе
WITH m AS (
    SELECT city, COUNT(*) AS cnt FROM students GROUP BY city
)
SELECT a.city, b.city
FROM m a
JOIN m b ON a.cnt = b.cnt
WHERE a.city < b.city;
-- prediction: пары городов с одинаковым числом студентов; a.city < b.city убирает зеркальные пары
-- выполнится ли CTE дважды — зависит от СУБД (в DuckDB материализуется один раз)

-- ============================================
-- Письменные ответы
-- ============================================

-- 6а. UNION vs UNION ALL
-- UNION возвращает уникальные значения (делает DISTINCT), UNION ALL — все строки.
-- UNION дороже: дедупликация через сортировку или хеш-таблицу (доп. проход по результату).
-- В ETL берут UNION ALL: дешевле, а дедупликацию делают явным шагом с контролем.

-- 6б. Зачем WITH, если есть подзапрос
-- 1) Читаемость: CTE читается сверху вниз, подзапросы вкладываются «лапшой».
-- 2) Переиспользование: один CTE можно использовать несколько раз в запросе.
-- 3) Рекурсия: WITH RECURSIVE — единственный способ обойти иерархию в стандартном SQL.

WITH m AS (SELECT city, COUNT(*) AS cnt FROM students GROUP BY city)
SELECT a.city, b.city FROM m a JOIN m b ON a.cnt = b.cnt WHERE a.city < b.city;
-- Ожидаем: 0 строк (пусто)
-- prediction: 0 строк — у городов 3/2/1 студентов, совпадений по cnt нет
