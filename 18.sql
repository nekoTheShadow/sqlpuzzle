DROP TABLE IF EXISTS Consumers;

CREATE TABLE Consumers
(conname VARCHAR(64),
 address VARCHAR(64),
 con_id  INTEGER,
 fam     INTEGER);

INSERT INTO Consumers VALUES('ボブ',        'A', 1, NULL );
INSERT INTO Consumers VALUES('ジョー',      'B', 3, NULL );
INSERT INTO Consumers VALUES('マーク' ,     'C', 5, NULL );
INSERT INTO Consumers VALUES('メアリー',    'A', 2,    1 );
INSERT INTO Consumers VALUES('ヴィッキー',  'B', 4,    3 );
INSERT INTO Consumers VALUES('ウェイン',    'D', 6, NULL );

DELETE FROM Consumers c1
WHERE c1.fam IS NULL
AND EXISTS (
  SELECT *
  FROM Consumers c2
  WHERE c1.con_id = c2.fam
);

SELECT * FROM Consumers;
