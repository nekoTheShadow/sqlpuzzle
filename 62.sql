CREATE TABLE Names
(name VARCHAR(15) NOT NULL PRIMARY KEY);

INSERT INTO Names VALUES ('Al');
INSERT INTO Names VALUES ('Ben');
INSERT INTO Names VALUES ('Charlie');
INSERT INTO Names VALUES ('David');
INSERT INTO Names VALUES ('Ed');
INSERT INTO Names VALUES ('Frank');
INSERT INTO Names VALUES ('Greg');
INSERT INTO Names VALUES ('Howard');
INSERT INTO Names VALUES ('Ida');
INSERT INTO Names VALUES ('Joe');
INSERT INTO Names VALUES ('Ken');
INSERT INTO Names VALUES ('Larry');
INSERT INTO Names VALUES ('Mike');
INSERT INTO Names VALUES ('Neal');

SELECT 
  MAX(CASE WHEN MOD(seq, 3)=0 THEN name END) name1,
  MAX(CASE WHEN MOD(seq, 3)=1 THEN name END) name2,
  MAX(CASE WHEN MOD(seq, 3)=2 THEN name END) name3
FROM (
  SELECT name, ROW_NUMBER() OVER(ORDER BY name)-1 seq 
  FROM Names
) AS t
GROUP BY seq / 3
ORDER BY seq / 3;

SELECT 
  MAX(CASE WHEN MOD(seq, 4)=0 THEN name END) name1,
  MAX(CASE WHEN MOD(seq, 4)=1 THEN name END) name2,
  MAX(CASE WHEN MOD(seq, 4)=2 THEN name END) name3,
  MAX(CASE WHEN MOD(seq, 4)=3 THEN name END) name4
FROM (
  SELECT name, ROW_NUMBER() OVER(ORDER BY name)-1 seq 
  FROM Names
) AS t
GROUP BY seq / 4
ORDER BY seq / 4