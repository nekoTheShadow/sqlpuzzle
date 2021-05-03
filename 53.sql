DROP TABLE IF EXISTS Foobar;

CREATE TABLE Foobar
(lvl INTEGER NOT NULL PRIMARY KEY,
 color VARCHAR(10),
 length INTEGER,
 width INTEGER,
 hgt INTEGER);

INSERT INTO Foobar VALUES (1, 'RED', 8, 10, 12);
INSERT INTO Foobar VALUES (2, NULL, NULL, NULL, 20);
INSERT INTO Foobar VALUES (3, NULL, 9, 82, 25);
INSERT INTO Foobar VALUES (4, 'BLUE', NULL, 67, NULL);
INSERT INTO Foobar VALUES (5, 'GRAY', NULL, NULL, NULL);

WITH RECURSIVE r AS (
    SELECT * FROM Foobar WHERE lvl = 1
  UNION ALL
    SELECT 
      f.lvl, 
      COALESCE(f.color, r.color),
      COALESCE(f.length, r.length),
      COALESCE(f.width, r.width),
      COALESCE(f.hgt, r.hgt)
    FROM r
    JOIN Foobar f ON r.lvl + 1 = f.lvl
)
SELECT * FROM r WHERE lvl = (SELECT MAX(lvl) FROM r)

