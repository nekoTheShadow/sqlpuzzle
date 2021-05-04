DROP TABLE IF EXISTS ServicesSchedule;

CREATE TABLE ServicesSchedule
(shop_id CHAR(3) NOT NULL,
 order_nbr CHAR(10) NOT NULL,
 sch_seq INTEGER NOT NULL CHECK (sch_seq IN (1,2,3)),
 service_type CHAR(2) NOT NULL,
 sch_date DATE,
    PRIMARY KEY (shop_id, order_nbr, sch_seq));

INSERT INTO ServicesSchedule VALUES('002',   '4155526710',   1,   '01', '1994-07-16' );
INSERT INTO ServicesSchedule VALUES('002',   '4155526710',   2,   '01', '1994-07-30' ); 
INSERT INTO ServicesSchedule VALUES('002',   '4155526710',   3,   '01', '1994-10-01' );
INSERT INTO ServicesSchedule VALUES('002',   '4155526711',   1,   '01', '1994-07-16' ); 
INSERT INTO ServicesSchedule VALUES('002',   '4155526711',   2,   '01', '1994-07-30' ); 
INSERT INTO ServicesSchedule VALUES('002',   '4155526711',   3,   '01',  NULL ); 

SELECT
  order_nbr,
  MAX(CASE WHEN sch_seq = 1 THEN sch_date END) AS processed,
  MAX(CASE WHEN sch_seq = 2 THEN sch_date END) AS completed,
  MAX(CASE WHEN sch_seq = 3 THEN sch_date END) AS confirmed
FROM ServicesSchedule
GROUP BY order_nbr;

