DROP TABLE IF EXISTS DataFlowDiagrams;

CREATE TABLE DataFlowDiagrams
(diagram_name CHAR(10) NOT NULL,
 bubble_name CHAR(10) NOT NULL,
 flow_name CHAR(10) NOT NULL,
    PRIMARY KEY (diagram_name, bubble_name, flow_name));

INSERT INTO DataFlowDiagrams VALUES('Proc1',  'input' ,   'guesses');
INSERT INTO DataFlowDiagrams VALUES('Proc1',  'input' ,   'opinions'); 
INSERT INTO DataFlowDiagrams VALUES('Proc1',  'crunch',   'facts');
INSERT INTO DataFlowDiagrams VALUES('Proc1',  'crunch',   'guesses');
INSERT INTO DataFlowDiagrams VALUES('Proc1',  'crunch',   'opinions' );
INSERT INTO DataFlowDiagrams VALUES('Proc1',  'output',   'facts');
INSERT INTO DataFlowDiagrams VALUES('Proc1',  'output',   'guesses');
INSERT INTO DataFlowDiagrams VALUES('Proc2',  'reckon',   'guesses');
INSERT INTO DataFlowDiagrams VALUES('Proc2',  'reckon',   'opinions' );

-- EXCEPT‚ðŽg‚¤‚â‚è•û
  (SELECT a.diagram_name, a.bubble_name, b.flow_name
   FROM DataFlowDiagrams a
   CROSS JOIN DataFlowDiagrams b)
EXCEPT
  (SELECT diagram_name, bubble_name, flow_name 
   FROM DataFlowDiagrams);

-- NOT EXISTS‚ðŽg‚¤‚â‚è•û
SELECT DISTINCT a.diagram_name, a.bubble_name, b.flow_name
FROM DataFlowDiagrams a
CROSS JOIN DataFlowDiagrams b
WHERE NOT EXISTS (
  SELECT *
  FROM DataFlowDiagrams c
  WHERE a.diagram_name = c.diagram_name
  AND a.bubble_name = c.bubble_name
  AND b.flow_name = c.flow_name
)
