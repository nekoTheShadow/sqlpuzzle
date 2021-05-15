DROP TABLE IF EXISTS Projects;

CREATE TABLE Projects
(workorder_id CHAR(5) NOT NULL,
 step_nbr INTEGER NOT NULL
    CHECK (step_nbr BETWEEN 0 AND 1000),
 step_status CHAR(1) NOT NULL
    CHECK (step_status IN ('C', 'W')), -- Cは完了、Wは待機
    PRIMARY KEY (workorder_id, step_nbr));

INSERT INTO Projects VALUES('AA100', 0, 'C' );
INSERT INTO Projects VALUES('AA100', 1, 'W' );
INSERT INTO Projects VALUES('AA100', 2, 'W' );
INSERT INTO Projects VALUES('AA200', 0, 'W' );
INSERT INTO Projects VALUES('AA200', 1, 'W' );
INSERT INTO Projects VALUES('AA300', 0, 'C' );
INSERT INTO Projects VALUES('AA300', 1, 'C' );

-- 自分の解答
SELECT workorder_id
FROM Projects
GROUP BY workorder_id
HAVING SUM(CASE WHEN step_nbr = 0 AND step_status = 'C' THEN 1 ELSE 0 END) = 1
AND SUM(CASE WHEN step_nbr > 0 AND step_status = 'W' THEN 1 ELSE 0 END) = COUNT(*) - 1;

-- その1がわかりやすいので写経
SELECT workorder_id
FROM Projects p1
WHERE step_nbr = 0
AND step_status = 'C'
AND 'W' = ALL (
  SELECT step_status
  FROM Projects p2
  WHERE p1.workorder_id = p2.workorder_id
  AND p2.step_nbr > 0
)
