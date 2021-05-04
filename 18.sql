DROP TABLE IF EXISTS Consumers;

CREATE TABLE Consumers
(conname VARCHAR(64),
 address VARCHAR(64),
 con_id  INTEGER,
 fam     INTEGER);

INSERT INTO Consumers VALUES('�{�u',        'A', 1, NULL );
INSERT INTO Consumers VALUES('�W���[',      'B', 3, NULL );
INSERT INTO Consumers VALUES('�}�[�N' ,     'C', 5, NULL );
INSERT INTO Consumers VALUES('���A���[',    'A', 2,    1 );
INSERT INTO Consumers VALUES('���B�b�L�[',  'B', 4,    3 );
INSERT INTO Consumers VALUES('�E�F�C��',    'D', 6, NULL );

DELETE FROM Consumers c1
WHERE c1.fam IS NULL
AND EXISTS (
  SELECT *
  FROM Consumers c2
  WHERE c1.con_id = c2.fam
);

SELECT * FROM Consumers;
