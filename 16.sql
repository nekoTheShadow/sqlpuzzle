DROP TABLE IF EXISTS Jobs CASCADE;
DROP TABLE IF EXISTS Personnel CASCADE;
DROP TABLE IF EXISTS Teams CASCADE;


CREATE TABLE Personnel (
  emp_id    INTEGER  NOT NULL,
  emp_name  CHAR(20) NOT NULL,
  mech_type CHAR(10) NOT NULL,
  
  PRIMARY KEY (emp_id),
  CHECK (mech_type IN ('Primary', 'Assistant')),
  UNIQUE (emp_id, mech_type)
);

CREATE TABLE Jobs (
  job_id     INTEGER NOT NULL,
  start_date DATE    NOT NULL,
  PRIMARY KEY (job_id)
);

CREATE TABLE Teams (
  job_id       INTEGER  NOT NULL,
  primary_mech INTEGER  NOT NULL,
  primary_type CHAR(10) NOT NULL DEFAULT 'Primary',
  assist_mech  INTEGER  NOT NULL,
  assist_type  CHAR(10) NOT NULL DEFAULT 'Assistant',
  
  CHECK (primary_type = 'Primary'),
  CHECK (assist_type = 'Assistant'),
  CHECK (COALESCE (primary_mech, assist_mech) IS NOT NULL),
  
  FOREIGN KEY (job_id) REFERENCES Jobs(job_id),
  FOREIGN KEY (primary_mech, primary_type) REFERENCES Personnel(emp_id, mech_type),
  FOREIGN KEY (assist_mech, assist_type) REFERENCES Personnel(emp_id, mech_type)
) ;

INSERT INTO Personnel VALUES(1, '赤木',  'Primary');
INSERT INTO Personnel VALUES(2, '伊藤',  'Assistant');
INSERT INTO Personnel VALUES(3, '宇佐美','Primary');

INSERT INTO Jobs VALUES(1, '2007-01-01');
INSERT INTO Jobs VALUES(2, '2007-02-01');
INSERT INTO Jobs VALUES(3, '2007-03-01');
INSERT INTO Jobs VALUES(4, '2007-04-01');

INSERT INTO Teams VALUES(1, 1, 'Primary', 2, 'Assistant');
INSERT INTO Teams VALUES(2, 3, 'Primary', 2, 'Assistant');

SELECT 
  job_id,
  P1.emp_name AS primary_name,
  P2.emp_name AS assist_name
FROM Teams T
JOIN Personnel P1 ON T.primary_mech = P1.emp_id
JOIN Personnel P2 ON T.assist_mech = P2.emp_id
WHERE job_id = 1;
