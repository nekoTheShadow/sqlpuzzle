DROP TABLE IF EXISTS RacingResults;

CREATE TABLE RacingResults
(track_id CHAR(3) NOT NULL,
 race_date DATE NOT NULL,
 race_nbr INTEGER NOT NULL,
 win_name CHAR(30) NOT NULL,
 place_name CHAR(30) NOT NULL,
 show_name CHAR(30) NOT NULL,
    PRIMARY KEY (track_id, race_date, race_nbr));

INSERT INTO RacingResults VALUES(1, '2007-05-01', 1, 'A', 'B', 'C');
INSERT INTO RacingResults VALUES(1, '2007-05-01', 2, 'E', 'F', 'P');
INSERT INTO RacingResults VALUES(1, '2007-05-02', 1, 'B', 'C', 'A');
INSERT INTO RacingResults VALUES(2, '2007-05-02', 1, 'O', 'P', 'Q');
INSERT INTO RacingResults VALUES(2, '2007-05-02', 2, 'A', 'P', 'Q');

SELECT horse_name, COUNT(*)
FROM (
          SELECT win_name   FROM RacingResults
UNION ALL SELECT place_name FROM RacingResults
UNION ALL SELECT show_name  FROM RacingResults
) t (horse_name)
GROUP BY horse_name
ORDER BY horse_name

