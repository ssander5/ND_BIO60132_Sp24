for f in ../clean_reads/*_1.fastq; do
    cat $f >> reads1.fastq
    cat ${f%1.fastq}2.fastq >> reads2.fastq
done

bash mw_reassemble_bins.sh -b ../02_Bin_and_Refine/bin_refinement/binrefiner_output/all.BR_Binning_refiner_outputs/all.BR_refined_bins/ -o reassembly -1 reads1.fastq -2 reads2.fastq -t 4 -m 100 -c 50 -x 50 
