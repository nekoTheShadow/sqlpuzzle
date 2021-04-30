DROP TABLE IF EXISTS Personnel;
DROP TABLE IF EXISTS ExcuseList;
DROP TABLE IF EXISTS Absenteeism;

CREATE TABLE Personnel
 (emp_id INTEGER NOT NULL PRIMARY KEY);

CREATE TABLE ExcuseList
 ( reason_code CHAR (40) NOT NULL PRIMARY KEY);

CREATE TABLE Absenteeism (
  emp_id INTEGER NOT NULL , 
  absent_date DATE NOT NULL, 
  reason_code CHAR (40) NOT NULL , 
  severity_points INTEGER NOT NULL CHECK (severity_points BETWEEN 0 AND 4), 
  PRIMARY KEY (emp_id, absent_date)); 

INSERT INTO Personnel VALUES(1);
INSERT INTO Personnel VALUES(2);

INSERT INTO Absenteeism VALUES(1, '2007-05-01', 'ずる', 4);
INSERT INTO Absenteeism VALUES(1, '2007-05-02', '病気', 2);   --0になる
INSERT INTO Absenteeism VALUES(1, '2007-05-03', '病気', 2);   --0になる
INSERT INTO Absenteeism VALUES(1, '2007-05-05', 'ケガ', 1);
INSERT INTO Absenteeism VALUES(1, '2007-05-06', '病気', 3);   --0になる
INSERT INTO Absenteeism VALUES(2, '2007-05-01', 'ずる', 4);
INSERT INTO Absenteeism VALUES(2, '2007-05-03', '病気', 2);
INSERT INTO Absenteeism VALUES(2, '2007-05-05', 'サボリ', 2);
INSERT INTO Absenteeism VALUES(2, '2007-05-06', 'サボリ', 2); --0になる

UPDATE Absenteeism a1
SET severity_points = 0
WHERE EXISTS (
  SELECT * 
  FROM Absenteeism a2
  WHERE a1.emp_id = a2.emp_id
  AND a1.absent_date - INTERVAL '1' DAY = a2.absent_date
);


DELETE FROM Personnel p
WHERE 40 <= ANY (
  SELECT SUM(a1.severity_points)
  FROM Absenteeism a1
  JOIN Absenteeism a2
    ON p.emp_id = a1.emp_id
    AND a1.emp_id = a2.emp_id
    AND a1.absent_date <= a2.absent_date
    AND a2.absent_date < a1.absent_date + INTERVAL '1' YEAR
  GROUP BY a1.absent_date
);


