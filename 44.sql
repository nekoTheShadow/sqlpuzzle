DROP TABLE IF EXISTS SalesSlips;

CREATE TABLE SalesSlips
(item_a INTEGER NOT NULL,
 item_b INTEGER NOT NULL,
    PRIMARY KEY(item_a, item_b),
 pair_tally INTEGER NOT NULL);

INSERT INTO SalesSlips VALUES(12345, 12345, 12);
INSERT INTO SalesSlips VALUES(12345, 67890,  9);
INSERT INTO SalesSlips VALUES(67890, 12345,  5);

SELECT a.item_a, a.item_b, a.pair_tally + COALESCE(b.pair_tally, 0) pair_tally
FROM SalesSlips a
LEFT OUTER JOIN SalesSlips b 
  ON  a.item_a < a.item_b
  AND a.item_a = b.item_b 
  AND a.item_b = b.item_a
WHERE a.item_a <= a.item_b;

-- Š´S‚µ‚½“š‚¦‚ðŽÊŒo‚µ‚Ä‚¨‚­
SELECT 
  CASE WHEN item_a <= item_b THEN item_a ELSE item_b END s1, 
  CASE WHEN item_a <= item_b THEN item_b ELSE item_a END s2, 
  SUM(pair_tally) pair_tally
FROM SalesSlips
GROUP BY s1, s2

