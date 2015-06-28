#!/usr/bin/env gawk -f
#1,9,20,4,15,15,1,2,2,4,2,2,4,2,2,100
# for x in `ls data/ss* && ls data/ma*`; do echo $x; unzip -p $x; done|./fw2csv.awk 1,9,20,4,15,15,1,2,2,4,2,2,4,2,2,100|bzip2 -c > all_records.bz2
BEGIN {
    FIELDWIDTHS=ARGV[1];
    # FIELDWIDTHS=gensub(",", " ", "g", ARGV[1]);    
    delete ARGV[1];
    OFS=",";
}
{ for (i = 0; i < NF; i++) gsub("[[:space:]]*$", "", $i); print; }
