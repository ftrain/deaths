.mode column
.nullvalue NULL
.echo on

DROP TABLE IF EXISTS deaths;
DROP TABLE IF EXISTS deaths_vt;
DROP INDEX IF EXISTS first_idx;
DROP INDEX IF EXISTS last_idx;
DROP INDEX IF EXISTS full_idx;

CREATE TABLE IF NOT EXISTS deaths (
-- ID
       id INTEGER PRIMARY KEY,
-- Internal to fwfile
       acd VARCHAR(1) DEFAULT NULL,
-- Social Security Number
       ssn INTEGER(9) DEFAULT NULL,
-- Name
       last VARCHAR(20),
       suffix VARCHAR(4) DEFAULT NULL,
       first VARCHAR(15),
       middle VARCHAR(15) DEFAULT NULL,
-- Verification
       vp VARCHAR(1) DEFAULT NULL,
-- Death: Values can be empty
       dmonth INTEGER(2) DEFAULT NULL,
       dday INTEGER(2) DEFAULT NULL,
       dyear INTEGER(4) DEFAULT NULL,
-- Birth: Values can be empty
       bmonth INTEGER(2) DEFAULT NULL,
       bday INTEGER(2) DEFAULT NULL,
       byear INTEGER(4) DEFAULT NULL
);

