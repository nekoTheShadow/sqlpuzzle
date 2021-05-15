DROP TABLE IF EXISTS CandidateSkills;
DROP TABLE IF EXISTS JobOrders;

CREATE TABLE CandidateSkills
(candidate_id INTEGER NOT NULL,
 skill_code CHAR(15) NOT NULL,
    PRIMARY KEY (candidate_id, skill_code));

CREATE TABLE JobOrders
(job_id INTEGER NOT NULL,
 skill_group INTEGER NOT NULL,
 skill_code CHAR(15) NOT NULL,
    PRIMARY KEY (job_id, skill_group, skill_code));

INSERT INTO CandidateSkills VALUES(100, '会計');
INSERT INTO CandidateSkills VALUES(100, '在庫管理');
INSERT INTO CandidateSkills VALUES(100, '製造'); 
INSERT INTO CandidateSkills VALUES(200, '会計');
INSERT INTO CandidateSkills VALUES(200, '在庫管理');
INSERT INTO CandidateSkills VALUES(300, '製造');
INSERT INTO CandidateSkills VALUES(400, '在庫管理');
INSERT INTO CandidateSkills VALUES(400, '製造'); 
INSERT INTO CandidateSkills VALUES(500, '会計'); 
INSERT INTO CandidateSkills VALUES(500, '製造');

-- 1. (在庫管理 and 製造) or 会計
-- 2. (在庫管理 and 製造) or (会計 and 製造)
-- 3. 製造
-- 4. 在庫管理 and 製造 and 会計
INSERT INTO JobOrders VALUES(1, 1, '在庫管理');
INSERT INTO JobOrders VALUES(1, 1, '製造'); 
INSERT INTO JobOrders VALUES(1, 2, '会計');
INSERT INTO JobOrders VALUES(2, 1, '在庫管理');
INSERT INTO JobOrders VALUES(2, 1, '製造'); 
INSERT INTO JobOrders VALUES(2, 2, '会計'); 
INSERT INTO JobOrders VALUES(2, 2, '製造'); 
INSERT INTO JobOrders VALUES(3, 1, '製造');
INSERT INTO JobOrders VALUES(4, 1, '在庫管理');
INSERT INTO JobOrders VALUES(4, 1, '製造'); 
INSERT INTO JobOrders VALUES(4, 1, '会計'); 

SELECT DISTINCT J1.job_id, C.candidate_id
FROM CandidateSkills C
JOIN JobOrders J1 ON C.skill_code = J1.skill_code
GROUP BY C.candidate_id, J1.job_id, J1.skill_group
HAVING COUNT(*) = (
  SELECT COUNT(*)
  FROM JobOrders J2
  WHERE (J1.job_id, J1.skill_group) = (J2.job_id, J2.skill_group)
)
ORDER BY job_id, candidate_id;
