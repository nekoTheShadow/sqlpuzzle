DROP TABLE IF EXISTS Restaurant;

-- 0001~1000������
CREATE TABLE Restaurant( seat INTEGER);
INSERT INTO Restaurant VALUES(1);
INSERT INTO Restaurant VALUES(3);
INSERT INTO Restaurant VALUES(4);
INSERT INTO Restaurant VALUES(7);

-- �ԕ��𓊓�����B
INSERT INTO Restaurant VALUES(0);
INSERT INTO Restaurant VALUES(1001);

-- ����4�Ɠ������ۂ�
SELECT (R1.seat + 1), (MIN(R2.seat) - 1)
FROM Restaurant R1 
JOIN Restaurant R2 ON R1.seat < R2.seat
GROUP BY R1.seat
HAVING (R1.seat + 1) <= (MIN(R2.seat) - 1)
