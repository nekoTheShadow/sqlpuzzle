DROP TABLE IF EXISTS Roles;

CREATE TABLE Roles(
 person VARCHAR(32), 
 role   VARCHAR(32), 
    PRIMARY KEY (person, role));

INSERT INTO Roles VALUES('Smith', 'O');
INSERT INTO Roles VALUES('Smith', 'D');
INSERT INTO Roles VALUES('Jones', 'O');
INSERT INTO Roles VALUES('White', 'D');
INSERT INTO Roles VALUES('Brown', 'X');

SELECT person, CASE WHEN COUNT(*) = 1 THEN MAX(role) ELSE 'B' END
FROM Roles
WHERE role IN ('D', 'O')
GROUP BY person
