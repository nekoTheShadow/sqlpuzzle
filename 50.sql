CREATE TABLE AnthologyContributors
(isbn CHAR(10) NOT NULL,
 contributor CHAR(20) NOT NULL,
 category INTEGER NOT NULL,
    PRIMARY KEY (isbn, contributor));

INSERT INTO AnthologyContributors VALUES(1, 'スミス', 1);
INSERT INTO AnthologyContributors VALUES(2, 'スミス', 2);
INSERT INTO AnthologyContributors VALUES(3, 'スミス', 3);
INSERT INTO AnthologyContributors VALUES(4, 'ジョン', 1);
INSERT INTO AnthologyContributors VALUES(5, 'ジョン', 2);
INSERT INTO AnthologyContributors VALUES(6, 'メアリ', 1);
INSERT INTO AnthologyContributors VALUES(7, 'メアリ', 1);
INSERT INTO AnthologyContributors VALUES(8, 'ガトー', 2);
INSERT INTO AnthologyContributors VALUES(9, 'ガトー', 3);
INSERT INTO AnthologyContributors VALUES(10,'シモン', 1);

SELECT contributor
FROM AnthologyContributors
GROUP BY contributor
HAVING COUNT(DISTINCT category) = 2;