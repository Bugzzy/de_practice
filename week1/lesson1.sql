-- 1. Создаём учебную таблицу (это наши "данные")
CREATE TABLE students (id INTEGER, name VARCHAR, city VARCHAR, age INTEGER, grade INTEGER);
INSERT INTO students VALUES
 (1,'Аня','Москва',22,5),(2,'Борис','Казань',20,4),(3,'Вера','Москва',23,3),
 (4,'Глеб','Сочи',21,5),(5,'Дина','Казань',22,4);

-- 2. SELECT: выбрать все столбцы
SELECT * FROM students;

-- 3. Выбрать только нужные столбцы
SELECT name, city FROM students;

-- 4. WHERE: фильтрация строк
SELECT name, age FROM students WHERE age >= 21;

-- 5. Комбинация условий
SELECT name, city, grade FROM students WHERE city = 'Москва' AND grade >= 4;

-- 6. Сортировка и ограничение
SELECT name, grade FROM students ORDER BY grade DESC LIMIT 3;

select name, age from students where age < 22;
select distinct city from students; 
select * from students where city not in ('Москва') order by name; 
