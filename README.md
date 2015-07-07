# Social Security Deaths Database

- The data is gathered from http://cancelthesefunerals.com/
- `app` is a dir with a tiny stub flask app for hosting dead people

# Converting the deaths to sqlite3

1. Expect the current directory to grow to ~22GB.
1. Put all the zipped death files into the `data` dir.
   1. `sqlite3 deaths.db < 1_setup_deaths_db.sql`
1. Convert the data (takes a while)
   1. `./zips2sql.sh > deaths.sql`
   1. OR, if you like PV; `./zips2sql.sh |pv -s 9g > deaths.sql`
1. Actually import the deaths
   1. `sqlite3 deaths.db < deaths.sql`
1. Run all the indexes/virtual table stuff
   1. `sqlite3 < 2_index_deaths.sql`


   
   
   
