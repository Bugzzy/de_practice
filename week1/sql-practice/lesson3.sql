-- ============================================
-- Lesson 3: JOIN (INNER, LEFT, ловушка с дублями)
-- ============================================

-- Вторая таблица: города и население
CREATE TABLE cities (city VARCHAR, population INTEGER);
INSERT INTO cities VALUES
 ('Москва', 13000000), ('Казань', 1300000),
 ('Сочи', 460000), ('Самара', 1100000);

-- 1. INNER JOIN: только совпадения по city
-- Ожидаем 6 строк (3 Москва + 2 Казань + 1 Сочи); Самара не попадёт
SELECT s.name, s.city, c.population
FROM students s
JOIN cities c ON s.city = c.city;

-- 2. LEFT JOIN от cities: все города + совпадения
-- Ожидаем 7 строк (Самара останется, колонки students = NULL)
SELECT c.city, c.population, s.name, s.age, s.grade
FROM cities c
LEFT JOIN students s ON c.city = s.city;

-- 3. LEFT JOIN от students: все студенты, даже без города в cities
-- Ожидаем 6 строк (никто не потерян)
SELECT s.name, s.city, c.population
FROM students s
LEFT JOIN cities c ON s.city = c.city;

-- 4. Бонус: ловушка с дублем Москвы в cities
-- После INSERT второй Москвы INNER JOIN даст 9 строк вместо 6:
-- каждый московский студент размножается на 2 строки cities.
INSERT INTO cities VALUES ('Москва', 13000000);

SELECT COUNT(*) AS rows_total, COUNT(DISTINCT s.id) AS students_distinct
FROM students s
JOIN cities c ON s.city = c.city;
-- rows_total = 9, students_distinct = 6 → COUNT(*) «врёт» из-за дублей

-- 5. Как починить: схлопнуть дубли в правой таблице до JOIN
SELECT s.name, c.population
FROM students s
JOIN (SELECT DISTINCT city, population FROM cities) c
  ON s.city = c.city;
-- Теперь 6 строк, COUNT(*) честный
