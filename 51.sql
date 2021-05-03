DROP TABLE IF EXISTS Actual;
DROP TABLE IF EXISTS Budgeted;

CREATE TABLE Budgeted
(task INTEGER NOT NULL PRIMARY KEY,
 category INTEGER NOT NULL,
 est_cost DECIMAL(8,2) NOT NULL);

CREATE TABLE Actual
(voucher INTEGER NOT NULL PRIMARY KEY,
 task INTEGER NOT NULL REFERENCES Budgeted(task),
 act_cost DECIMAL(8,2) NOT NULL);

INSERT INTO Budgeted VALUES(1, 9100, 100.00);
INSERT INTO Budgeted VALUES(2, 9100,  15.00);
INSERT INTO Budgeted VALUES(3, 9100,   6.00);
INSERT INTO Budgeted VALUES(4, 9200,   8.00);
INSERT INTO Budgeted VALUES(5, 9200,  11.00);

INSERT INTO Actual VALUES(1,  1,  10.00);
INSERT INTO Actual VALUES(2,  1,  20.00);
INSERT INTO Actual VALUES(3,  1,  15.00);
INSERT INTO Actual VALUES(4,  2,  32.00);
INSERT INTO Actual VALUES(5,  4,  8.00);
INSERT INTO Actual VALUES(6,  5,  3.00);
INSERT INTO Actual VALUES(7,  5,  4.00);

SELECT b.category, SUM(b.est_cost), SUM(a.act_cost_total)
FROM Budgeted b
LEFT OUTER JOIN (
  SELECT task, SUM(act_cost) act_cost_total
  FROM Actual
  GROUP BY task
) a ON b.task = a.task
GROUP BY b.category

