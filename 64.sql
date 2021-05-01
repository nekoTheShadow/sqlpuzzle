DROP TABLE IF EXISTS Boxes;

CREATE TABLE Boxes
(box_id CHAR(1) NOT NULL,
 dim CHAR(1) NOT NULL,
    PRIMARY KEY (box_id, dim),
 low INTEGER NOT NULL,
 high INTEGER NOT NULL);

INSERT INTO Boxes VALUES('A', 'x',0,2);
INSERT INTO Boxes VALUES('A', 'y',0,2);
INSERT INTO Boxes VALUES('A', 'z',0,2);
INSERT INTO Boxes VALUES('B', 'x',1,3);
INSERT INTO Boxes VALUES('B', 'y',1,3);
INSERT INTO Boxes VALUES('B', 'z',1,3);
INSERT INTO Boxes VALUES('C', 'x',10,12);
INSERT INTO Boxes VALUES('C', 'y',0,4);
INSERT INTO Boxes VALUES('C', 'z',0,100);

SELECT b1.box_id, b2.box_id
FROM Boxes b1
JOIN Boxes b2 ON b1.box_id < b2.box_id AND  b1.dim = b2.dim
WHERE b1.low <= b2.high AND b1.high >= b2.low
GROUP BY b1.box_id, b2.box_id
HAVING COUNT(*) = (
  SELECT COUNT(*)
  FROM Boxes b3
  WHERE b1.box_id = b3.box_id
);
