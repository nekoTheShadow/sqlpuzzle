-- 順列
CREATE TABLE Elements
(i INTEGER NOT NULL PRIMARY KEY);

INSERT INTO Elements VALUES (1);
INSERT INTO Elements VALUES (2);
INSERT INTO Elements VALUES (3);
INSERT INTO Elements VALUES (4);
INSERT INTO Elements VALUES (5);
INSERT INTO Elements VALUES (6);
INSERT INTO Elements VALUES (7);

WITH RECURSIVE t (perm, used) AS (
    SELECT 
      i, 
      1<<(i-1)
    FROM Elements
  UNION ALL
    SELECT
      t.perm*10+e.i,
      t.used | (1<<(e.i-1))
    FROM t 
    JOIN Elements e ON t.used & (1<<(e.i-1)) = 0
)
SELECT * FROM t WHERE used = (1<<7)-1