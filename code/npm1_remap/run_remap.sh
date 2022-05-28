#!/bin/bash

code=/nfs/users/nfs_m/mg31/data/inhouse/pedro/20210426_ukbb_pileup_npm1/code/npm1_remap/batch_remap.sh

for i in {0..200000..500}; do
 j=$(($i+500))
 cmd="fsub -r1 -m1000 '"$code' '$i' '$j"'"
 echo $cmd
done
