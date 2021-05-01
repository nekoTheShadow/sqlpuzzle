DROP TABLE IF EXISTS Husbands;
DROP TABLE IF EXISTS Wives;

CREATE TABLE Husbands
(man VARCHAR(2) NOT NULL,
 woman VARCHAR(2) NOT NULL,
 PRIMARY KEY (man, woman),
 ranking INTEGER NOT NULL);

CREATE TABLE Wives
(woman VARCHAR(2) NOT NULL,
 man VARCHAR(2) NOT NULL,
 PRIMARY KEY (woman, man),
 ranking INTEGER NOT NULL);

-- 男性の女性に対する好みの順位
INSERT INTO Husbands -- 夫 #1
VALUES ('h1', 'w1', 5), ('h1', 'w2', 2),
       ('h1', 'w3', 6), ('h1', 'w4', 8),
       ('h1', 'w5', 4), ('h1', 'w6', 3),
       ('h1', 'w7', 1), ('h1', 'w8', 7);

INSERT INTO Husbands -- 夫 #2
VALUES ('h2', 'w1', 6), ('h2', 'w2', 3),
       ('h2', 'w3', 2), ('h2', 'w4', 1),
       ('h2', 'w5', 8), ('h2', 'w6', 4),
       ('h2', 'w7', 7), ('h2', 'w8', 5);

INSERT INTO Husbands -- 夫 #3
VALUES ('h3', 'w1', 4), ('h3', 'w2', 2),
       ('h3', 'w3', 1), ('h3', 'w4', 3),
       ('h3', 'w5', 6), ('h3', 'w6', 8),
       ('h3', 'w7', 7), ('h3', 'w8', 5);

INSERT INTO Husbands -- 夫 #4
VALUES ('h4', 'w1', 8), ('h4', 'w2', 4),
       ('h4', 'w3', 1), ('h4', 'w4', 3),
       ('h4', 'w5', 5), ('h4', 'w6', 6),
       ('h4', 'w7', 7), ('h4', 'w8', 2);

INSERT INTO Husbands -- 夫 #5
       VALUES ('h5', 'w1', 6), ('h5', 'w2', 8),
       ('h5', 'w3', 2), ('h5', 'w4', 3),
       ('h5', 'w5', 4), ('h5', 'w6', 5),
       ('h5', 'w7', 7), ('h5', 'w8', 1);

INSERT INTO Husbands -- 夫 #6
VALUES ('h6', 'w1', 7), ('h6', 'w2', 4),
       ('h6', 'w3', 6), ('h6', 'w4', 5),
       ('h6', 'w5', 3), ('h6', 'w6', 8),
       ('h6', 'w7', 2), ('h6', 'w8', 1);

INSERT INTO Husbands -- 夫 #7
VALUES ('h7', 'w1', 5), ('h7', 'w2', 1),
       ('h7', 'w3', 4), ('h7', 'w4', 2),
       ('h7', 'w5', 7), ('h7', 'w6', 3),
       ('h7', 'w7', 6), ('h7', 'w8', 8);

INSERT INTO Husbands -- 夫 #8
VALUES ('h8', 'w1', 2), ('h8', 'w2', 4),
       ('h8', 'w3', 7), ('h8', 'w4', 3),
       ('h8', 'w5', 6), ('h8', 'w6', 1),
       ('h8', 'w7', 5), ('h8', 'w8', 8);


-- 女性の男性に対する好みの順位
INSERT INTO Wives -- 妻 #1
VALUES ('w1', 'h1', 6), ('w1', 'h2', 3),
       ('w1', 'h3', 7), ('w1', 'h4', 1),
       ('w1', 'h5', 4), ('w1', 'h6', 2),
       ('w1', 'h7', 8), ('w1', 'h8', 5);

INSERT INTO Wives -- 妻 #2
VALUES ('w2', 'h1', 4), ('w2', 'h2', 8),
       ('w2', 'h3', 3), ('w2', 'h4', 7),
       ('w2', 'h5', 2), ('w2', 'h6', 5),
       ('w2', 'h7', 6), ('w2', 'h8', 1);

INSERT INTO Wives -- 妻 #3
VALUES ('w3', 'h1', 3), ('w3', 'h2', 4),
       ('w3', 'h3', 5), ('w3', 'h4', 6),
       ('w3', 'h5', 8), ('w3', 'h6', 1),
       ('w3', 'h7', 7), ('w3', 'h8', 2);

INSERT INTO Wives -- 妻 #4
VALUES ('w4', 'h1', 8), ('w4', 'h2', 2),
       ('w4', 'h3', 1), ('w4', 'h4', 3),
       ('w4', 'h5', 7), ('w4', 'h6', 5),
       ('w4', 'h7', 4), ('w4', 'h8', 6);

INSERT INTO Wives -- 妻 #5
VALUES ('w5', 'h1', 3), ('w5', 'h2', 7),
       ('w5', 'h3', 2), ('w5', 'h4', 4),
       ('w5', 'h5', 5), ('w5', 'h6', 1),
       ('w5', 'h7', 6), ('w5', 'h8', 8);

INSERT INTO Wives -- 妻 #6
VALUES ('w6', 'h1', 2), ('w6', 'h2', 1),
       ('w6', 'h3', 3), ('w6', 'h4', 6),
       ('w6', 'h5', 8), ('w6', 'h6', 7),
       ('w6', 'h7', 5), ('w6', 'h8', 4);

INSERT INTO Wives -- 妻 #7
VALUES ('w7', 'h1', 6), ('w7', 'h2', 4),
       ('w7', 'h3', 1), ('w7', 'h4', 5),
       ('w7', 'h5', 2), ('w7', 'h6', 8),
       ('w7', 'h7', 3), ('w7', 'h8', 7);

INSERT INTO Wives -- 妻 #8
VALUES ('w8', 'h1', 8), ('w8', 'h2', 2),
       ('w8', 'h3', 7), ('w8', 'h4', 4),
       ('w8', 'h5', 5), ('w8', 'h6', 6),
       ('w8', 'h7', 1), ('w8', 'h8', 3);


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



