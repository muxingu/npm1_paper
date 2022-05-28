#!/software/team163/mg31/Anaconda/bin/python
#this code reads the samtools mpileup output and extract mutation sites


import sys, os

gene="NPM1"

d="/nfs/users/nfs_m/mg31/data/inhouse/pedro/20210426_ukbb_pileup_npm1"
od=d+"/summary"  #output directory
indir=d+"/pileup"  #input directory
os.makedirs(od,exist_ok=True)
set={'A','T','C','G','a','t','c','g'}

def process(ss,samp):
 pos=ss[1]
 loc=ss[2]
 cov=int(ss[4])
 seq=ss[5]
 dd={}
 i=0
 while i<len(seq):
  c=seq[i]
  if c == '+' or c == '-':
   nn=0
   while True:
    nstr=seq[i+1+nn]
    if nstr.isdigit():
     nn=nn+1
    else:
     break
   try:
    n=int(seq[i+1:i+1+nn])
   except:
    i=i+1
    continue
   ins=seq[i+1+nn:i+1+nn+n]
   insu=c+ins.upper()
   if insu not in dd:
    dd[insu]=0
   dd[insu] = dd[insu]+1
   i=i+nn+n
  else:
   if c in set:
    cu=c.upper()
    if cu not in dd:
     dd[cu]=0
    dd[cu] = dd[cu]+1
  i=i+1
 for k in dd:
  vaf=dd[k]/cov
  fw.write(samp+"\t"+loc+"\t"+ss[3]+"\t"+k+"\t"+str(cov)+"\t"+str(dd[k])+"\t"+str(vaf)+"\n")

outf=od+"/summary.txt"
fw=open(outf,'w')
fs=os.listdir(indir)
for f in fs:
 fr=open(indir+"/"+f,'r')
 print(f)
 for l in fr:
  l=l.rstrip()
  ss=l.split("\t")
  process(ss,ss[0])
 fr.close()
fw.close()


