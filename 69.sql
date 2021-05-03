DROP TABLE IF EXISTS WidgetInventory;

CREATE TABLE WidgetInventory
(receipt_nbr INTEGER NOT NULL PRIMARY KEY,
 purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
 qty_on_hand INTEGER NOT NULL
    CHECK (qty_on_hand >= 0),
 unit_price DECIMAL (12,4) NOT NULL);

INSERT INTO WidgetInventory VALUES(1, '2005-08-01', 15, 10.00);
INSERT INTO WidgetInventory VALUES(2, '2005-08-02', 25, 12.00);
INSERT INTO WidgetInventory VALUES(3, '2005-08-03', 40, 13.00);
INSERT INTO WidgetInventory VALUES(4, '2005-08-04', 35, 12.00);
INSERT INTO WidgetInventory VALUES(5, '2005-08-05', 45, 10.00);


-- LIFO
SELECT
  SUM(unit_price * CASE
                     WHEN 100 <= total THEN 
                       0
                     WHEN total + qty_on_hand <= 100 THEN
                       qty_on_hand
                     ELSE                                 
                       100 - total
                    END)
FROM (
  SELECT *, SUM(qty_on_hand) OVER(ORDER BY purchase_date DESC) - qty_on_hand total
  FROM WidgetInventory
) t;

-- FIFO
SELECT
  SUM(unit_price * CASE
                     WHEN 100 <= total THEN 
                       0
                     WHEN total + qty_on_hand <= 100 THEN
                       qty_on_hand
                     ELSE                                 
                       100 - total
                    END)
FROM (
  SELECT *, SUM(qty_on_hand) OVER(ORDER BY purchase_date) - qty_on_hand total
  FROM WidgetInventory
) t
