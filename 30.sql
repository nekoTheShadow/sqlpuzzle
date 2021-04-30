DROP TABLE IF EXISTS Sales;

CREATE TABLE Sales
(customer_name CHAR(5) NOT NULL,
sale_date DATE NOT NULL,
PRIMARY KEY (customer_name, sale_date));

INSERT INTO Sales VALUES('Fred', '1994-06-01');
INSERT INTO Sales VALUES('Mary', '1994-06-01');
INSERT INTO Sales VALUES('Bill', '1994-06-01');
INSERT INTO Sales VALUES('Fred', '1994-06-02');
INSERT INTO Sales VALUES('Bill', '1994-06-02');
INSERT INTO Sales VALUES('Bill', '1994-06-03');
INSERT INTO Sales VALUES('Bill', '1994-06-04');
INSERT INTO Sales VALUES('Bill', '1994-06-05');
INSERT INTO Sales VALUES('Bill', '1994-06-06');
INSERT INTO Sales VALUES('Bill', '1994-06-07');
INSERT INTO Sales VALUES('Fred', '1994-06-07');
INSERT INTO Sales VALUES('Mary', '1994-06-08');

SELECT 
  customer_name,
  AVG(date_to - date_from)
FROM (
  SELECT 
    customer_name,
    sale_date AS date_from,
    LEAD(sale_date) OVER (PARTITION BY customer_name ORDER BY sale_date) AS date_to
  FROM Sales
) t
GROUP BY customer_name
