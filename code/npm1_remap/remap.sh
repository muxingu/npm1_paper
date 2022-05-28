#!/bin/bash

#this code extract reads that are mapped to NPM1 and remap
#them to the NPM mutant sequences

d=/nfs/users/nfs_m/mg31/data/inhouse/pedro/20210426_ukbb_pileup_npm1

f=$1   #input cram file
batch=$2  #batch number

tag=$(basename $f | cut -f1 -d'.')  #name tag for file
od=$d/npm1/$batch  #output directory
mkdir -p $od
index=$d/index_npm1/NPM1.fa  #bwa index for NPM mutant sequences

obam=$od/$tag.bam  #temporary BAM file for reads mapped to NPM1 gene
fq=$od/$tag'.fq.gz'  #temporary FASTQ file for reads mapped to NPM1 gene
remap=$od/$tag.sam  #output SAM file for remap

source activate test_py3 #Anaconda environment containing samtools, bamtofastq and bwa
samtools view -b $f chr5:171381174-171416825 > $obam
samtools index $obam
bamtofastq F=$fq F2=$fq O=$fq O2=$fq S=$fq gz=1 filename=$obam inputformat=bam
bwa mem -L 100 -B 8 $index $fq | samtools view -h -F 260 | samtools sort --output-fmt sam - | samtools view \
 | awk -v var="$tag" '{print var"\t"$0}'

rm $obam $obam.bai $fq


