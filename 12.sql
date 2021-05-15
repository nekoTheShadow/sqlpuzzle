DROP TABLE IF EXISTS Claims;
DROP TABLE IF EXISTS Defendants;
DROP TABLE IF EXISTS LegalEvents;
DROP TABLE IF EXISTS ClaimStatusCodes;

CREATE TABLE Claims(
   claim_id INTEGER, 
   patient_name VARCHAR(64),
   PRIMARY KEY(claim_id));

CREATE TABLE Defendants(
   claim_id INTEGER, 
   defendant_name VARCHAR(64),
   PRIMARY KEY(claim_id, defendant_name));

CREATE TABLE LegalEvents(
   claim_id INTEGER, 
   defendant_name VARCHAR(64),
   claim_status CHAR(2),
   change_date DATE,
   PRIMARY KEY(claim_id, defendant_name, claim_status));

CREATE TABLE ClaimStatusCodes(
   claim_status CHAR(2) PRIMARY KEY,
   claim_status_desc VARCHAR(64),
   claim_seq INTEGER);

INSERT INTO Claims VALUES( 10, 'Smith');
INSERT INTO Claims VALUES( 20, 'Jones');
INSERT INTO Claims VALUES( 30, 'Brown');

INSERT INTO Defendants VALUES (10, 'Johnson');
INSERT INTO Defendants VALUES (10, 'Meyer');
INSERT INTO Defendants VALUES (10, 'Dow');
INSERT INTO Defendants VALUES (20, 'Baker');
INSERT INTO Defendants VALUES (20, 'Meyer');
INSERT INTO Defendants VALUES (30, 'Johnson');

INSERT INTO LegalEvents VALUES(10,  'Johnson',  'AP', '1994-01-01' );
INSERT INTO LegalEvents VALUES(10,  'Johnson',  'OR', '1994-02-01' );
INSERT INTO LegalEvents VALUES(10,  'Johnson',  'SF', '1994-03-01' );
INSERT INTO LegalEvents VALUES(10,  'Johnson',  'CL', '1994-04-01' );
INSERT INTO LegalEvents VALUES(10,  'Meyer'  ,  'AP', '1994-01-01' );
INSERT INTO LegalEvents VALUES(10,  'Meyer'  ,  'OR', '1994-02-01' );
INSERT INTO LegalEvents VALUES(10,  'Meyer'  ,  'SF', '1994-03-01' );
INSERT INTO LegalEvents VALUES(10,  'Dow'    ,  'AP', '1994-01-01' );
INSERT INTO LegalEvents VALUES(10,  'Dow'    ,  'OR', '1994-02-01' );
INSERT INTO LegalEvents VALUES(20,  'Meyer'  ,  'AP', '1994-01-01' );
INSERT INTO LegalEvents VALUES(20,  'Meyer'  ,  'OR', '1994-02-01' );
INSERT INTO LegalEvents VALUES(20,  'Baker'  ,  'AP', '1994-01-01' );
INSERT INTO LegalEvents VALUES(30,  'Johnson',  'AP', '1994-01-01' );

INSERT INTO ClaimStatusCodes VALUES('AP', 'Awaiting review panel' ,  1);
INSERT INTO ClaimStatusCodes VALUES('OR', 'Panel opinion rendered',  2);
INSERT INTO ClaimStatusCodes VALUES('SF', 'Suit filed'            ,  3);
INSERT INTO ClaimStatusCodes VALUES('CL', 'closed'                ,  4);


-- 1. 被告人ごとにもっともステータスが進んでいるものを求める
-- 2. 1.でもとめたステータスのうち、訴訟ごとにステータスが最も進んでいないものを求める
WITH 
S AS (
  SELECT
    LE.claim_id,
    LE.defendant_name,
    LAST_VALUE(LE.claim_status) OVER(
         PARTITION BY LE.claim_id, LE.defendant_name
         ORDER BY CSC.claim_seq
         ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS claim_status
  FROM LegalEvents LE
  JOIN ClaimStatusCodes CSC ON LE.claim_status = CSC.claim_status
),
T AS (
  SELECT
    S.claim_id,
    FIRST_VALUE(S.claim_status) OVER (
      PARTITION BY S.claim_id
      ORDER BY CSC.claim_seq
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS claim_status
  FROM S
  JOIN ClaimStatusCodes CSC ON S.claim_status = CSC.claim_status
)
SELECT 
  C.claim_id,
  C.patient_name,
  (SELECT MAX(claim_status) FROM T WHERE C.claim_id = T.claim_id)
FROM Claims C



