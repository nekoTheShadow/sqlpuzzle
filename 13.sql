DROP TABLE IF EXISTS Register;

CREATE TABLE Register
(course_nbr INTEGER NOT NULL,
 student_name CHAR(10) NOT NULL,
 teacher_name CHAR(10) NOT NULL);

INSERT INTO Register VALUES(10, '生徒１', '先生１');

INSERT INTO Register VALUES(20, '生徒１', '先生１');
INSERT INTO Register VALUES(20, '生徒１', '先生２');

INSERT INTO Register VALUES(30, '生徒１', '先生１');
INSERT INTO Register VALUES(30, '生徒１', '先生２');
INSERT INTO Register VALUES(30, '生徒１', '先生３');

SELECT 
  course_nbr,
  student_name,
  MIN(teacher_name),
  CASE COUNT(*) WHEN 1 THEN NULL
                WHEN 2 THEN MAX(teacher_name)
                ELSE        '--More--' END
FROM Register
GROUP BY course_nbr, student_name
