-- 問題20
CREATE TABLE TestResults
(test_name CHAR(20) NOT NULL,
 test_step INTEGER NOT NULL,
 comp_date DATE, -- NULLは未完了を意味する
    PRIMARY KEY (test_name, test_step));

INSERT INTO TestResults VALUES('読解', 1, '2006-03-10');
INSERT INTO TestResults VALUES('読解', 2, '2006-03-12');
INSERT INTO TestResults VALUES('数学', 1, NULL);
INSERT INTO TestResults VALUES('数学', 2, '2006-03-12');
INSERT INTO TestResults VALUES('化学', 1, '2006-03-08');
INSERT INTO TestResults VALUES('化学', 2, '2006-03-12');
INSERT INTO TestResults VALUES('化学', 3, '2006-03-15');

SELECT test_name
FROM TestResults 
GROUP BY test_name
HAVING COUNT(*) = COUNT(comp_date)
