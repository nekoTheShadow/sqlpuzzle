CREATE OR REPLACE FUNCTION Barcode_CheckSum(barcode IN CHAR) RETURNS INTEGER AS $$
  WITH RECURSIVE r (seq, sum) AS (
      SELECT 1, 0 WHERE barcode SIMILAR TO '[0-9]{12}'
    UNION ALL
      SELECT seq + 1, SUM + CAST(SUBSTR(barcode, seq, 1) AS INTEGER) * CASE WHEN MOD(seq, 2) = 1 THEN 1 ELSE -1 END
      FROM r
      WHERE seq <= 12
  )
  SELECT 
    CASE WHEN barcode SIMILAR TO '[0-9]{12}' THEN 
      (SELECT ABS(MOD(sum, 10)) FROM r WHERE seq = 13)
    ELSE
      -1
    END
$$ LANGUAGE SQL; 

SELECT 
  Barcode_CheckSum('283723281122'), 
  Barcode_CheckSum('2837232r1122'),
  Barcode_CheckSum('2837232811229');


