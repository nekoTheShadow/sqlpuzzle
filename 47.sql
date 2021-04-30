DROP TABLE IF EXISTS Reservations;
DROP FUNCTION IF EXISTS count_overlap;

CREATE TABLE Reservations (
  reserver CHAR(10) NOT NULL PRIMARY KEY,
  start_seat INTEGER NOT NULL,
  finish_seat INTEGER NOT NULL
);

CREATE FUNCTION count_overlap(next_start_seat INT, next_finish_seat INT) RETURNS BIGINT AS $$
  SELECT COUNT(*)
  FROM Reservations r
  WHERE next_start_seat <= r.finish_seat AND next_finish_seat >= r.start_seat
$$ LANGUAGE SQL; 

ALTER TABLE Reservations 
ADD CONSTRAINT check_overlap
CHECK (count_overlap(start_seat, finish_seat) = 0);

-- OK
INSERT INTO Reservations VALUES ('Eenie',  1, 4);
INSERT INTO Reservations VALUES ('Meanie', 6, 7);
INSERT INTO Reservations VALUES ('Mynie',  10, 15);
INSERT INTO Reservations VALUES ('Melvin', 16, 18);

-- NG
-- INSERT INTO Reservations VALUES ('Alice', 2, 3);
-- INSERT INTO Reservations VALUES ('Bob', 4, 5);
-- INSERT INTO Reservations VALUES ('Carol', 2, 11);
