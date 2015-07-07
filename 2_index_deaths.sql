BEGIN TRANSACTION;
.print 'Reading file'
.echo off
-- .read deaths.sql
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
