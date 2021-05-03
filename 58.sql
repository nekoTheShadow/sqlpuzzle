DROP TABLE IF EXISTS Tickets;

CREATE TABLE Tickets
(buyer_name CHAR(5) NOT NULL,
 ticket_nbr INTEGER DEFAULT 1 NOT NULL
    CHECK (ticket_nbr > 0),
    PRIMARY KEY (buyer_name, ticket_nbr));

INSERT INTO Tickets VALUES ('a', 2);
INSERT INTO Tickets VALUES ('a', 3);
INSERT INTO Tickets VALUES ('a', 4);
INSERT INTO Tickets VALUES ('b', 4);
INSERT INTO Tickets VALUES ('c', 1);
INSERT INTO Tickets VALUES ('c', 2);
INSERT INTO Tickets VALUES ('c', 3);
INSERT INTO Tickets VALUES ('c', 4);
INSERT INTO Tickets VALUES ('c', 5);
INSERT INTO Tickets VALUES ('d', 1);
INSERT INTO Tickets VALUES ('d', 6);
INSERT INTO Tickets VALUES ('d', 7);
INSERT INTO Tickets VALUES ('d', 9);
INSERT INTO Tickets VALUES ('e', 10);

WITH RECURSIVE r (buyer_name, ticket_nbr) AS (
    SELECT buyer_name, 1 FROM Tickets GROUP BY buyer_name
  UNION ALL
    SELECT r.buyer_name, r.ticket_nbr + 1
    FROM r
    WHERE r.ticket_nbr < (
      SELECT MAX(t.ticket_nbr) 
      FROM Tickets t
      WHERE r.buyer_name = t.buyer_name
    )
)
SELECT * FROM r 
EXCEPT 
SELECT * FROM Tickets;
