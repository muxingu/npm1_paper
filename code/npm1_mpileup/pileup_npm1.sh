#!/bin/bash
#this code runs samtools mpileup around NPM1 W288 site on multiples samples in a batch
#and write output to a single file

d=/nfs/users/nfs_m/mg31/data/inhouse/pedro/20210426_ukbb_pileup_npm1

loc=chr5:171410530-171410560  #region around NPM1 W288
batchf=$d/batch/$1  #input batch file

batch=$(basename $batchf | cut -f1 -d'.')
odir=$d/pileup
mkdir -p $odir

outf=$odir/$batch'.txt'
while read -r line; do
 samp=$(basename $line | cut -f1 -d'.')
 samtools mpileup -f /nfs/users/nfs_m/mg31/shared/reference/fa/hg38.fa -r $loc $line | \
   awk -v a=$samp '{print a"\t"$0}' >> $outf
done < $batchf


