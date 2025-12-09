DROP TABLE IF EXISTS staff;
 
CREATE TABLE staff (
staff_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
salary DECIMAL(10, 3)
);

INSERT INTO staff (staff_id, first_name, last_name, salary)
VALUES	(1, 'Alex', 'Miller', 55000.123),
		(2, 'Emily', 'Johnson', 60000.456),
		(3, 'Max', 'Smith', 70000.789),
		(4, 'Sophia', 'Brown', 48000.321),
		(5, 'Oliver', 'Davis', 72000.000);
        
--  Add a new column to the staff table
ALTER TABLE staff
ADD COLUMN hire_date DATE;

--insert data to this column
UPDATE staff
SET hire_date = '2000-01-12'
WHERE staff_id = 1;

UPDATE staff
SET hire_date = '2007-08-06'
WHERE staff_id=2;

UPDATE staff
SET hire_date = '2005-03-06'
WHERE staff_id=3;

UPDATE staff
SET hire_date = '1998-12-18'
WHERE staff_id=4;

UPDATE staff
SET hire_date = '1997-09-11'
WHERE staff_id=5;

--were hired after January 8, 2000
--SELECT * FROM staff
--WHERE hire_date > '2000-01-08';

SELECT LOWER(first_name) as lower_case
FROM staff;

SELECT 
	staff_id, 
	hire_date, 
	CASE 
    	WHEN staff_id = 1 THEN DATE(hire_date, '+10 days') 
		ELSE hire_date 
	END as new_date
FROM staff;

SELECT *, strftime('%m', hire_date), SUBSTR('JanFebMarAprMayJunJulAugSepOctNovDec', 1 + 3 * CAST(STRFTIME('%m', hire_date) AS INTEGER) - 3, 3)
FROM staff;

SELECT STRFTIME('%Y%W', 'now') AS year_week;
