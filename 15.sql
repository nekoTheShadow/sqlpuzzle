DROP TABLE IF EXISTS Salaries;

CREATE TABLE Salaries
(emp_name CHAR(10) NOT NULL,
 sal_date DATE NOT NULL,
 sal_amt DECIMAL (8,2) NOT NULL,
    PRIMARY KEY (emp_name, sal_date));

INSERT INTO Salaries VALUES ('トム', '1996-06-20', 500.00); 
INSERT INTO Salaries VALUES ('トム', '1996-08-20', 700.00); 
INSERT INTO Salaries VALUES ('トム', '1996-10-20', 800.00); 
INSERT INTO Salaries VALUES ('トム', '1996-12-20', 900.00); 
INSERT INTO Salaries VALUES ('ディック', '1996-06-20', 500.00); 
INSERT INTO Salaries VALUES ('ハリー','1996-07-20',500.00); 
INSERT INTO Salaries VALUES ('ハリー', '1996-09-20', 700.00); 

SELECT 
  emp_name,
  sal_date,
  sal_amt,
  LAG(sal_date) OVER (PARTITION BY emp_name ORDER BY sal_date) AS lst_sal_date,
  LAG(sal_amt)  OVER (PARTITION BY emp_name ORDER BY sal_date) AS lst_sal_amt
FROM Salaries;
