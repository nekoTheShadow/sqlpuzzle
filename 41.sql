DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Actuals;
DROP TABLE IF EXISTS Estimates;

CREATE TABLE Items
(item_nbr INTEGER,
 item_descr CHAR(10));

CREATE TABLE Actuals
(item_nbr   INTEGER, 
 actual_amt DECIMAL(5,2),
 check_nbr  CHAR(4));

CREATE TABLE Estimates
(item_nbr      INTEGER, 
 estimated_amt DECIMAL(5,2));

INSERT INTO Items VALUES(10, 'Item 10');
INSERT INTO Items VALUES(20, 'Item 20');
INSERT INTO Items VALUES(30, 'Item 30');
INSERT INTO Items VALUES(40, 'Item 40');
INSERT INTO Items VALUES(50, 'item 50');

INSERT INTO Actuals VALUES(10, 300.00, '1111');
INSERT INTO Actuals VALUES(20, 325.00, '2222');
INSERT INTO Actuals VALUES(20, 100.00, '3333');
INSERT INTO Actuals VALUES(30, 525.00, '1111');

INSERT INTO Estimates VALUES(10, 300.00);
INSERT INTO Estimates VALUES(10, 50.00);
INSERT INTO Estimates VALUES(20, 325.00);
INSERT INTO Estimates VALUES(20, 110.00);
INSERT INTO Estimates VALUES(40, 25.00);

SELECT
  i.item_nbr,
  i.item_descr,
  a.actual_tot,
  e.estimate_tot,
  a.check_nbr
FROM Items i
LEFT OUTER JOIN (
  SELECT item_nbr, SUM(estimated_amt)
  FROM Estimates
  GROUP BY item_nbr
) e (item_nbr, estimate_tot) ON i.item_nbr = e.item_nbr
LEFT OUTER JOIN (
  SELECT item_nbr, SUM(actual_amt), CASE WHEN COUNT(*) > 1 THEN 'Mixed' ELSE MAX(check_nbr) END
  FROM Actuals
  GROUP BY item_nbr
) a (item_nbr, actual_tot, check_nbr) ON i.item_nbr = a.item_nbr
WHERE e.estimate_tot IS NOT NULL OR a.actual_tot IS NOT NULL
