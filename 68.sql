DROP TABLE IF EXISTS Schedule;

CREATE TABLE Schedule
(route_nbr INTEGER NOT NULL,
 depart_time TIMESTAMP NOT NULL,
 arrive_time TIMESTAMP NOT NULL,
    CHECK (depart_time < arrive_time),
    PRIMARY KEY (route_nbr, depart_time));

INSERT INTO Schedule VALUES (3, '2006-02-09 10:00', '2006-02-09 14:00');
INSERT INTO Schedule VALUES (4, '2006-02-09 16:00', '2006-02-09 17:00');
INSERT INTO Schedule VALUES (5, '2006-02-09 18:00', '2006-02-09 19:00');
INSERT INTO Schedule VALUES (6, '2006-02-09 20:00', '2006-02-09 21:00');
INSERT INTO Schedule VALUES (7, '2006-02-09 11:00', '2006-02-09 13:00');
INSERT INTO Schedule VALUES (8, '2006-02-09 15:00', '2006-02-09 16:00');
INSERT INTO Schedule VALUES (9, '2006-02-09 18:00', '2006-02-09 20:00');

-- MINを使う方法
SELECT *
FROM Schedule
WHERE depart_time = (
  SELECT MIN(depart_time)
  FROM Schedule
  WHERE depart_time >= '2006-02-09 15:30'
);

SELECT *
FROM Schedule
WHERE depart_time = (
  SELECT MIN(depart_time)
  FROM Schedule
  WHERE depart_time >= '2006-02-09 16:30'
);

-- RANKを使う方法
SELECT *
FROM (
  SELECT *, RANK() OVER (ORDER BY depart_time) rnk
  FROM Schedule
  WHERE depart_time >= '2006-02-09 15:30'
) t
WHERE rnk = 1;

SELECT *
FROM (
  SELECT *, RANK() OVER (ORDER BY depart_time) rnk
  FROM Schedule
  WHERE depart_time >= '2006-02-09 16:30'
) t
WHERE rnk = 1;
