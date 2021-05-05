DROP TABLE IF EXISTS Foo;
DROP TABLE IF EXISTS Bar;
DROP TABLE IF EXISTS Accounts;

CREATE TABLE Accounts
 (acct_nbr INTEGER NOT NULL PRIMARY KEY);

CREATE TABLE Foo
 (acct_nbr INTEGER NOT NULL
    REFERENCES Accounts(acct_nbr),
  foo_qty INTEGER NOT NULL);

CREATE TABLE Bar
(acct_nbr INTEGER NOT NULL
    REFERENCES Accounts(acct_nbr),
 bar_qty INTEGER NOT NULL);

INSERT INTO Accounts VALUES (1);
INSERT INTO Accounts VALUES (2);
INSERT INTO Accounts VALUES (3);
INSERT INTO Accounts VALUES (4);

INSERT INTO Foo VALUES (1, 10);
INSERT INTO Foo VALUES (2, 20);
INSERT INTO Foo VALUES (2, 40);
INSERT INTO Foo VALUES (3, 80);

INSERT INTO Bar VALUES (2, 160);
INSERT INTO Bar VALUES (3, 320);
INSERT INTO Bar VALUES (3, 640);
INSERT INTO Bar VALUES (3, 1);


-- サブクエリが2つの方法
SELECT
  A.acct_nbr,
  COALESCE((SELECT SUM(foo_qty) FROM Foo F WHERE A.acct_nbr = F.acct_nbr), 0) AS foo_qty_tot,
  COALESCE((SELECT SUM(bar_qty) FROM Bar B WHERE A.acct_nbr = B.acct_nbr), 0) AS bar_qty_tot
FROM Accounts A;

-- サブクエリが1つだけ
SELECT
  A.acct_nbr,
  COALESCE(SUM(F.foo_qty), 0) AS foo_qty_tot,
  COALESCE(MAX(B.bar_qty), 0) AS bar_qty_tot
FROM Accounts A
LEFT OUTER JOIN Foo F ON A.acct_nbr = F.acct_nbr
LEFT OUTER JOIN (
  SELECT acct_nbr, SUM(bar_qty) bar_qty
  FROM Bar 
  GROUP BY acct_nbr
) B ON A.acct_nbr = B.acct_nbr 
GROUP BY A.acct_nbr;
