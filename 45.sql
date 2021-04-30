DROP TABLE IF EXISTS FriendsofPepperoni;

--重複行があるというので、主キーなし
CREATE TABLE FriendsofPepperoni
(cust_id INTEGER,
 bill_date DATE,
 pizza_amt DECIMAL(5,2));

INSERT INTO FriendsofPepperoni VALUES(1, '2007-05-07', 10);
INSERT INTO FriendsofPepperoni VALUES(1, '2007-04-01', 20);
INSERT INTO FriendsofPepperoni VALUES(1, '2007-03-01', 30);
INSERT INTO FriendsofPepperoni VALUES(1, '2007-01-01', 40);
INSERT INTO FriendsofPepperoni VALUES(2, '2007-05-06', 10);
INSERT INTO FriendsofPepperoni VALUES(2, '2007-04-01', 20);
INSERT INTO FriendsofPepperoni VALUES(2, '2007-03-01', 30);
INSERT INTO FriendsofPepperoni VALUES(2, '2007-01-01', 40);


SELECT
  cust_id,
  SUM(CASE WHEN (DATE '2007-06-01' - INTERVAL '30 DAY') <= bill_date THEN pizza_amt ELSE 0 END) AS "~30",
  SUM(CASE WHEN (DATE '2007-06-01' - INTERVAL '60 DAY') <= bill_date AND bill_date <= (DATE '2007-06-01' - INTERVAL '31 DAY') THEN pizza_amt ELSE 0 END) AS "31-60",
  SUM(CASE WHEN (DATE '2007-06-01' - INTERVAL '90 DAY') <= bill_date AND bill_date <= (DATE '2007-06-01' - INTERVAL '61 DAY') THEN pizza_amt ELSE 0 END) AS "61-90",
  SUM(CASE WHEN bill_date <= (DATE '2007-06-01' - INTERVAL '91 DAY') THEN pizza_amt ELSE 0 END) AS "91-"
FROM FriendsofPepperoni
GROUP BY cust_id;
