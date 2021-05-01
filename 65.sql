DROP TABLE IF EXISTS PriceByAge;

CREATE TABLE PriceByAge
(product_id CHAR(10) NOT NULL,
 low_age INTEGER NOT NULL,
 high_age INTEGER NOT NULL,
 CHECK (low_age < high_age),
 product_price DECIMAL (12,4) NOT NULL,
 PRIMARY KEY (product_id, low_age));

--Product1は×、Product2は○
INSERT INTO PriceByAge VALUES ('Product1', 5, 15, 20.00);
INSERT INTO PriceByAge VALUES ('Product1', 16, 60, 18.00);
INSERT INTO PriceByAge VALUES ('Product1', 65, 150, 17.00);
INSERT INTO PriceByAge VALUES ('Product2', 1, 5, 20.00);
INSERT INTO PriceByAge VALUES ('Product2', 6, 70, 25.00);
INSERT INTO PriceByAge VALUES ('Product2', 71, 150, 40.00);

WITH RECURSIVE t (seq) AS (
  SELECT 1
  UNION ALL
  SELECT seq + 1 FROM t WHERE seq < 150
)
SELECT p.product_id
FROM t
JOIN PriceByAge p ON t.seq BETWEEN p.low_age AND p.high_age
GROUP BY p.product_id
HAVING COUNT(DISTINCT t.seq) = 150

