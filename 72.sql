DROP TABLE IF EXISTS ScheduledCalls;
DROP TABLE IF EXISTS PersonnelSchedule;
DROP TABLE IF EXISTS Clients;
DROP TABLE IF EXISTS Personnel;

CREATE TABLE Clients (
  client_id INTEGER NOT NULL PRIMARY KEY,
  client_name VARCHAR(15) NOT NULL
);

CREATE TABLE Personnel (
  emp_id CHAR(9) NOT NULL PRIMARY KEY,
  emp_name VARCHAR(15) NOT NULL
);

CREATE TABLE ScheduledCalls (
  client_id INTEGER NOT NULL REFERENCES Clients (client_id),
  scheduled_start_time TIMESTAMP NOT NULL,
  scheduled_end_time TIMESTAMP NOT NULL,
  emp_id CHAR(9) DEFAULT '{xxxxxxx}' NOT NULL
    REFERENCES Personnel (emp_id),
    CHECK (scheduled_start_time < scheduled_end_time),
    PRIMARY KEY (client_id, emp_id, scheduled_start_time)
);

CREATE TABLE PersonnelSchedule (
  emp_id CHAR(9) NOT NULL REFERENCES Personnel(emp_id),
  avail_start_time TIMESTAMP NOT NULL,
  avail_end_time TIMESTAMP NOT NULL,
  CHECK (avail_start_time < avail_end_time),
  PRIMARY KEY (emp_id, avail_start_time)
);

--顧客テーブル
INSERT INTO Clients VALUES (1, '田中 太郎');
INSERT INTO Clients VALUES (2, '田中 次郎');
INSERT INTO Clients VALUES (3, '田中 三郎');

--社員テーブル
INSERT INTO Personnel VALUES (1, '鈴木 太郎');
INSERT INTO Personnel VALUES (2, '鈴木 次郎');
INSERT INTO Personnel VALUES (3, '鈴木 三郎');

--予約テーブル
INSERT INTO ScheduledCalls VALUES(1, '2007-01-01:12:00', '2007-01-01:17:00', 1);
INSERT INTO ScheduledCalls VALUES(1, '2007-01-01:18:00', '2007-01-01:21:00', 2);
INSERT INTO ScheduledCalls VALUES(2, '2007-01-02:09:00', '2007-01-02:15:00', 3);
INSERT INTO ScheduledCalls VALUES(3, '2007-01-02:18:00', '2007-01-02:21:00', 2);

--対応可能な社員テーブル
INSERT INTO PersonnelSchedule VALUES (1, '2007-01-01:09:00', '2007-01-01:15:00');
INSERT INTO PersonnelSchedule VALUES (2, '2007-01-02:07:00', '2007-01-02:08:00');
INSERT INTO PersonnelSchedule VALUES (2, '2007-01-02:17:00', '2007-01-02:21:00');
INSERT INTO PersonnelSchedule VALUES (3, '2007-01-02:17:00', '2007-01-02:22:00');


SELECT P.emp_id,
       S.client_id,
       S.scheduled_start_time,
       S.scheduled_end_time
  FROM ScheduledCalls S
  JOIN PersonnelSchedule P 
    ON S.emp_id = P.emp_id
   AND S.scheduled_start_time BETWEEN P.avail_start_time AND P.avail_end_time
   AND S.scheduled_end_time   BETWEEN P.avail_start_time AND P.avail_end_time
 WHERE P.emp_id <> '{xxxxxxx}'

