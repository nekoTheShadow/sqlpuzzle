DROP TABLE IF EXISTS Sine;

CREATE TABLE Sine
(x REAL NOT NULL,
 sin REAL NOT NULL);

INSERT INTO Sine VALUES (0.00, 0.0000);
INSERT INTO Sine VALUES (0.75, 0.6816); 
INSERT INTO Sine VALUES (0.76, 0.6889);
INSERT INTO Sine VALUES (1.00, 1.0000);

-- 解答コピペ(´・ω・`)
SELECT a.sin + (0.754 - a.x) * ((b.sin - a.sin) / (b.x - a.x))
FROM Sine a, Sine b
WHERE a.x = (SELECT MAX(x) FROM Sine WHERE x <= 0.754)
AND b.x = (SELECT MIN(x) FROM Sine WHERE x >= 0.754);


