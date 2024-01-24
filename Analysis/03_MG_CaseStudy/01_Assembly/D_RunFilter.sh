#!/bin/bash

#$ -M
#$ -m abe
#$ -q debug
#$ -N RunFilter

echo "Running assembly length filter"

      #combined
      reformat.sh \
      in=./combined/combined.nr.fasta \
      out=./combined/combined_1000_filtered.fasta \
      minlength=1000

echo "DONE running assembly length filter!"

