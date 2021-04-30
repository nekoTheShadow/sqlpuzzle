DROP TABLE IF EXISTS Foobar;

CREATE TABLE Foobar(
  all_alpha VARCHAR(6) NOT NULL
    CHECK (all_alpha SIMILAR TO '[a-zA-Z]*'),
  some_alpha VARCHAR(6) NOT NULL
    CHECK (NOT some_alpha SIMILAR TO '[^a-zA-Z]+'),
  no_alpha VARCHAR(6) NOT NULL
    CHECK (no_alpha SIMILAR TO '[^a-zA-Z]*')
);

-- all_alpha
INSERT INTO Foobar VALUES ('Aa', '', ''); -- OK
-- INSERT INTO Foobar VALUES ('A1', '', ''); -- NG
-- INSERT INTO Foobar VALUES ('11', '', ''); -- NG

-- some_alpha
INSERT INTO Foobar VALUES ('', 'Aa', ''); -- OK
INSERT INTO Foobar VALUES ('', 'A1', ''); -- OK
-- INSERT INTO Foobar VALUES ('', '11', ''); -- NG

-- no_alpha
-- INSERT INTO Foobar VALUES ('', '', 'Aa'); -- NG
-- INSERT INTO Foobar VALUES ('', '', 'A1'); -- NG
INSERT INTO Foobar VALUES ('', '', '11'); -- OK
