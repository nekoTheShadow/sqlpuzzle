CREATE TABLE SortMeFast
(unsorted_string CHAR(7) NOT NULL PRIMARY KEY);

INSERT INTO SortMeFast VALUES('CABBDBC');

SELECT 
     REPEAT('A', CHAR_LENGTH(unsorted_string) - CHAR_LENGTH(REPLACE(unsorted_string, 'A', '')))
  || REPEAT('B', CHAR_LENGTH(unsorted_string) - CHAR_LENGTH(REPLACE(unsorted_string, 'B', '')))
  || REPEAT('C', CHAR_LENGTH(unsorted_string) - CHAR_LENGTH(REPLACE(unsorted_string, 'C', '')))
  || REPEAT('D', CHAR_LENGTH(unsorted_string) - CHAR_LENGTH(REPLACE(unsorted_string, 'D', '')))  
FROM SortMeFast

