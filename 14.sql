DROP TABLE IF EXISTS Phones;
DROP TABLE IF EXISTS Personnel;

CREATE TABLE Personnel
(emp_id INTEGER PRIMARY KEY,
 first_name CHAR(20) NOT NULL,
 last_name CHAR(20) NOT NULL);

CREATE TABLE Phones
(emp_id INTEGER NOT NULL,
 phone_type CHAR(3) NOT NULL
    CHECK (phone_type IN ('hom', 'fax')),
 phone_nbr CHAR(12) NOT NULL,
    PRIMARY KEY (emp_id, phone_type),
    FOREIGN KEY (emp_id) REFERENCES Personnel(emp_id));

INSERT INTO Personnel VALUES(1, '山田', '太郎');
INSERT INTO Personnel VALUES(2, '上野', '二郎');
INSERT INTO Personnel VALUES(3, '高田', '三郎');
INSERT INTO Personnel VALUES(4, '松岡', '四郎');

INSERT INTO Phones VALUES(1, 'hom', 1111);
INSERT INTO Phones VALUES(1, 'fax', 2222);
INSERT INTO Phones VALUES(2, 'hom', 3333);
INSERT INTO Phones VALUES(3, 'fax', 4444);

-- 解答1: CASEを活用する。その代わりJOINは1回だけ
SELECT 
  P1.*,
  MAX(CASE WHEN P2.phone_type = 'hom' THEN phone_nbr END),
  MAX(CASE WHEN P2.phone_type = 'fax' THEN phone_nbr END)
FROM Personnel P1
LEFT OUTER JOIN Phones P2 ON P1.emp_id = P2.emp_id
GROUP BY P1.emp_id;

-- 解答2: 2回JOINする。
SELECT P.*, Q1.phone_nbr, Q2.phone_nbr
FROM Personnel P
LEFT OUTER JOIN Phones Q1 ON P.emp_id = Q1.emp_id AND Q1.phone_type = 'hom'
LEFT OUTER JOIN Phones Q2 ON P.emp_id = Q2.emp_id AND Q2.phone_type = 'fax'

