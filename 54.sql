DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers
(custnbr INTEGER,
 last_name  CHAR(10),
 first_name CHAR(10),
 street_address INTEGER,
 city_name  CHAR(10),
 state_code INTEGER,
 phone_nbr  INTEGER);

INSERT INTO Customers VALUES(1, 'Smith',  'Mike', 1, 'New York', 1, 1);
INSERT INTO Customers VALUES(2, 'Darwin', 'Ken',  1, 'New York', 0, 5);
INSERT INTO Customers VALUES(3, 'Haxley', 'Kate', 2, 'Chicago',  1, 10);
INSERT INTO Customers VALUES(4, 'Darwin', 'John', 9, 'Los',      0, 5);
INSERT INTO Customers VALUES(5, 'Haxley', 'Mick', 2, 'Keswick',  0, 10);

-- èdï°çsÇ™ÇÌÇ©ÇÈÇÊÇ§Ç…èCê≥Ç∑ÇÈÅB
SELECT c1.custnbr, c2.custnbr
FROM Customers c1
JOIN Customers c2 ON c1.custnbr < c2.custnbr
WHERE c1.last_name = c2.last_name
AND (
    CASE WHEN c1.first_name     = c2.first_name     THEN 1 ELSE 0 END
  + CASE WHEN c1.street_address = c2.street_address THEN 1 ELSE 0 END
  + CASE WHEN c1.city_name      = c2.city_name      THEN 1 ELSE 0 END
  + CASE WHEN c1.state_code     = c2.state_code     THEN 1 ELSE 0 END
  + CASE WHEN c1.phone_nbr      = c2.phone_nbr      THEN 1 ELSE 0 END
) >= 2
