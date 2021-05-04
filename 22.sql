DROP TABLE IF EXISTS Tenants;
DROP TABLE IF EXISTS Units;
DROP TABLE IF EXISTS RentPayments;

CREATE TABLE Tenants
 (tenant_id INTEGER,
  unit_nbr  INTEGER,
  vacated_date DATE,
  PRIMARY KEY (tenant_id, unit_nbr));

CREATE TABLE Units
 (complex_id INTEGER,
  unit_nbr   INTEGER,
  PRIMARY KEY (complex_id, unit_nbr));

CREATE TABLE RentPayments
 (tenant_id   INTEGER,
  unit_nbr   INTEGER,
  payment_date   DATE,
  PRIMARY KEY (tenant_id, unit_nbr));

--サンプルデータ
INSERT INTO Tenants VALUES(1, 1, NULL);
INSERT INTO Tenants VALUES(1, 2, NULL);
INSERT INTO Tenants VALUES(1, 3, '2007-01-01');

INSERT INTO Units VALUES(32, 1);
INSERT INTO Units VALUES(32, 2);
INSERT INTO Units VALUES(32, 3);

/* ユニット１は家賃を払っている。２は払っていない */
INSERT INTO RentPayments VALUES(1, 1, '2007-03-01');

SELECT *
FROM Units u
LEFT OUTER JOIN Tenants t ON u.unit_nbr = t.unit_nbr
LEFT OUTER JOIN RentPayments r ON t.unit_nbr = r.unit_nbr AND t.tenant_id = r.tenant_id
WHERE u.complex_id = '32'
AND t.vacated_date IS NULL
AND (r.payment_date IS NULL OR r.payment_date BETWEEN '2007-02-15' AND '2007-03-15')

