DROP TABLE IF EXISTS Production;

CREATE TABLE Production
(production_center INTEGER NOT NULL,
 wk_date DATE NOT NULL,
 batch_nbr INTEGER NOT NULL,
 widget_cnt INTEGER NOT NULL,
    PRIMARY KEY (production_center, wk_date, batch_nbr));

INSERT INTO Production VALUES(1, '2007-05-02', 1, 1);
INSERT INTO Production VALUES(1, '2007-05-02', 2, 2);
INSERT INTO Production VALUES(1, '2007-05-02', 3, 3);
INSERT INTO Production VALUES(1, '2007-05-02', 4, 4);
INSERT INTO Production VALUES(1, '2007-05-02', 5, 5);
INSERT INTO Production VALUES(1, '2007-05-02', 6, 6);
INSERT INTO Production VALUES(1, '2007-05-02', 7, 7);

INSERT INTO Production VALUES(1, '2007-10-02', 1, 1);
INSERT INTO Production VALUES(1, '2007-10-02', 2, 2);
INSERT INTO Production VALUES(1, '2007-10-02', 3, 3);

SELECT 
  production_center, 
  wk_date,
  AVG(CASE WHEN grp = 1 THEN widget_cnt END) grp1,
  AVG(CASE WHEN grp = 2 THEN widget_cnt END) grp2,
  AVG(CASE WHEN grp = 3 THEN widget_cnt END) grp3
FROM (
  SELECT *, NTILE(3) OVER (PARTITION BY production_center, wk_date ORDER BY batch_nbr) AS grp
  FROM Production
) t
GROUP BY production_center, wk_date;

