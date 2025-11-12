DROP TABLE IF EXISTS Tutor;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Takes;
DROP TABLE IF EXISTS Teaches;

-- Tutor table
CREATE TABLE Tutor (
  tid INTEGER PRIMARY KEY,
  t_fname VARCHAR(50) NOT NULL,
  t_lname VARCHAR(50) NOT NULL,
  hourly_wage DECIMAL(10,2) NOT NULL
);

-- Student table
CREATE TABLE Student (
  sid INTEGER PRIMARY KEY,
  s_fname VARCHAR(50) NOT NULL,
  s_lname VARCHAR(50) NOT NULL,
  address VARCHAR(200),
  city VARCHAR(100)
);

-- Course table
CREATE TABLE Course (
  course_code VARCHAR(20) PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  credit INTEGER NOT NULL,
  semester VARCHAR(20) NOT NULL
);

-- Takes associative table (student takes course)
CREATE TABLE Takes (
  sid INTEGER NOT NULL,
  course_code VARCHAR(20) NOT NULL,
  PRIMARY KEY (sid, course_code),
  FOREIGN KEY (sid) REFERENCES Student(sid),
  FOREIGN KEY (course_code) REFERENCES Course(course_code)
);

-- Teaches association (tutor teaches course)
CREATE TABLE Teaches (
  tid INTEGER NOT NULL,
  course_code VARCHAR(20) NOT NULL,
  hours INTEGER NOT NULL,
  PRIMARY KEY (tid, course_code),
  FOREIGN KEY (tid) REFERENCES Tutor(tid),
  FOREIGN KEY (course_code) REFERENCES Course(course_code)
);

-- Tutors
INSERT INTO Tutor (tid, t_fname, t_lname, hourly_wage) 
VALUES
  (1, 'Alex', 'Jackson', 40),
  (2, 'David', 'Lewis', 10),
  (3, 'Sue', 'White', 20);

-- Students
INSERT INTO Student (sid, s_fname, s_lname, address, city) 
VALUES
  (1111, 'Jane', 'Morgan', 'Yasemin sokak, Gonyeli', 'Nicosia'),
  (2222, 'Katie', 'Smith', 'Gul sokak, Hamitkoy', 'Kyrenia'),
  (3333, 'Leslie', 'Carr', 'Zeytin sokak, Catalkoy', 'Kyrenia'),
  (4444, 'Max', 'McKane', 'Lale sokak, Küçükkaymaklı', 'Nicosia');

-- Courses
INSERT INTO Course (course_code, title, credit, semester) 
VALUES
  ('CMPE343', 'DBMS I', 4, 'Fall'),
  ('CMPE344', 'DBMS II', 4, 'Spring'),
  ('MATH101', 'Calculus I', 4, 'Fall'),
  ('MATH121', 'Linear Algebra', 2, 'Fall'),
  ('CMPE214', 'Visual Programming', 3, 'Spring');

-- Takes
INSERT INTO Takes (sid, course_code) 
VALUES
  (1111, 'CMPE343'),
  (1111, 'CMPE214'),
  (2222, 'MATH101'),
  (2222, 'MATH121'),
  (4444, 'CMPE214'),
  (4444, 'CMPE344');

-- Teaches
INSERT INTO Teaches (tid, course_code, hours) 
VALUES
  (1, 'CMPE343', 3),
  (1, 'CMPE344', 3),
  (2, 'MATH101', 3),
  (2, 'MATH121', 2),
  (3, 'CMPE214', 3);

SELECT *
FROM Student s
JOIN Takes t ON s.sid = t.sid
JOIN Course c ON t.course_code = c.course_code
WHERE c.title LIKE '%DBMS%';

SELECT t_lname
FROM Tutor
WHERE hourly_wage > 15;

SELECT s_fname
FROM Student
WHERE LOWER(address) LIKE '%koy%';

SELECT course_code
FROM Takes
WHERE sid = 1111;

SELECT s_fname, s_lname, address
FROM Student
WHERE city = 'Nicosia';

SELECT course_code
FROM Course
WHERE credit = 4
AND semester = 'Spring';

SELECT DISTINCT course_code
FROM Teaches
WHERE "hours" = 2;

ALTER TABLE Student
ADD COLUMN CGPA FLOAT;

UPDATE Student SET CGPA = 2.88 WHERE sid = 1111;
UPDATE Student SET CGPA = 3.14 WHERE sid = 2222;
UPDATE Student SET CGPA = 2.05 WHERE sid = 3333;
UPDATE Student SET CGPA = 3.77 WHERE sid = 4444;

SELECT sid, s_fname, s_lname, CGPA
FROM Student
ORDER BY sid;
