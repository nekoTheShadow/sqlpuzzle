DROP TABLE IF EXISTS Badges;
DROP FUNCTION IF EXISTS count_active_badges_by_emp_id;

CREATE TABLE Badges (
 badge_nbr INT NOT NULL PRIMARY KEY,
 emp_id INT NOT NULL,
 issued_date DATE NOT NULL,
 badge_status CHAR(1) NOT NULL
    CHECK (badge_status IN ('A', 'I'))
);

CREATE FUNCTION count_active_badges_by_emp_id(emp_id INT, next_badge_status CHAR(1)) RETURNS BIGINT AS $$
  SELECT CASE WHEN next_badge_status = 'A' THEN COUNT(*) + 1 ELSE COUNT(*) END
  FROM Badges b
  WHERE b.emp_id = emp_id
  AND b.badge_status = 'A'
$$ LANGUAGE SQL; 

ALTER TABLE Badges 
ADD CONSTRAINT check_active_badges
CHECK (count_active_badges_by_emp_id(emp_id, badge_status) <= 1);

INSERT INTO Badges VALUES(100, 1, '2007-01-01', 'I');
INSERT INTO Badges VALUES(200, 1, '2007-02-01', 'I');  --社員1番の最新バッジ
INSERT INTO Badges VALUES(300, 2, '2007-03-01', 'I');  --社員2番の最新バッジ
INSERT INTO Badges VALUES(400, 3, '2007-03-01', 'I');  
INSERT INTO Badges VALUES(500, 3, '2007-04-01', 'I');  
INSERT INTO Badges VALUES(600, 3, '2007-05-01', 'A');  --社員3番の最新バッジ

-- NGクエリ
INSERT INTO Badges VALUES(700, 3, '2007-05-02', 'A'); 
UPDATE Badges SET badge_status = 'A' WHERE badge_nbr = 100;

