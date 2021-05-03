DROP TABLE IF EXISTS Numbers;
CREATE TABLE Numbers (seq INTEGER NOT NULL PRIMARY KEY);
INSERT INTO Numbers VALUES (2);
INSERT INTO Numbers VALUES (3);
INSERT INTO Numbers VALUES (4);
INSERT INTO Numbers VALUES (5);
INSERT INTO Numbers VALUES (7);
INSERT INTO Numbers VALUES (8);
INSERT INTO Numbers VALUES (14);
INSERT INTO Numbers VALUES (20);

-- ����SQL�����ʂ�Ԃ�����A�Ԃł͂Ȃ�
SELECT *
FROM (
  SELECT seq, LEAD(seq) OVER (ORDER BY seq) nxt
  FROM Numbers
) t
WHERE NOT (nxt IS NULL OR seq + 1 = nxt);

-- ��1���f���炵���̂ŃR�s�y
SELECT CASE WHEN COUNT(*) + MIN(seq) - 1 = MAX(seq) THEN 'OK' ELSE 'NG' END
FROM Numbers;
