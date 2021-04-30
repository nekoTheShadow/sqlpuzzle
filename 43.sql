DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS CreditsEarned;

CREATE TABLE Categories
(credit_cat CHAR(1) NOT NULL,
 rqd_credits INTEGER NOT NULL);

CREATE TABLE CreditsEarned --主キーなし
(student_name CHAR(10) NOT NULL,
 credit_cat CHAR(1) NOT NULL,
 credits INTEGER NOT NULL);

INSERT INTO Categories VALUES ('A', 10);
INSERT INTO Categories VALUES ('B', 3);
INSERT INTO Categories VALUES ('C', 5);

INSERT INTO CreditsEarned
VALUES ('Joe', 'A', 3), ('Joe', 'A', 2), ('Joe', 'A', 3),
       ('Joe', 'A', 3), ('Joe', 'B', 3), ('Joe', 'C', 3),
       ('Joe', 'C', 2), ('Joe', 'C', 3),
       ('Bob', 'A', 2), ('Bob', 'C', 2), ('Bob', 'A', 12),
       ('Bob', 'C', 4),
       ('John', 'A', 1), ('John', 'B', 1),
       ('Mary', 'A', 1), ('Mary', 'A', 1), ('Mary', 'A', 1),
       ('Mary', 'A', 1), ('Mary', 'A', 1), ('Mary', 'A', 1),
       ('Mary', 'A', 1), ('Mary', 'A', 1), ('Mary', 'A', 1),
       ('Mary', 'A', 1), ('Mary', 'A', 1), ('Mary', 'B', 1),
       ('Mary', 'B', 1), ('Mary', 'B', 1), ('Mary', 'B', 1),
       ('Mary', 'B', 1), ('Mary', 'B', 1), ('Mary', 'B', 1),
       ('Mary', 'C', 1), ('Mary', 'C', 1), ('Mary', 'C', 1),
       ('Mary', 'C', 1), ('Mary', 'C', 1), ('Mary', 'C', 1),
       ('Mary', 'C', 1), ('Mary', 'C', 1);

SELECT 
  t.student_name, 
  CASE WHEN (SELECT COUNT(*) cnt FROM Categories) =  SUM(CASE WHEN c.rqd_credits <= t.credits_tot THEN 1 ELSE 0 END) THEN 'X' ELSE '' END grad,
  CASE WHEN (SELECT COUNT(*) cnt FROM Categories) <> SUM(CASE WHEN c.rqd_credits <= t.credits_tot THEN 1 ELSE 0 END) THEN 'X' ELSE '' END nograd
FROM Categories c
JOIN (
  SELECT 
    student_name, 
    credit_cat,
    SUM(credits) credits_tot
  FROM CreditsEarned
  GROUP BY student_name, credit_cat
) t ON c.credit_cat = t.credit_cat
GROUP BY t.student_name
