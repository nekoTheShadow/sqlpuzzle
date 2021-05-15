DROP TABLE IF EXISTS Foobar;

CREATE TABLE Foobar (
  empl_id CHAR(6) NOT NULL, 
  pin_num CHAR(5) NOT NULL,
  empl_rcd INTEGER NOT NULL,
  calc_rslt_val INTEGER NOT NULL,
  calc_adj_val INTEGER NOT NULL,
  unit_rslt_val INTEGER NOT NULL,
  unit_adj_val INTEGER NOT NULL,
  PRIMARY KEY (empl_id, pin_num)
);

INSERT INTO Foobar VALUES('xxxxxx', '52636', 0, 10, 20, 30, 40);
INSERT INTO Foobar VALUES('xxxxxx', '52751', 0,  5,  6,  7,  8);
INSERT INTO Foobar VALUES('xxxxxx', '52768', 0, 20, 40, 60, 80);

-- 問題でやろうとしていることをJOINなしで実現
SELECT 
  SUM(CASE WHEN pin_num = '52636' THEN calc_rslt_val + calc_adj_val END),
  SUM(CASE WHEN pin_num = '52636' THEN unit_rslt_val + unit_adj_val END),
  SUM(CASE WHEN pin_num = '52751' THEN calc_rslt_val + calc_adj_val END),
  SUM(CASE WHEN pin_num = '52751' THEN unit_rslt_val + unit_adj_val END),
  SUM(CASE WHEN pin_num = '52768' THEN calc_rslt_val + calc_adj_val END),
  SUM(CASE WHEN pin_num = '52768' THEN unit_rslt_val + unit_adj_val END)
FROM Foobar
WHERE empl_id = 'xxxxxx'
AND pin_num IN ('52636','52751','52768')
AND empl_rcd = 0;

-- その3と同じ。
SELECT 
  pin_num,
  SUM(calc_rslt_val + calc_adj_val),
  SUM(unit_rslt_val + unit_adj_val)
FROM Foobar
WHERE empl_id = 'xxxxxx'
AND pin_num IN ('52636','52751','52768')
AND empl_rcd = 0
GROUP BY pin_num;
