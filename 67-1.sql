DROP TABLE IF EXISTS Husbands;
DROP TABLE IF EXISTS Wives;

CREATE TABLE Husbands
(man VARCHAR(5) NOT NULL,
 woman VARCHAR(5) NOT NULL,
 ranking INTEGER NOT NULL CHECK (ranking > 0),
 PRIMARY KEY (man, woman));

 CREATE TABLE Wives
(woman VARCHAR(5) NOT NULL,
 man VARCHAR(5) NOT NULL,
 ranking INTEGER NOT NULL CHECK (ranking > 0),
 PRIMARY KEY (man, woman));

INSERT INTO Husbands VALUES ('Abe', 'Joan', 1);
INSERT INTO Husbands VALUES ('Abe', 'Kathy', 2);
INSERT INTO Husbands VALUES ('Abe', 'Lynn', 3);
INSERT INTO Husbands VALUES ('Abe', 'Molly', 4);
INSERT INTO Husbands VALUES ('Bob', 'Joan', 3);
INSERT INTO Husbands VALUES ('Bob', 'Kathy', 4);
INSERT INTO Husbands VALUES ('Bob', 'Lynn', 2);
INSERT INTO Husbands VALUES ('Bob', 'Molly', 1);
INSERT INTO Husbands VALUES ('Chuck', 'Joan', 3);
INSERT INTO Husbands VALUES ('Chuck', 'Kathy', 4);
INSERT INTO Husbands VALUES ('Chuck', 'Lynn', 2);
INSERT INTO Husbands VALUES ('Chuck', 'Molly', 1);
INSERT INTO Husbands VALUES ('Dave', 'Joan', 2);
INSERT INTO Husbands VALUES ('Dave', 'Kathy', 1);
INSERT INTO Husbands VALUES ('Dave', 'Lynn', 3);
INSERT INTO Husbands VALUES ('Dave', 'Molly', 4);

INSERT INTO Wives VALUES ('Joan', 'Abe', 1);
INSERT INTO Wives VALUES ('Joan', 'Bob', 3);
INSERT INTO Wives VALUES ('Joan', 'Chuck', 2);
INSERT INTO Wives VALUES ('Joan', 'Dave', 4);
INSERT INTO Wives VALUES ('Kathy', 'Abe', 4);
INSERT INTO Wives VALUES ('Kathy', 'Bob', 2);
INSERT INTO Wives VALUES ('Kathy', 'Chuck', 3);
INSERT INTO Wives VALUES ('Kathy', 'Dave', 1);
INSERT INTO Wives VALUES ('Lynn', 'Abe', 1);
INSERT INTO Wives VALUES ('Lynn', 'Bob', 3);
INSERT INTO Wives VALUES ('Lynn', 'Chuck', 4);
INSERT INTO Wives VALUES ('Lynn', 'Dave', 2);
INSERT INTO Wives VALUES ('Molly', 'Abe', 3);
INSERT INTO Wives VALUES ('Molly', 'Bob', 4);
INSERT INTO Wives VALUES ('Molly', 'Chuck', 1);
INSERT INTO Wives VALUES ('Molly', 'Dave', 2);



WITH RECURSIVE r (men, women, used) AS (
    SELECT 
      ARRAY_AGG(man),
      ARRAY_AGG(''::varchar),
      ARRAY_AGG(''::varchar)
    FROM (
      SELECT DISTINCT man FROM Husbands ORDER BY man
    ) t
  UNION ALL
    SELECT
      men,
      CASE WHEN (SELECT ranking 
                 FROM Wives w 
                 WHERE s.woman = w.woman 
                 AND w.man = men[array_position(women, s.woman)]) 
                 < (SELECT ranking
                    FROM Wives w 
                    WHERE s.woman = w.woman 
                    AND s.man = w.man) THEN
        women
      ELSE 
        array_replace(women[1 : array_position(men, man)-1], woman, '') 
          || woman 
          || array_replace(women[array_position(men, man)+1 : ] , woman, '')
      END,
      used[1 : array_position(men, man)-1] 
        || (used[array_position(men, man)] || '_' || woman)::varchar
        || used[array_position(men, man)+1 : ]
    FROM (
      SELECT *, RANK() OVER (ORDER BY h.ranking) rnk
      FROM Husbands h 
      CROSS JOIN r 
      WHERE h.man = men[array_position(women, '')]
      AND POSITION(woman IN used[array_position(men, man)]) = 0
    ) s
    WHERE rnk = 1
)
SELECT men, women FROM r WHERE array_position(women, '') IS NULL



