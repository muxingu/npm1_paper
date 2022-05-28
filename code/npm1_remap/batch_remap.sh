#!/bin/bash

d=/nfs/users/nfs_m/mg31/data/inhouse/pedro/20210426_ukbb_pileup_npm1
batf=$d/batch_files.txt
code=$d/code/npm1_remap/remap.sh

low=$1
high=$2
od=$d/npm1
mkdir $od
outf=$od/$low'.txt'

cat $batf | awk "NR>=$low && NR<$high" | 
while read line; do
 $code $line >> $outf
done
gzip $outf
