DROP TABLE IF EXISTS FiscalYearTable1;

CREATE TABLE FiscalYearTable1 (
  fiscal_year INTEGER NOT NULL PRIMARY KEY,
  start_date  DATE    NOT NULL
    CHECK (EXTRACT(YEAR  FROM start_date) = fiscal_year)
    CHECK (EXTRACT(MONTH FROM start_date) = 10)
    CHECK (EXTRACT(DAY   FROM start_date) = 1),
  end_date    DATE    NOT NULL
    CHECK (EXTRACT(YEAR  FROM end_date) = fiscal_year+1)
    CHECK (EXTRACT(MONTH FROM end_date) = 9)
    CHECK (EXTRACT(DAY   FROM end_date) = 30)
);

--正常データ
INSERT INTO FiscalYearTable1 VALUES(1995, '1994-10-01', '1995-09-30');
INSERT INTO FiscalYearTable1 VALUES(1997, '1996-10-01', '1997-09-30');
INSERT INTO FiscalYearTable1 VALUES(1998, '1997-10-01', '1998-09-30');

--エラーデータ
INSERT INTO FiscalYearTable1 VALUES(1996, '1995-10-01', '1996-08-30');  -- 終了日が8月
INSERT INTO FiscalYearTable1 VALUES(1999, '1998-10-02', '1999-09-30');  -- 開始日が2日