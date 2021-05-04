DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Newsstands;
DROP TABLE IF EXISTS Titles;

CREATE TABLE Titles
(product_id INTEGER NOT NULL PRIMARY KEY,
 magazine_sku INTEGER NOT NULL,
 issn INTEGER NOT NULL,
 issn_year INTEGER NOT NULL);

CREATE TABLE Newsstands
 (stand_nbr INTEGER NOT NULL PRIMARY KEY,
  stand_name CHAR(20) NOT NULL);

CREATE TABLE Sales
(product_id   INTEGER NOT NULL REFERENCES Titles(product_id),
 stand_nbr    INTEGER NOT NULL REFERENCES Newsstands(stand_nbr),
 net_sold_qty INTEGER NOT NULL,
 PRIMARY KEY(product_id, stand_nbr));

INSERT INTO Titles VALUES(1, 12345, 1, 2006);
INSERT INTO Titles VALUES(2, 2667,  1, 2006);
INSERT INTO Titles VALUES(3, 48632, 1, 2006);
INSERT INTO Titles VALUES(4, 1107,  1, 2006);
INSERT INTO Titles VALUES(5, 12345, 2, 2006);
INSERT INTO Titles VALUES(6, 2667,  2, 2006);
INSERT INTO Titles VALUES(7, 48632, 2, 2006);
INSERT INTO Titles VALUES(8, 1107,  2, 2006);

INSERT INTO Newsstands VALUES(1, 'Newsstands1');
INSERT INTO Newsstands VALUES(2, 'Newsstands2');
INSERT INTO Newsstands VALUES(3, 'Newsstands3');
INSERT INTO Newsstands VALUES(4, 'Newsstands4');

INSERT INTO Sales VALUES(1, 1, 1);
INSERT INTO Sales VALUES(2, 1, 4);
INSERT INTO Sales VALUES(3, 1, 1);
INSERT INTO Sales VALUES(4, 1, 1);
INSERT INTO Sales VALUES(5, 1, 1);
INSERT INTO Sales VALUES(6, 1, 2);
INSERT INTO Sales VALUES(7, 1, 1);
INSERT INTO Sales VALUES(3, 2, 1);
INSERT INTO Sales VALUES(4, 2, 5);
INSERT INTO Sales VALUES(8, 2, 6);
INSERT INTO Sales VALUES(1, 3, 1);
INSERT INTO Sales VALUES(2, 3, 3);
INSERT INTO Sales VALUES(3, 3, 3);
INSERT INTO Sales VALUES(4, 3, 1);
INSERT INTO Sales VALUES(5, 3, 1);
INSERT INTO Sales VALUES(6, 3, 3);
INSERT INTO Sales VALUES(7, 3, 3);
INSERT INTO Sales VALUES(1, 4, 1);
INSERT INTO Sales VALUES(2, 4, 1);
INSERT INTO Sales VALUES(3, 4, 4);
INSERT INTO Sales VALUES(4, 4, 1);
INSERT INTO Sales VALUES(5, 4, 1);
INSERT INTO Sales VALUES(6, 4, 1);
INSERT INTO Sales VALUES(7, 4, 2);

SELECT n.stand_nbr
FROM Newsstands n
JOIN Sales s ON n.stand_nbr = s.stand_nbr
JOIN Titles t ON s.product_id = t.product_id
GROUP BY n.stand_nbr
HAVING (
      AVG(CASE WHEN t.magazine_sku = 2667 THEN net_sold_qty END)> 2
  AND AVG(CASE WHEN t.magazine_sku = 48632 THEN net_sold_qty END) > 2
) OR AVG(CASE WHEN t.magazine_sku = 1107 THEN net_sold_qty END) > 5
