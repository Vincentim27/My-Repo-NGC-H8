CREATE TABLE teachers(
  id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  first_name varchar (25)Not Null,
  last_name varchar (50),
  school varchar (50) Not Null,
  hire_date date,
  salary numeric
)

INSERT INTO teachers (id,first_name, last_name, school, hire_date, salary)
    VALUES (1,'Janet', 'Smith', 'MIT', '2011-10-30', 36200),
           (2,'Lee', 'Reynolds', 'MIT', '1993-05-22', 65000),
           (3,'Samuel', 'Cole', 'Cambridge University', '2005-08-01', 43500),
           (4,'Samantha', 'Bush', 'Cambridge University', '2011-10-30', 36200),
           (5,'Betty', 'Diaz', 'Cambridge University', '2005-08-30', 43500),
           (6,'Kathleen', 'Roush', 'MIT', '2010-10-22', 38500),
           (7,'James', 'Diaz', 'Harvard University', '2003-07-18', 61000),
           (8,'Zack', 'Smith', 'Harvard University', '2000-12-29', 55500),
           (9,'Luis', 'Gonzales', 'Standford University', '2002-12-01', 50000),
           (10,'Frank', 'Abbers', 'Standford University', '1999-01-30', 66000);
           
INSERT INTO teachers (first_name, last_name, school, hire_date, salary)
    VALUES ('Samuel', 'Abbers', 'Standford University', '2006-01-30', 32000),
           ('Jessica', 'Abbers', 'Standford University', '2005-01-30', 33000),
           ('Tom', 'Massi', 'Harvard University', '1999-09-09', 39500),
           ('Esteban', 'Brown', 'MIT', '2007-01-30', 36000),
           ('Carlos', 'Alonso', 'Standford University', '2001-01-30', 44000);
      
SELECT * from teachers
TRUNCATE teachers #Menghapus data teachers dan mereset AUTO_INCREMENT     
           
CREATE TABLE courses(
  id int NOT null PRIMARY KEY AUTO_INCREMENT,
  name varchar (20),
  teachers_id int,
  total_students int
 )

SELECT * from courses

INSERT INTO courses (name, teachers_id, total_students)
    VALUES  ('Calculus', 2, 20),
            ('Physics', 2, 10),
            ('Calculus', 1, 30),
            ('Computer Science', 1, 20),
            ('Politic', 13, 15),
            ('Algebra', 2, 10),
            ('Algebra', 13, 30),
            ('Computer Science', 10, 35),
            ('Life Science', 11, 20),
            ('Chemistry', 9, 22),
            ('Chemistry', 8, 16),
            ('Calculus', 5, 19),
            ('Politic', 4, 17),
            ('Biology', 6, 22),
            ('Physics', 3, 29),
            ('Biology', 8, 28),
            ('Calculus', 12, 34),
            ('Physics', 13, 34),
            ('Biology', 14, 25),
            ('Calculus', 15, 20);

-- No. 0
-- Carilah dosen yang memiliki gaji tertinggi per masing-masing mata kuliah. 
-- Tampilkan semua atribut dosen dan semua atribut mata kuliahnya. 
-- Urutkan hasilnya berdasarkan nama mata kuliahnya secara ascending (A-Z).
SELECT * FROM teachers
JOIN courses ON teachers.id = courses.teachers_id
Where (courses.name, teachers.salary) IN (
	#Mencari Nama Courses dan Gaji tertinggi
  SELECT courses.name, MAX(teachers.salary) FROM teachers
  Join courses ON teachers.id = courses.teachers_id
  GROUP by courses.name
)
OrDER BY courses.name


-- No.1 
select b.first_name, mx.* 
from (SELECT school,
max(salary) AS max_sal
from teachers
group by school) AS mx
join teachers b
on mx.max_sal=b.salary 
and mx.school=b.school

-- No.2 Who is the teacher with the highest salary from Standford University
select b.first_name, mx.* 
from (SELECT school,
max(salary) AS max_sal
from teachers
group by school) AS mx
join teachers b
on mx.max_sal=b.salary 
and mx.school=b.school
WHERE mx.school="Standford University"

-- No.3 Display all courses with teacher's identity
SELECT * FROM teachers
LEFT JOIN courses
  ON teachers.id = courses.teachers_id
  where teachers_id is not null
  order by school

SELECT teachers.*,courses.name
FROM teachers
LEFT JOIN courses
  ON teachers.id = courses.teachers_id
  where teachers_id is not null
  order by school

-- No.4 Display how many courses per universities
SELECT cr.school, count(name) AS jmlh_courses
from
(SELECT distinct courses.name, school
FROM teachers
LEFT JOIN courses
  ON teachers.id = courses.teachers_id
  where teachers_id is not null
) AS cr
group by school

-- No.5 Display how many total_students per teachers
select cr.first_name, sum(total_students) jmlh_student
from
(SELECT distinct courses.total_students, first_name
FROM teachers
LEFT JOIN courses
  ON teachers.id = courses.teachers_id
  where teachers_id is not null
) cr
group by first_name
