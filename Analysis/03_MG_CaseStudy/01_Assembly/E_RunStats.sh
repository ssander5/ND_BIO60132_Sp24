#!/bin/bash

#$ -M
#$ -m abe
#$ -q debug
#$ -N 3C_RunStats


echo "Running Stats on Assemblies"

      metaquast.py \
      --threads 14 \
      --gene-finding \
      -o ../../../../Vis*/01_Assembly*/scaffolds_1000_filtered \
      -l ../../../../Vis*/01_Assembly*/scaffolds_1000_filtered \
      ./spades/scaffolds_final_filtered.fasta

      metaquast.py \
      --threads 14 \
      --gene-finding \
      -o ../../../../Vis*/01_Assembly*/megahit_1000_final_filtered \
      -l ../../../../Vis*/01_Assembly*/megahit_1000_final_filtered \
      ./megahit/megahit_final_1000_filtered.fasta

      metaquast.py \
      --threads 14 \
      --gene-finding \
      -o ../../../../Vis*/01_Assembly*/combined_1000_filtered \
      -l ../../../../Vis*/01_Assembly*/combined_1000_filtered \
      combined/combined_1000_filtered.fasta


echo "DONE running stats!"
