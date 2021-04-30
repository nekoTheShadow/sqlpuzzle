DROP TABLE IF EXISTS Inventory;

CREATE TABLE Inventory
(goods CHAR(10) NOT NULL PRIMARY KEY,
 pieces INTEGER NOT NULL CHECK (pieces >= 0));

INSERT INTO Inventory VALUES('Alpha'  , 4);
INSERT INTO Inventory VALUES('Beta'   , 5);
INSERT INTO Inventory VALUES('Delta'  ,16);
INSERT INTO Inventory VALUES('Gamma'  ,50);
INSERT INTO Inventory VALUES('Epsilon', 1);

-- ‚±‚±‚Å‚ÍÄ‹A‚ðŽg‚Á‚½‚ª‰ð“š2‚Í‚©‚È‚è‚æ‚³‚»‚¤
WITH RECURSIVE i AS (
  SELECT goods, pieces FROM Inventory
  UNION ALL
  SELECT goods, pieces-1 FROM i WHERE pieces > 1
)
SELECT * FROM i ORDER BY goods, pieces;


