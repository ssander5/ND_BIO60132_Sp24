#!/bin/bash

#$ -M
#$ -m abe
#$ -q debug
#$ -N RunQC_G

echo "Creating stats"

for f in ./bbmap/*final.clean.fq; do

     base=${f%_1.final*}

     grep 'PHIX REMOVAL UNPAIRED' ${base}.stats.txt  | grep 'java' > ${base}.finalstats.txt
     grep 'PHIX REMOVAL UNPAIRED' ${base}.stats.txt  | grep 'Input' >> ${base}.finalstats.txt
     grep 'PHIX REMOVAL UNPAIRED' ${base}.stats.txt  | grep 'Result' >> ${base}.finalstats.txt
     echo "" >> ${base}.finalstats.txt
     grep 'HOST CONTAMINATION SEQUENCES' ${base}.stats.txt  | grep 'java' >> ${base}.finalstats.txt
     grep 'HOST CONTAMINATION SEQUENCES' ${base}.stats.txt  | grep 'mapped' >> ${base}.finalstats.txt
     grep 'HOST CONTAMINATION SEQUENCES' ${base}.stats.txt  | grep 'unambiguous' >> ${base}.finalstats.txt
     grep 'HOST CONTAMINATION SEQUENCES' ${base}.stats.txt  | grep 'low-Q discards' >> ${base}.finalstats.txt
     echo "" >> ${base}.finalstats.txt
     grep 'rRNA CONTAMINATION SEQUENCES' ${base}.stats.txt  | grep 'java' >> ${base}.finalstats.txt
     grep 'rRNA CONTAMINATION SEQUENCES' ${base}.stats.txt  | grep 'Input' >> ${base}.finalstats.txt
     grep 'rRNA CONTAMINATION SEQUENCES' ${base}.stats.txt  | grep 'Contaminants' >> ${base}.finalstats.txt
     grep 'rRNA CONTAMINATION SEQUENCES' ${base}.stats.txt  | grep 'Total Removed' >> ${base}.finalstats.txt
     grep 'rRNA CONTAMINATION SEQUENCES' ${base}.stats.txt  | grep 'Total Result' >> ${base}.finalstats.txt

done

echo "DONE creating stats!"
