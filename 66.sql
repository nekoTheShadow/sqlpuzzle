-- 本書では数独を表現するためのテーブルを準備し、
-- 実際の解答はプロシージャを利用しているが、
-- 再帰SQLと文字列関数を利用すれば、以下のように解くことができる。
-- 参考: https://technology.amis.nl/it/solving-a-sudoku-with-one-sql-statement/

WITH RECURSIVE a (sud, ind) AS (
    SELECT sud, POSITION(' ' IN sud)
    FROM (VALUES ('53  7    6  195    98    6 8   6   34  8 3  17   2   6 6    28    419  5    8  79')) b (sud)
  UNION ALL
    SELECT 
      OVERLAY(sud PLACING seq::text FROM ind),
      POSITION(' ' IN OVERLAY(sud PLACING seq::text FROM ind))
    FROM a
    CROSS JOIN (VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9)) c (seq)
    WHERE ind > 0
    AND POSITION(seq::text in SUBSTR(sud, (ind-1)/9*9+1 ,9)) = 0
    AND POSITION(seq::text in SUBSTR(sud, (ind-1)%9+1+00, 1)) = 0
    AND POSITION(seq::text in SUBSTR(sud, (ind-1)%9+1+09, 1)) = 0
    AND POSITION(seq::text in SUBSTR(sud, (ind-1)%9+1+18, 1)) = 0
    AND POSITION(seq::text in SUBSTR(sud, (ind-1)%9+1+27, 1)) = 0
    AND POSITION(seq::text in SUBSTR(sud, (ind-1)%9+1+36, 1)) = 0
    AND POSITION(seq::text in SUBSTR(sud, (ind-1)%9+1+45, 1)) = 0
    AND POSITION(seq::text in SUBSTR(sud, (ind-1)%9+1+54, 1)) = 0
    AND POSITION(seq::text in SUBSTR(sud, (ind-1)%9+1+63, 1)) = 0
    AND POSITION(seq::text in SUBSTR(sud, (ind-1)%9+1+72, 1)) = 0
    AND POSITION(seq::text in SUBSTR(sud,((ind-1)%9)/3*3+1+9*(((ind-1)/9)/3*3)+00, 3)) = 0
    AND POSITION(seq::text in SUBSTR(sud,((ind-1)%9)/3*3+1+9*(((ind-1)/9)/3*3)+09, 3)) = 0
    AND POSITION(seq::text in SUBSTR(sud,((ind-1)%9)/3*3+1+9*(((ind-1)/9)/3*3)+18, 3)) = 0
)
SELECT * FROM a WHERE ind = 0


