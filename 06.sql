DROP TABLE IF EXISTS Hotel;

CREATE TABLE Hotel
(room_nbr INTEGER NOT NULL,
 arrival_date DATE NOT NULL,
 departure_date DATE NOT NULL,
 guest_name CHAR(30) NOT NULL,
    PRIMARY KEY (room_nbr, arrival_date),
    CHECK (departure_date >= arrival_date));
    
CREATE OR REPLACE FUNCTION count_overlaps(
  next_room_nbr INTEGER, 
  next_arrival_date DATE,
  next_departure_date DATE
) RETURNS BIGINT AS $$    
  SELECT COUNT(*)
  FROM Hotel H
  WHERE H.room_nbr = next_room_nbr
  AND (next_arrival_date, next_departure_date) OVERLAPS (H.arrival_date, H.departure_date)
$$ LANGUAGE SQL; 

ALTER TABLE Hotel 
ADD CONSTRAINT check_overlaps
CHECK (count_overlaps(room_nbr, arrival_date, departure_date) = 0);

-- OK
INSERT INTO Hotel VALUES (1, '2008-01-01', '2008-01-03', 'Coe');
-- OK
INSERT INTO Hotel VALUES (1, '2008-01-03', '2008-01-05', 'Doe');
-- 失敗！ Coe氏とかぶる
INSERT INTO Hotel VALUES (1, '2008-01-02', '2008-01-05', 'Roe');


