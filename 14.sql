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

INSERT INTO Personnel VALUES(1, '�R�c', '���Y');
INSERT INTO Personnel VALUES(2, '���', '��Y');
INSERT INTO Personnel VALUES(3, '���c', '�O�Y');
INSERT INTO Personnel VALUES(4, '����', '�l�Y');

INSERT INTO Phones VALUES(1, 'hom', 1111);
INSERT INTO Phones VALUES(1, 'fax', 2222);
INSERT INTO Phones VALUES(2, 'hom', 3333);
INSERT INTO Phones VALUES(3, 'fax', 4444);

-- ��1: CASE�����p����B���̑���JOIN��1�񂾂�
SELECT 
  P1.*,
  MAX(CASE WHEN P2.phone_type = 'hom' THEN phone_nbr END),
  MAX(CASE WHEN P2.phone_type = 'fax' THEN phone_nbr END)
FROM Personnel P1
LEFT OUTER JOIN Phones P2 ON P1.emp_id = P2.emp_id
GROUP BY P1.emp_id;

-- ��2: 2��JOIN����B
SELECT P.*, Q1.phone_nbr, Q2.phone_nbr
FROM Personnel P
LEFT OUTER JOIN Phones Q1 ON P.emp_id = Q1.emp_id AND Q1.phone_type = 'hom'
LEFT OUTER JOIN Phones Q2 ON P.emp_id = Q2.emp_id AND Q2.phone_type = 'fax'

