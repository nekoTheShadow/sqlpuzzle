DROP TABLE IF EXISTS ManufactHrsCosts;
DROP TABLE IF EXISTS Machines;

CREATE TABLE Machines
(machine_name CHAR(20) NOT NULL PRIMARY KEY,
 purchase_date DATE NOT NULL,
 initial_cost DECIMAL (10,2) NOT NULL,
 lifespan INTEGER NOT NULL);

CREATE TABLE ManufactHrsCosts
(machine_name CHAR(20) NOT NULL
    REFERENCES Machines(machine_name),
 manu_date DATE NOT NULL,
 batch_nbr INTEGER NOT NULL,
 manu_hrs DECIMAL(4,2) NOT NULL,
 manu_cost DECIMAL (6,2) NOT NULL,
    PRIMARY KEY (machine_name, manu_date, batch_nbr));

--機械テーブル
INSERT INTO Machines VALUES('Frammis', '1995-07-24', 10000, 1000);

--作業時間コストテーブル
INSERT INTO ManufactHrsCosts VALUES('Frammis',  '1995-07-24',   101,  2.5, 123.00);
INSERT INTO ManufactHrsCosts VALUES('Frammis',  '1995-07-25',   102,  2.5, 120.00);
INSERT INTO ManufactHrsCosts VALUES('Frammis',  '1995-07-25',   103,  2.0, 100.00);
INSERT INTO ManufactHrsCosts VALUES('Frammis',  '1995-07-26',   104,  2.5, 118.00);
INSERT INTO ManufactHrsCosts VALUES('Frammis',  '1995-07-27',   105,  2.5, 116.00);
INSERT INTO ManufactHrsCosts VALUES('Frammis',  '1995-07-27',   106,  2.5, 113.00);
INSERT INTO ManufactHrsCosts VALUES('Frammis',  '1995-07-28',   107,  2.5, 110.00);

SELECT 
  ((SELECT LEAST(initial_cost / lifespan * (DATE '1995-07-27' - purchase_date), initial_cost)
    FROM Machines 
    WHERE machine_name = 'Frammis') + SUM(manu_cost)) / SUM(manu_hrs)
FROM ManufactHrsCosts
WHERE machine_name = 'Frammis' AND manu_date <= '1995-07-27'
