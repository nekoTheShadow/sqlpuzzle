DROP TABLE IF EXISTS Samples;
DROP TABLE IF EXISTS SampleGroups;

CREATE TABLE Samples
(sample_id INTEGER NOT NULL,
 fish_name CHAR(20) NOT NULL,
 found_tally INTEGER NOT NULL,
    PRIMARY KEY (sample_id, fish_name));

CREATE TABLE SampleGroups
(group_id INTEGER NOT NULL,
 group_descr CHAR(20) NOT NULL,
 sample_id INTEGER NOT NULL,
    PRIMARY KEY (group_id, sample_id));

INSERT INTO Samples VALUES (1, 'minnow', 18);
INSERT INTO Samples VALUES (1, 'pike', 7);
INSERT INTO Samples VALUES (2, 'pike', 4);
INSERT INTO Samples VALUES (2, 'carp', 3);
INSERT INTO Samples VALUES (3, 'carp', 9);

INSERT INTO SampleGroups VALUES (1, 'muddy water', 1);
INSERT INTO SampleGroups VALUES (1, 'muddy water', 2);
INSERT INTO SampleGroups VALUES (2, 'fresh water', 1);
INSERT INTO SampleGroups VALUES (2, 'fresh water', 3);
INSERT INTO SampleGroups VALUES (2, 'fresh water', 2);

SELECT SUM(CASE WHEN fish_name = :fish_name THEN found_tally ELSE 0 END) / COUNT(DISTINCT s.sample_id)
FROM SampleGroups sg
JOIN Samples s ON sg.sample_id = s.sample_id
WHERE group_id = :group_id
