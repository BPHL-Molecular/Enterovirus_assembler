#!/usr/bin/bash
#SBATCH --account=bphl-umbrella
#SBATCH --qos=bphl-umbrella
#SBATCH --job-name=nextseq_fastq_nextflow
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20                    #This parameter shoulbe be equal to the number of samples if you want fastest running speed. However, the setting number should be less than the max cpu limit(150). 
#SBATCH --mem=20gb
#SBATCH --time=48:00:00
#SBATCH --output=flaq_enterovirus.%j.out
#SBATCH --error=flaq_enterovirus.%j.err

module load trimmomatic/0.32
module load spades/3.15.3

nextflow run enterovirus_assembly.nf -params-file params.yaml
