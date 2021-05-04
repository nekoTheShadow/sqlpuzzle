DROP TABLE IF EXISTS MyTable;

CREATE TABLE MyTable
(keycol INTEGER NOT NULL,
 f1 INTEGER NOT NULL,
 f2 INTEGER NOT NULL,
 f3 INTEGER NOT NULL,
 f4 INTEGER NOT NULL,
 f5 INTEGER NOT NULL,
 f6 INTEGER NOT NULL,
 f7 INTEGER NOT NULL,
 f8 INTEGER NOT NULL,
 f9 INTEGER NOT NULL,
 f10 INTEGER NOT NULL);

--選択対象
INSERT INTO MyTable VALUES(333, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO MyTable VALUES(444, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9);
INSERT INTO MyTable VALUES(999, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0);

--選択対象外
INSERT INTO MyTable VALUES(555, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO MyTable VALUES(666, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO MyTable VALUES(777, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- 解答1: 正規化する
WITH n (keycol, f) AS (
            SELECT keycol, f1  FROM MyTable
  UNION ALL SELECT keycol, f2  FROM MyTable
  UNION ALL SELECT keycol, f3  FROM MyTable
  UNION ALL SELECT keycol, f4  FROM MyTable
  UNION ALL SELECT keycol, f5  FROM MyTable
  UNION ALL SELECT keycol, f6  FROM MyTable
  UNION ALL SELECT keycol, f7  FROM MyTable
  UNION ALL SELECT keycol, f8  FROM MyTable
  UNION ALL SELECT keycol, f9  FROM MyTable
  UNION ALL SELECT keycol, f10 FROM MyTable
)
SELECT *
FROM MyTable m
WHERE (
  SELECT COUNT(*)
  FROM n
  WHERE m.keycol = n.keycol AND n.f <> 0
) = 1;

-- 解答2: 0の数を愚直に数える。
SELECT *
FROM MyTable
WHERE ABS(SIGN(f1)) + ABS(SIGN(f2)) + ABS(SIGN(f3))
    + ABS(SIGN(f4)) + ABS(SIGN(f5)) + ABS(SIGN(f6))
    + ABS(SIGN(f7)) + ABS(SIGN(f8)) + ABS(SIGN(f9))
    + ABS(SIGN(f10)) = 1;

