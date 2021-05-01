DROP TABLE IF EXISTS InventoryAdjustments;

CREATE TABLE InventoryAdjustments
(req_date DATE NOT NULL,
 req_qty INTEGER NOT NULL
    CHECK (req_qty <> 0),
    PRIMARY KEY (req_date, req_qty));

INSERT INTO InventoryAdjustments VALUES('1994-07-01', 100 );
INSERT INTO InventoryAdjustments VALUES('1994-07-02', 120 );
INSERT INTO InventoryAdjustments VALUES('1994-07-03', -150);
INSERT INTO InventoryAdjustments VALUES('1994-07-04', 50  );
INSERT INTO InventoryAdjustments VALUES('1994-07-05', -35 );

SELECT req_date, SUM(req_qty) OVER (ORDER BY req_date)
FROM InventoryAdjustments;
