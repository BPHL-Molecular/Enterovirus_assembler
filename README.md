# Enterovirus_assembler
A Nextflow pipeline for de novo assembly of Enteroviurs using fastq data

## Prerequisites
Nextflow should be installed. The detail of installation can be found in https://github.com/nextflow-io/nextflow.

Python3, trimmomatic/0.32 (https://github.com/usadellab/Trimmomatic), and spades/3.15.3 (https://github.com/ablab/spades/blob/spades_3.15.5/assembler/rnaspades_manual.html) are also needed.

## How to run
1. If there is no "fastqs" folder in the directory, create it in the same directory with the folder "modules". And then put all your data files in the directory /fastqs.
2. open file "parames.yaml", set the two parameters absolute paths. They should be ".../.../fastqs" and ".../.../output". 
3. get into the top of the pipeline directory, run "sbatch_enterovirus_assembly.sh"

## Results
All results can be found in the directory /output/your data names/rna_assembly/. In .../rna_assembly/, the file "transcripts.fasta" is the main assembly output. In addition,there are another two assembly outputs. "hard_filtered_transcripts.fasta" includes only long and reliable transcripts with rather high expression. "soft_filtered_transcripts.fasta" includes short and low-expressed transcipts, likely to contain junk sequences. We reccomend to use main transcripts.fasta file in case you don't have any specific needs for you projects.

## Note
In the pipeline, trimmomatic is used for sequencing data's quality control. rnaSPAdes in Spades is used as assembler.
