DROP TABLE IF EXISTS SalesData;

CREATE TABLE SalesData
(district_nbr INTEGER NOT NULL,
 sales_person CHAR(10) NOT NULL,
 sales_id INTEGER NOT NULL,
 sales_amt DECIMAL(5,2) NOT NULL);

INSERT INTO SalesData VALUES(1, 'カーリー'     ,   5,  3.00  );
INSERT INTO SalesData VALUES(1, 'ハーポ'       ,  11,  4.00  );
INSERT INTO SalesData VALUES(1, 'ラリー'       ,   1, 50.00  );
INSERT INTO SalesData VALUES(1, 'ラリー'       ,   2, 50.00  );
INSERT INTO SalesData VALUES(1, 'ラリー'       ,   3, 50.00  );
INSERT INTO SalesData VALUES(1, 'モー'         ,   4,  5.00  );
INSERT INTO SalesData VALUES(2, 'ディック'     ,   8,  5.00  );
INSERT INTO SalesData VALUES(2, 'フレッド'     ,   7,  5.00  );
INSERT INTO SalesData VALUES(2, 'ハリー'       ,   6,  5.00  );
INSERT INTO SalesData VALUES(2, 'トム'         ,   7,  5.00  );
INSERT INTO SalesData VALUES(3, 'アーヴィン' ,  10,  5.00  );
INSERT INTO SalesData VALUES(3, 'メルヴィン'   ,   9,  7.00  );
INSERT INTO SalesData VALUES(4, 'ジェニー'     ,  15, 20.00  );
INSERT INTO SalesData VALUES(4, 'ジェシー'     ,  16, 10.00  );
INSERT INTO SalesData VALUES(4, 'メアリー'     ,  12, 50.00  );
INSERT INTO SalesData VALUES(4, 'オプラ'       ,  14, 30.00  );
INSERT INTO SalesData VALUES(4, 'サリー'       ,  13, 40.00  );

SELECT *
FROM (
  SELECT *, DENSE_RANK() OVER (PARTITION BY district_nbr ORDER BY sales_amt DESC) rnk
  FROM SalesData
) T
WHERE rnk <= 3
