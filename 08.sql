DROP TABLE IF EXISTS PrinterControl;
DROP TABLE IF EXISTS Printer;

-- プリンタマスタ
CREATE TABLE Printer (
  printer_name CHAR(4) NOT NULL,
  printer_description CHAR(40) NOT NULL,
  PRIMARY KEY (printer_name)
);

-- ユーザごとに利用できるプリンタを管理する。
CREATE TABLE PrinterControl (
  user_id CHAR(10) NOT NULL PRIMARY KEY,
  printer_name CHAR(4) NOT NULL REFERENCES Printer(printer_name)
);

INSERT INTO Printer VALUES('LPT1',  '一階のプリンタ');
INSERT INTO Printer VALUES('LPT2',  '二階のプリンタ'); 
INSERT INTO Printer VALUES('LPT3',  '三階のプリンタ' );
INSERT INTO Printer VALUES('LPT4',  '共有プリンタ' );
INSERT INTO Printer VALUES('LPT5',  '共有プリンタ' );

INSERT INTO PrinterControl VALUES('chacha', 'LPT1');
INSERT INTO PrinterControl VALUES('lee'   , 'LPT2'); 
INSERT INTO PrinterControl VALUES('thomas', 'LPT3');

-- テーブルに登録されているユーザ
WITH T AS (
  SELECT printer_name
  FROM Printer P
  WHERE NOT EXISTS (
    SELECT *
    FROM PrinterControl PC
    WHERE P.printer_name = PC.printer_name
  )
)
SELECT COALESCE(MIN(PC.printer_name), (SELECT MIN(printer_name) FROM T))
FROM PrinterControl PC
WHERE PC.user_id = 'lee';

-- テーブルに登録されていないユーザ
WITH T AS (
  SELECT printer_name
  FROM Printer P
  WHERE NOT EXISTS (
    SELECT *
    FROM PrinterControl PC
    WHERE P.printer_name = PC.printer_name
  )
)
SELECT COALESCE(MIN(PC.printer_name), (SELECT MIN(printer_name) FROM T))
FROM PrinterControl PC
WHERE PC.user_id = 'john';
