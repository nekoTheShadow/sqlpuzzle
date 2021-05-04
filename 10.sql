DROP TABLE IF EXISTS Pensions;

CREATE TABLE Pensions
(sin CHAR(10) NOT NULL,
 pen_year INTEGER NOT NULL,
 month_cnt INTEGER DEFAULT 0 NOT NULL
      CHECK (month_cnt BETWEEN 0 AND 12),
 earnings DECIMAL(8,2) DEFAULT 0.00 NOT NULL);

--○1番：1年間はたらかなった後、5年間フルに働いた
INSERT INTO Pensions VALUES('1', 2006, 12, 10);
INSERT INTO Pensions VALUES('1', 2005, 12, 10);
INSERT INTO Pensions VALUES('1', 2004, 12, 10);
INSERT INTO Pensions VALUES('1', 2003, 12, 10);
INSERT INTO Pensions VALUES('1', 2002, 12, 10);
INSERT INTO Pensions VALUES('1', 2001,  0,  0);

--○2番：10ヶ月 * 6年間
INSERT INTO Pensions VALUES('2', 2006, 10, 1);
INSERT INTO Pensions VALUES('2', 2005, 10, 1);
INSERT INTO Pensions VALUES('2', 2004, 10, 1);
INSERT INTO Pensions VALUES('2', 2003, 10, 1);
INSERT INTO Pensions VALUES('2', 2002, 10, 1);
INSERT INTO Pensions VALUES('2', 2001, 10, 1);

--×3番：10ヶ月 * 3年間, 1年休み, 10ヶ月 *  3
INSERT INTO Pensions VALUES('3', 2006, 10, 1);
INSERT INTO Pensions VALUES('3', 2005, 10, 1);
INSERT INTO Pensions VALUES('3', 2004, 10, 1);
INSERT INTO Pensions VALUES('3', 2003,  0, 0);
INSERT INTO Pensions VALUES('3', 2002, 10, 1);
INSERT INTO Pensions VALUES('3', 2001, 10, 1);
INSERT INTO Pensions VALUES('3', 2000, 10, 1);


--×4番：10ヶ月 * 1年間, 1年休み, 10ヶ月 *  5 + 9ヶ月
INSERT INTO Pensions VALUES('4', 2007,  9, 1);
INSERT INTO Pensions VALUES('4', 2006, 10, 1);
INSERT INTO Pensions VALUES('4', 2005, 10, 1);
INSERT INTO Pensions VALUES('4', 2004, 10, 1);
INSERT INTO Pensions VALUES('4', 2003, 10, 1);
INSERT INTO Pensions VALUES('4', 2002, 10, 1);
INSERT INTO Pensions VALUES('4', 2001,  0, 0);
INSERT INTO Pensions VALUES('4', 2000, 10, 1);

--○5番：10ヶ月 * 1年間, 1年休み, 10ヶ月 *  6
INSERT INTO Pensions VALUES('5', 2007, 10, 1);
INSERT INTO Pensions VALUES('5', 2006, 10, 1);
INSERT INTO Pensions VALUES('5', 2005, 10, 1);
INSERT INTO Pensions VALUES('5', 2004, 10, 1);
INSERT INTO Pensions VALUES('5', 2003, 10, 1);
INSERT INTO Pensions VALUES('5', 2002, 10, 1);
INSERT INTO Pensions VALUES('5', 2001,  0, 0);
INSERT INTO Pensions VALUES('5', 2000, 10, 1);

--×6番：12ヶ月 * 4年間, 1年休み
INSERT INTO Pensions VALUES('6', 2004, 0, 1);
INSERT INTO Pensions VALUES('6', 2003, 12, 1);
INSERT INTO Pensions VALUES('6', 2002, 12, 1);
INSERT INTO Pensions VALUES('6', 2001, 12, 0);
INSERT INTO Pensions VALUES('6', 2000, 12, 1);

SELECT 
  sin,
  MIN(pen_year) AS start_year,
  MAX(pen_year) AS end_year,
  SUM(earnings) AS sumofearning
FROM (
  SELECT *, SUM(month_cnt) OVER (PARTITION BY sin ORDER BY pen_year DESC) - month_cnt AS month_tot
  FROM Pensions
) t
WHERE month_tot < 60 AND month_cnt > 0
GROUP BY sin
HAVING MAX(pen_year) - MIN(pen_year) + 1 = COUNT(*)
AND SUM(month_cnt) >= 60;

