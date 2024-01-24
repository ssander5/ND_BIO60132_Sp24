#!/bin/bash

#$ -M
#$ -m abe
#$ -q debug
#$ -N RunQC_H

#make output folder

if [ -d ../../final_QC_output ]; then
    echo "directory exists"
else
    mkdir ../../final_QC_output
fi

echo "Copying clean files to the folder"
cp ./bbmap/*final.clean.fq ../../final_QC_output/

for f in ./bbmap/*stats.txt; do
  cp $f ../../final_QC_output/
done

echo "DONE copying clean files to the folder!"
