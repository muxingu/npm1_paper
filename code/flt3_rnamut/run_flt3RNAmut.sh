#!/bin/bash

d=/nfs/users/nfs_m/mg31/data/inhouse/pedro/20210317_ukbb_pileup
cd $d

for i in {1..20..1}; do
 bn=$i'0000'
 batch='batch/batch_'$bn'.txt'
 cmd='cat '$batch' | awk '\''{print $0" "'$bn'}'\'' | foreach ./code/flt3RNAmut.sh | foreach '\''fsub -r1 -m1000'\'' | fsubarr -n rnamut'$bn
 echo $cmd
 exit 0
done
