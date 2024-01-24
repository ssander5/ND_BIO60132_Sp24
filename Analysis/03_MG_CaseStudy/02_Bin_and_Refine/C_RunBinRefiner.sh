#!/bin/bash

#$ -M sheri.anne.sanders@gmail.com
#$ -m abe
#$ -q debug
#$ -N C4_Bin_Refining

#make output folder

if [ -d bin_refinement ]; then
    echo "directory exists"
else
    mkdir bin_refinement
fi

#if [ -d checkM ]; then
#    echo "directory exists"
#else
#    mkdir checkM
#fi

export CHECKM_DATA_PATH=../../Reference/

mkdir ./bin_refinement/binrefiner_output
mkdir ./bin_refinement/input

#mv bin_refinement/concoct_bins bin_refinement/input/concoct_bins
#mv bin_refinement/maxbin2_bins bin_refinement/input/maxbin2_bins
#mv bin_refinement/metabat2_bins bin_refinement/input/metabat2_bins

       #Binning_refiner
       Binning_refiner \
       -i ./bin_refinement/input \
       -p all.BR \
       -plot \
       -m 10

        mv *BR* ./bin_refinement/binrefiner_output


#       export PATH=$PATH:../../Software/hmmer-3.3.2/bin/

       #running checkM for maxbin
       for f in bin_refinement/zone.A/binrefiner_output/*_refiner_outputs/*refined_bins/*fasta; do
       echo checkm lineage_wf \
       -t 8 \
       -x fasta $f \
       ./checkM/${zone}/

       echo checkm taxonomy_wf \
       domain \
       Bacteria \
       ./checkM/${zone} \
       -x fasta $f
     done

echo "DONE running Binrefiner!"
