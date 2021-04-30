CREATE TABLE Procs(
 proc_id INTEGER,
 anest_name VARCHAR(64),
 start_time TIMESTAMP,
 end_time   TIMESTAMP );

INSERT INTO Procs VALUES( 10, 'Baker', '01-07-01 08:00', '01-07-01 11:00');
INSERT INTO Procs VALUES( 20, 'Baker', '01-07-01 09:00', '01-07-01 13:00');
INSERT INTO Procs VALUES( 30, 'Dow'  , '01-07-01 09:00', '01-07-01 15:30'); 
INSERT INTO Procs VALUES( 40, 'Dow'  , '01-07-01 08:00', '01-07-01 13:30'); 
INSERT INTO Procs VALUES( 50, 'Dow'  , '01-07-01 10:00', '01-07-01 11:30'); 
INSERT INTO Procs VALUES( 60, 'Dow'  , '01-07-01 12:30', '01-07-01 13:30'); 
INSERT INTO Procs VALUES( 70, 'Dow'  , '01-07-01 13:30', '01-07-01 14:30'); 
INSERT INTO Procs VALUES( 80, 'Dow'  , '01-07-01 18:00', '01-07-01 19:00'); 

--- いわゆるimos法を適用。[start_time, end_time)ととらえて処理を行う。
WITH 
s (anest_name, event_time, event) AS (
            SELECT anest_name, start_time, +1 FROM Procs
  UNION ALL SELECT anest_name, end_time,   -1 FROM Procs
),
t (anest_name, event_time, event_count) AS (
  SELECT 
    anest_name, 
    event_time, 
    SUM(event) OVER (PARTITION BY anest_name ORDER BY event_time)
  FROM s
)
SELECT 
  proc_id,
  (SELECT MAX(event_count) 
   FROM t 
   WHERE p.anest_name = t.anest_name
   AND p.start_time <= t.event_time  
   AND t.event_time < p.end_time) AS max_inst_count
FROM Procs p;