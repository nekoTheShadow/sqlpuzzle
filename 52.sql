DROP TABLE IF EXISTS Personnel;

CREATE TABLE Personnel
(emp_name CHAR(10) NOT NULL,
 dept_id  CHAR(10) );

INSERT INTO Personnel VALUES('Daren', 'Acct');
INSERT INTO Personnel VALUES('Joe'  , 'Acct');
INSERT INTO Personnel VALUES('Lisa' , 'DP');
INSERT INTO Personnel VALUES('Helen', 'DP');
INSERT INTO Personnel VALUES('Fonda', 'DP');
INSERT INTO Personnel VALUES('Larry', NULL);
INSERT INTO Personnel VALUES('Moe', NULL);
INSERT INTO Personnel VALUES('Curly', NULL);

-- NULLをどのように扱うかだが、ここでは新人ととらえてTRAINEEとして処理する。
SELECT 1.0 * COUNT(*) / COUNT(DISTINCT COALESCE(dept_id, 'Trainee'))
FROM Personnel
