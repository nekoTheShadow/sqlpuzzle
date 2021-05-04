DROP TABLE IF EXISTS SupParts;

CREATE TABLE SupParts
(sno INTEGER NOT NULL,
 pno INTEGER NOT NULL,
    PRIMARY KEY (sno, pno));

--1と3、2と4が一致する
INSERT INTO SupParts VALUES(1, 01);
INSERT INTO SupParts VALUES(1, 02);
INSERT INTO SupParts VALUES(1, 03);

INSERT INTO SupParts VALUES(2, 01);
INSERT INTO SupParts VALUES(2, 03);

INSERT INTO SupParts VALUES(3, 01);
INSERT INTO SupParts VALUES(3, 02);
INSERT INTO SupParts VALUES(3, 03);

INSERT INTO SupParts VALUES(4, 01);
INSERT INTO SupParts VALUES(4, 03);

INSERT INTO SupParts VALUES(5, 05);

INSERT INTO SupParts VALUES(6, 01);
INSERT INTO SupParts VALUES(6, 02);

-- A-B=φ かつ B-A=φ ならば A=B 
SELECT DISTINCT s1.sno, s2.sno
FROM SupParts s1
JOIN SupParts s2 ON s1.sno < s2.sno
WHERE NOT EXISTS (
       SELECT pno FROM SupParts s WHERE s.sno = s1.sno
       EXCEPT
       SELECT pno FROM SupParts s WHERE s.sno = s2.sno)
  AND NOT EXISTS (
       SELECT pno FROM SupParts s WHERE s.sno = s2.sno
       EXCEPT
       SELECT pno FROM SupParts s WHERE s.sno = s1.sno);

-- A∩B=A かつ A∩B=B ならば A=B
SELECT s1.sno, s2.sno
FROM SupParts s1
JOIN SupParts s2 ON s1.sno < s2.sno AND s1.pno = s2.pno
GROUP BY s1.sno, s2.sno
HAVING COUNT(*) = (SELECT COUNT(*) FROM SupParts s WHERE s.sno = s1.sno)
AND COUNT(*) = (SELECT COUNT(*) FROM SupParts s WHERE s.sno = s2.sno);
