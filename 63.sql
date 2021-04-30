CREATE TABLE T
(num INTEGER NOT NULL PRIMARY KEY,
 data CHAR(1) NOT NULL);

INSERT INTO T VALUES (1, 'a');
INSERT INTO T VALUES (2, 'a');
INSERT INTO T VALUES (3, 'b');
INSERT INTO T VALUES (6, 'b');
INSERT INTO T VALUES (8, 'a');

-- ひどすぎる…
SELECT DISTINCT lo, hi, data
FROM (
  SELECT
    t4.num,
    t1.num,
    t2.num,
    t1.data,
    RANK() OVER (PARTITION BY t4.num ORDER BY t1.num-t2.num)
  FROM T t1
  JOIN T t2 
    ON t1.data = t2.data 
    AND t1.num <= t2.num
    AND t1.data = ALL (SELECT t3.data FROM T t3 WHERE t3.num BETWEEN t1.num AND t2.num)
  JOIN T t4 
    ON t4.num BETWEEN t1.num AND t2.num
  ORDER BY t4.num
) S (num, lo, hi,data,rnk)
WHERE rnk = 1
