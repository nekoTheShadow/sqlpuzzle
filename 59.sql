DROP TABLE IF EXISTS Timesheets;

CREATE TABLE Timesheets
(task_id CHAR(10) NOT NULL PRIMARY KEY,
 start_date DATE NOT NULL,
 end_date DATE NOT NULL,
    CHECK(start_date <= end_date));

INSERT INTO Timesheets VALUES (1, '1997-01-01', '1997-01-03');
INSERT INTO Timesheets VALUES (2, '1997-01-02', '1997-01-04');
INSERT INTO Timesheets VALUES (3, '1997-01-04', '1997-01-05');
INSERT INTO Timesheets VALUES (4, '1997-01-06', '1997-01-09');
INSERT INTO Timesheets VALUES (5, '1997-01-09', '1997-01-09');
INSERT INTO Timesheets VALUES (6, '1997-01-09', '1997-01-09');
INSERT INTO Timesheets VALUES (7, '1997-01-12', '1997-01-15');
INSERT INTO Timesheets VALUES (8, '1997-01-13', '1997-01-14');
INSERT INTO Timesheets VALUES (9, '1997-01-14', '1997-01-14');
INSERT INTO Timesheets VALUES (10, '1997-01-17', '1997-01-17');
INSERT INTO Timesheets VALUES (11, '1997-01-01', '1997-01-17');


-- ‚ ‚Á‚Ä‚¢‚é‚Ì‚©?
WITH RECURSIVE a (src_task_id, dst_task_id, dst_start_date, dst_end_date) AS (
    SELECT task_id, task_id, start_date, end_date FROM Timesheets
  UNION ALL
    SELECT a.src_task_id, t.task_id, t.start_date, t.end_date
    FROM a
    JOIN Timesheets t 
        ON a.dst_task_id < t.task_id
        AND a.dst_start_date <= t.end_date 
        AND a.dst_end_date >= t.start_date
)
SELECT MIN(start_date), MAX(end_date)
FROM Timesheets t
GROUP BY (
  SELECT MAX(dst_task_id) 
  FROM a
  WHERE src_task_id IN (SELECT src_task_id FROM a WHERE a.dst_task_id = t.task_id));

-- ‚»‚Ì3‚ªˆê”Ô‚æ‚³‚»‚¤?
-- http://mickindex.sakura.ne.jp/database/celko/celko_se.html ‚©‚çƒRƒsƒy
SELECT start_date, MIN(end_date)
FROM ( 
  SELECT T1.start_date,T2.end_date
  FROM Timesheets T1, Timesheets T2, Timesheets T3
  WHERE T1.end_date <= T2.end_date    
  GROUP BY T1.start_date, T2.end_date
  HAVING COUNT(CASE WHEN (T1.start_date > T3.start_date AND T1.start_date <= T3.end_date)
                      OR (T2.end_date >= T3.start_date AND T2.end_date < T3.end_date) THEN 1 END) = 0 
) t
GROUP BY start_date;
