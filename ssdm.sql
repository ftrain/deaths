.mode column
.nullvalue NULL
.echo on

DROP TABLE IF EXISTS deaths;
DROP TABLE IF EXISTS deaths_vt;
DROP INDEX IF EXISTS first_idx;
DROP INDEX IF EXISTS last_idx;
DROP INDEX IF EXISTS full_idx;

CREATE TABLE IF NOT EXISTS deaths (

-- Internal to fwfile
       acd VARCHAR(1) DEFAULT NULL,
-- Social Security Number
       ssn INTEGER(9) PRIMARY KEY,
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

BEGIN TRANSACTION;
.print 'Reading file'
.echo off
.read deaths.sql
.echo on
.print 'Creating indices'
CREATE INDEX day_idx ON deaths(bday, dday);
CREATE INDEX month_idx ON deaths(bmonth, dmonth);
CREATE INDEX year_idx ON deaths(byear, dyear);

CREATE INDEX first_idx ON deaths(first);
CREATE INDEX last_idx ON deaths(last);
CREATE INDEX full_idx ON deaths(first, last);
.print 'Creating virtual table'
CREATE VIRTUAL TABLE IF NOT EXISTS deaths_vt USING fts4 (ssn, last, first, full);

INSERT INTO deaths_vt SELECT ssn, last, first, printf('%s %s %s', first, middle, last) AS full FROM deaths;

.print 'Completing transaction'
END TRANSACTION;

.print 'Done'

