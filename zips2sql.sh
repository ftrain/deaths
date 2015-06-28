#!/bin/bash

for x in `ls data/ss* && ls data/ma*`;
do unzip -p $x;
done | ./txt2sql.pl


# done | perl -pe 'sub checkit {my $x = int($_); if ($x) {return $x} else {return "NULL"}} sub fixit {return join(",",map checkit, @_)} s/,//g; s/(.{1})(.{9})(.{20})(.{4})(.{15})(.{15})(.{1})(.{2})(.{2})(.{4})(.{2})(.{2})(.{4})(.{2})(.{2})(.+)/$1.",".$2.",".$3.",".$4.",".$5.",".$6.",".$7.",".fixit($8,$9,$10,$11,$12,$13)/egx; s/ *, */,/g;'|pv -s 9g

