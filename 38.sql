DROP TABLE IF EXISTS Journal;

CREATE TABLE Journal
(acct_nbr INTEGER NOT NULL,
 trx_date DATE NOT NULL,
 trx_amt DECIMAL (10, 2) NOT NULL,
 duration INTEGER NOT NULL);

INSERT INTO Journal VALUES(1, '2007-01-01', 10, 0);
INSERT INTO Journal VALUES(1, '2007-01-02', 20, 0);
INSERT INTO Journal VALUES(1, '2007-01-04', 30, 0);
INSERT INTO Journal VALUES(2, '2007-01-07', 40, 0);
INSERT INTO Journal VALUES(2, '2007-01-11', 50, 0);
INSERT INTO Journal VALUES(3, '2007-01-20', 60, 0);
INSERT INTO Journal VALUES(4, '2007-01-01', 70, 0);
INSERT INTO Journal VALUES(4, '2007-01-02', 80, 0);

UPDATE Journal j1
SET duration = (
  SELECT COALESCE(j2.duration, 0)
  FROM (
    SELECT acct_nbr, trx_date, trx_date - LEAD(trx_date) OVER(PARTITION BY acct_nbr ORDER BY trx_date) AS duration
    FROM Journal
  ) j2
  WHERE j1.acct_nbr = j2.acct_nbr
  AND j1.trx_date = j2.trx_date
);

SELECT * FROM Journal
