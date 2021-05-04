DROP TABLE IF EXISTS Register;

CREATE TABLE Register
(course_nbr INTEGER NOT NULL,
 student_name CHAR(10) NOT NULL,
 teacher_name CHAR(10) NOT NULL);

INSERT INTO Register VALUES(10, '���k�P', '�搶�P');

INSERT INTO Register VALUES(20, '���k�P', '�搶�P');
INSERT INTO Register VALUES(20, '���k�P', '�搶�Q');

INSERT INTO Register VALUES(30, '���k�P', '�搶�P');
INSERT INTO Register VALUES(30, '���k�P', '�搶�Q');
INSERT INTO Register VALUES(30, '���k�P', '�搶�R');

SELECT 
  course_nbr,
  student_name,
  MIN(teacher_name),
  CASE COUNT(*) WHEN 1 THEN NULL
                WHEN 2 THEN MAX(teacher_name)
                ELSE        '--More--' END
FROM Register
GROUP BY course_nbr, student_name
