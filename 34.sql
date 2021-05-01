DROP TABLE IF EXISTS Consultants;
DROP TABLE IF EXISTS Billings;
DROP TABLE IF EXISTS HoursWorked;

CREATE TABLE Consultants
(emp_id INTEGER NOT NULL,
 emp_name CHAR(10) NOT NULL);

CREATE TABLE Billings
(emp_id INTEGER NOT NULL,
 bill_date DATE NOT NULL,
 bill_rate DECIMAL (5,2));

CREATE TABLE HoursWorked
(job_id INTEGER NOT NULL,
 emp_id INTEGER NOT NULL,
 work_date DATE NOT NULL,
 bill_hrs DECIMAL(5, 2));

INSERT INTO Consultants VALUES (1, 'Larry');
INSERT INTO Consultants VALUES (2, 'Moe');
INSERT INTO Consultants VALUES (3, 'Curly');

INSERT INTO Billings VALUES (1, '1990-01-01', 25.00);
INSERT INTO Billings VALUES (2, '1989-01-01', 15.00);
INSERT INTO Billings VALUES (3, '1989-01-01', 20.00);
INSERT INTO Billings VALUES (1, '1991-01-01', 30.00);

INSERT INTO HoursWorked VALUES (4, 1, '1990-07-01', 3);
INSERT INTO HoursWorked VALUES (4, 1, '1990-08-01', 5);
INSERT INTO HoursWorked VALUES (4, 2, '1990-07-01', 2);
INSERT INTO HoursWorked VALUES (4, 1, '1991-07-01', 4);

SELECT emp_name, SUM(bill_hrs * bill_rate)
FROM (
  SELECT 
    h.emp_id,
    c.emp_name,
    h.bill_hrs,
    b.bill_rate,
    RANK() OVER (PARTITION BY h.emp_id, h.work_date ORDER BY b.bill_date DESC) AS rnk
  FROM HoursWorked h
  JOIN Billings b
    ON h.emp_id = b.emp_id
    AND b.bill_date <= h.work_date
  JOIN Consultants c ON h.emp_id = c.emp_id
) AS t
WHERE rnk = 1
GROUP BY emp_id, emp_name

