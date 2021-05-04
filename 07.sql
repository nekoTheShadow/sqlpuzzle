-- 本書では入れ子集合モデルを採用しているが、
-- 再帰SQLが一般的になった現在ではポインタチェインを採用しても問題ない。

-- supersedes_file_id (後続バージョンのファイルID) は 削除
-- 先行バージョンなしの場合はsuperseded_file_id=NULLとする。
DROP TABLE IF EXISTS Portfolios;
CREATE TABLE Portfolios(
  file_id INTEGER NOT NULL PRIMARY KEY,
  issue_date DATE NOT NULL,
  superseded_file_id INTEGER REFERENCES Portfolios(file_id)
);

INSERT INTO Portfolios VALUES (1, '2021-01-01', NULL);
INSERT INTO Portfolios VALUES (2, '2021-01-02', 1);
INSERT INTO Portfolios VALUES (3, '2021-01-03', 2);
INSERT INTO Portfolios VALUES (4, '2021-01-04', 3);
INSERT INTO Portfolios VALUES (5, '2021-01-05', 4);

-- あるバージョンの後続バージョンを追跡できること
-- SELECT文にどんなバージョンが含まれていようと、最新バージョンは選択できること
WITH RECURSIVE R AS (
    SELECT file_id, issue_date FROM Portfolios WHERE file_id = 3
  UNION ALL
    SELECT P.file_id, P.issue_date
    FROM R 
    JOIN Portfolios P ON R.file_id = P.superseded_file_id
)
SELECT * FROM R;

-- あるバージョンの先行バージョンを追跡できること
-- 過去のバージョンを復活できること
-- バージョンの連鎖を調べる監査証跡を再作成できること。
WITH RECURSIVE R AS (
    SELECT 3 AS file_id
  UNION ALL
    SELECT P.superseded_file_id
    FROM R 
    JOIN Portfolios P ON R.file_id = P.file_id
    WHERE P.superseded_file_id IS NOT NULL
)
SELECT R.file_id, P.issue_date 
FROM R 
JOIN Portfolios P ON R.file_id = P.file_id;

-- issue_date率によってあるファイルバージョンの発行日を突き止められること
SELECT issue_date FROM Portfolios WHERE file_id = 3;
