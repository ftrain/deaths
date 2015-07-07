#!/bin/bash

for x in `ls data/ss* && ls data/ma*`;
do unzip -p $x;
done | ./txt2sql.pl

