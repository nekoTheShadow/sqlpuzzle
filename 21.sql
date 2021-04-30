CREATE TABLE PilotSkills
(pilot CHAR(15) NOT NULL,
 plane CHAR(15) NOT NULL,
    PRIMARY KEY (pilot, plane));

CREATE TABLE Hangar
(plane CHAR(15) PRIMARY KEY);

INSERT INTO PilotSkills VALUES ('Celko', 'Piper Cub');
INSERT INTO PilotSkills VALUES ('Higgins', 'B-52 Bomber');
INSERT INTO PilotSkills VALUES ('Higgins', 'F-14 Fighter');
INSERT INTO PilotSkills VALUES ('Higgins', 'Piper Cub');
INSERT INTO PilotSkills VALUES ('Jones', 'B-52 Bomber');
INSERT INTO PilotSkills VALUES ('Jones', 'F-14 Bomber');
INSERT INTO PilotSkills VALUES ('Smith', 'B-1 Bomber');
INSERT INTO PilotSkills VALUES ('Smith', 'B-52 Bomber');
INSERT INTO PilotSkills VALUES ('Smith', 'F-14 Fighter');
INSERT INTO PilotSkills VALUES ('Wilson', 'B-1 Bomber');
INSERT INTO PilotSkills VALUES ('Wilson', 'B-52 Bomber');
INSERT INTO PilotSkills VALUES ('Wilson', 'F-14 Fighter');
INSERT INTO PilotSkills VALUES ('Wilson', 'F-17 Fighter');

INSERT INTO Hangar VALUES ('B-1 Bomber');
INSERT INTO Hangar VALUES ('B-52 Bomber');
INSERT INTO Hangar VALUES ('F-14 Fighter');

SELECT p.pilot
FROM PilotSkills p
JOIN Hangar h ON p.plane = h.plane
GROUP BY p.pilot
HAVING COUNT(*) = (SELECT COUNT(*) FROM Hangar)