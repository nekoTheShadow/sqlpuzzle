DROP TABLE IF EXISTS PubMap;

CREATE TABLE PubMap
(pub_id CHAR(5) NOT NULL PRIMARY KEY,
x INTEGER NOT NULL,
y INTEGER NOT NULL);

--始点(0, 0)
INSERT INTO PubMap VALUES(1, 0,  0);

--半径１：○
INSERT INTO PubMap VALUES(2, 0,  1);
INSERT INTO PubMap VALUES(3, 1,  0);

--半径√2：×
INSERT INTO PubMap VALUES(4, 1,  1);
--半径√5：×
INSERT INTO PubMap VALUES(5, -2, 0);

-- それぞれの居酒屋から最も近い居酒屋を求める。
SELECT pub_id1, pub_id2, dist
FROM (
  SELECT 
    P1.pub_id pub_id1,
    P2.pub_id pub_id2,
    RANK() OVER (PARTITION BY P1.pub_id ORDER BY SQRT(POWER(P1.x - P2.x, 2) + POWER(P1.y - P2.y, 2))) rnk,
    SQRT(POWER(P1.x - P2.x, 2) + POWER(P1.y - P2.y, 2)) dist
  FROM PubMap P1
  JOIN PubMap P2 ON P1.pub_id <> P2.pub_id
) t
WHERE rnk = 1;
