-- 本書ではINSERTやUPDATEを利用する方法も紹介されているが、
-- trendは計算列のため、固定値としては持たない方法がよいと
-- 個人的には考える。

DROP VIEW IF EXISTS StockTrend;
DROP TABLE IF EXISTS StockHistory;

CREATE TABLE StockHistory (
  ticker_sym CHAR(5) NOT NULL,
  sale_date DATE DEFAULT CURRENT_DATE NOT NULL,
  closing_price DECIMAL (10,4) NOT NULL,
  PRIMARY KEY (ticker_sym, sale_date)
);

INSERT INTO StockHistory VALUES(1, '2007-04-01', 100);
INSERT INTO StockHistory VALUES(1, '2007-04-02', 200);
INSERT INTO StockHistory VALUES(1, '2007-04-03', 199);
INSERT INTO StockHistory VALUES(1, '2007-04-04', 199);
INSERT INTO StockHistory VALUES(2, '2006-10-10', 10);
INSERT INTO StockHistory VALUES(2, '2007-04-14', 20);
INSERT INTO StockHistory VALUES(2, '2007-04-20',  5);
  

CREATE VIEW StockTrend AS (
  SELECT 
    ticker_sym,
    sale_date,
    closing_price,
    SIGN(closing_price - LAG(closing_price) OVER (PARTITION BY ticker_sym ORDER BY sale_date)) AS trend 
  FROM StockHistory
);

SELECT * FROM StockTrend;

