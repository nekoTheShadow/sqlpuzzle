DROP TABLE IF EXISTS Losses;
DROP TABLE IF EXISTS Policy_Criteria;

CREATE TABLE Losses
(cust_nbr INTEGER NOT NULL PRIMARY KEY,
 a INTEGER, b INTEGER, c INTEGER, d INTEGER, e INTEGER,
 f INTEGER, g INTEGER, h INTEGER, i INTEGER, j INTEGER,
 k INTEGER, l INTEGER, m INTEGER, n INTEGER, o INTEGER);

CREATE TABLE Policy_Criteria
(criteria_id INTEGER NOT NULL,
 criteria CHAR(1) NOT NULL,
 crit_val INTEGER NOT NULL,
    PRIMARY KEY (criteria_id, criteria, crit_val));

INSERT INTO Losses 
VALUES ( 99, 5, 10, 15, NULL, NULL, NULL, NULL, NULL, 
         NULL, NULL,NULL, NULL, NULL, NULL, NULL);

INSERT INTO Policy_Criteria VALUES (1, 'A', 5);
INSERT INTO Policy_Criteria VALUES (1, 'A', 9);
INSERT INTO Policy_Criteria VALUES (1, 'A', 14);
INSERT INTO Policy_Criteria VALUES (1, 'B', 4);
INSERT INTO Policy_Criteria VALUES (1, 'B', 10);
INSERT INTO Policy_Criteria VALUES (1, 'B', 20);
INSERT INTO Policy_Criteria VALUES (2, 'B', 10);
INSERT INTO Policy_Criteria VALUES (2, 'B', 19);
INSERT INTO Policy_Criteria VALUES (3, 'A', 5);
INSERT INTO Policy_Criteria VALUES (3, 'B', 10);
INSERT INTO Policy_Criteria VALUES (3, 'B', 30);
INSERT INTO Policy_Criteria VALUES (3, 'C', 3);
INSERT INTO Policy_Criteria VALUES (3, 'C', 15);
INSERT INTO Policy_Criteria VALUES (4, 'A', 5);
INSERT INTO Policy_Criteria VALUES (4, 'B', 21);
INSERT INTO Policy_Criteria VALUES (4, 'B', 22);

WITH t (cust_nbr, criteria, crit_val) AS (
            SELECT cust_nbr, 'A', a FROM Losses WHERE a IS NOT NULL
  UNION ALL SELECT cust_nbr, 'B', b FROM Losses WHERE b IS NOT NULL
  UNION ALL SELECT cust_nbr, 'C', c FROM Losses WHERE c IS NOT NULL
  UNION ALL SELECT cust_nbr, 'D', d FROM Losses WHERE d IS NOT NULL
  UNION ALL SELECT cust_nbr, 'E', e FROM Losses WHERE e IS NOT NULL
  UNION ALL SELECT cust_nbr, 'F', f FROM Losses WHERE f IS NOT NULL
  UNION ALL SELECT cust_nbr, 'G', g FROM Losses WHERE g IS NOT NULL
  UNION ALL SELECT cust_nbr, 'H', h FROM Losses WHERE h IS NOT NULL
  UNION ALL SELECT cust_nbr, 'I', i FROM Losses WHERE i IS NOT NULL
  UNION ALL SELECT cust_nbr, 'J', j FROM Losses WHERE j IS NOT NULL
  UNION ALL SELECT cust_nbr, 'K', k FROM Losses WHERE k IS NOT NULL
  UNION ALL SELECT cust_nbr, 'L', l FROM Losses WHERE l IS NOT NULL
  UNION ALL SELECT cust_nbr, 'M', m FROM Losses WHERE m IS NOT NULL
  UNION ALL SELECT cust_nbr, 'N', n FROM Losses WHERE n IS NOT NULL
  UNION ALL SELECT cust_nbr, 'O', o FROM Losses WHERE o IS NOT NULL
)
SELECT criteria_id
FROM Policy_Criteria p1
JOIN t ON p1.criteria = t.criteria AND p1.crit_val = t.crit_val
WHERE t.cust_nbr = '99'
GROUP BY criteria_id
HAVING COUNT(DISTINCT p1.criteria) = (
  SELECT COUNT(DISTINCT p2.criteria) 
  FROM Policy_Criteria p2 
  WHERE p1.criteria_id = p2.criteria_id
)
