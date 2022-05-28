#!/bin/bash

d=/nfs/users/nfs_m/mg31/data/inhouse/pedro/20210426_ukbb_pileup_npm1
cd $d

f=$1
batch=$2

samtools view $f | java -Xmx1g -cp RNAmut_test.jar snippet.test.RunFLT3 $f $batch

rdir=$d/rnamut/$batch/$(basename $f | cut -f1 -d'.')/pool
rm -rf $rdir
