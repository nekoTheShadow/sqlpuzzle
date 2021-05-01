DROP TABLE IF EXISTS TaxAuthorities;
DROP TABLE IF EXISTS TaxRates;

CREATE TABLE TaxAuthorities
(tax_authority CHAR(10) NOT NULL,
 tax_area CHAR(10) NOT NULL,
 PRIMARY KEY (tax_authority, tax_area));

CREATE TABLE TaxRates
(tax_authority CHAR(10) NOT NULL,
 effect_date DATE NOT NULL,
 tax_rate DECIMAL (8,2) NOT NULL,
 PRIMARY KEY (tax_authority, effect_date));

--税務当局テーブル
INSERT INTO TaxAuthorities VALUES('city1',   'city1');
INSERT INTO TaxAuthorities VALUES('city2',   'city2');
INSERT INTO TaxAuthorities VALUES('city3',   'city3');
INSERT INTO TaxAuthorities VALUES('county1', 'city1');
INSERT INTO TaxAuthorities VALUES('county1', 'city2');
INSERT INTO TaxAuthorities VALUES('county2', 'city3');
INSERT INTO TaxAuthorities VALUES('state1',  'city1');
INSERT INTO TaxAuthorities VALUES('state1',  'city2');
INSERT INTO TaxAuthorities VALUES('state1',  'city3');

--税率テーブル
INSERT INTO TaxRates VALUES('city1',  '1993-01-01', 1.0);
INSERT INTO TaxRates VALUES('city1',  '1994-01-01', 1.5);
INSERT INTO TaxRates VALUES('city2',  '1993-09-01', 1.5);
INSERT INTO TaxRates VALUES('city2',  '1994-01-01', 2.0);
INSERT INTO TaxRates VALUES('city2',  '1995-01-01', 2.0);
INSERT INTO TaxRates VALUES('city3',  '1993-01-01', 1.7);
INSERT INTO TaxRates VALUES('city3',  '1993-07-01', 1.9);
INSERT INTO TaxRates VALUES('county1', '1993-01-01' , 2.3);
INSERT INTO TaxRates VALUES('county1', '1994-10-01' , 2.5);
INSERT INTO TaxRates VALUES('county1', '1995-01-01' , 2.7);
INSERT INTO TaxRates VALUES('county2', '1993-01-01' , 2.4);
INSERT INTO TaxRates VALUES('county2', '1994-01-01' , 2.7);
INSERT INTO TaxRates VALUES('county2', '1995-01-01' , 2.8);
INSERT INTO TaxRates VALUES('state1' , '1993-01-01' , 0.5);
INSERT INTO TaxRates VALUES('state1' , '1994-01-01' , 0.8);
INSERT INTO TaxRates VALUES('state1' , '1994-07-01' , 0.9);
INSERT INTO TaxRates VALUES('state1' , '1994-10-01' , 1.1);

SELECT SUM(tax_rate)
FROM TaxAuthorities AS t
JOIN (
  SELECT *, RANK() OVER (PARTITION BY tax_authority ORDER BY effect_date DESC) AS rnk
  FROM TaxRates
  WHERE effect_date <= '1994-11-01'
) AS s ON t.tax_authority = s.tax_authority
WHERE s.rnk = 1
AND t.tax_area = 'city2'
