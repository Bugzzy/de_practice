-- ============================================
-- Урок 1: основы SQL (CREATE TABLE, INSERT, SELECT)
-- ============================================

-- 1. Создаём учебную таблицу
CREATE TABLE students (id INTEGER, name VARCHAR, city VARCHAR, age INTEGER, grade INTEGER);

-- 2. Наполняем данными
INSERT INTO students VALUES
 (1,'Аня','Москва',22,5),(2,'Борис','Казань',20,4),(3,'Вера','Москва',23,3),
 (4,'Глеб','Сочи',21,5),(5,'Дина','Казань',22,4);

-- 3. SELECT *: все столбцы
SELECT * FROM students;

-- 4. Выбрать только нужные столбцы
SELECT name, city FROM students;

-- 5. WHERE: фильтрация строк
SELECT name, age FROM students WHERE age >= 21;

-- 6. Комбинация условий
SELECT name, city, grade FROM students WHERE city = 'Москва' AND grade >= 4;

-- 7. Сортировка и ограничение
SELECT name, grade FROM students ORDER BY grade DESC LIMIT 3;


-- ============================================
-- Homework 2: SQL уроки 4–8 (WHERE, BETWEEN, IN, NULL)
-- ============================================

-- 1. Все из Москвы ИЛИ Казани — двумя способами

-- 1a. Через OR
SELECT * FROM students
WHERE city = 'Москва' OR city = 'Казань';

-- 1b. Через IN
SELECT * FROM students
WHERE city IN ('Москва', 'Казань');

-- 2. Возраст от 21 до 22 включительно (BETWEEN) и оценка не ниже 4
SELECT * FROM students
WHERE age BETWEEN 21 AND 22
  AND grade >= 4;

-- 3. Все, кто не из Сочи и не из Москвы (NOT IN с двумя значениями)
SELECT * FROM students
WHERE city NOT IN ('Сочи', 'Москва');

-- 4. Эксперимент про NULL
INSERT INTO students VALUES (6, 'Егор', 'Москва', 24, NULL);

SELECT * FROM students WHERE grade <> 3;
-- Егор НЕ появится: grade <> 3 при grade = NULL даёт UNKNOWN,
-- а WHERE оставляет только строки, где условие = TRUE.

-- Как включить Егора обратно (стандарт SQL):
SELECT * FROM students WHERE grade <> 3 OR grade IS NULL;
-- Короче в DuckDB (расширение, не стандарт):
SELECT * FROM students WHERE grade IS DISTINCT FROM 3;
EOF

