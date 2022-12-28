process assemble {
   input:
      val x
   output:
      //path 'xfile.txt', emit: aLook
      val "${params.output}/${x}", emit: outputpath1
      //path "${params.output}/${x}_trim_2.fastq", emit: trimR2
      
   """  
   #echo ${params.input}/${x}_1.fastq.gz >> xfile.txt
   
   mkdir -p ${params.output}/${x}
   mkdir -p ${params.output}/${x}/rna_assembly
   cp ${params.input}/${x}_*.fastq.gz ${params.output}/${x}
   ##### container is already downloaded to local machine
   #singularity exec --cleanenv /apps/staphb-toolkit/containers/fastqc_0.11.9.sif fastqc ${params.output}/${x}/${x}_1.fastq.gz ${params.output}/${x}/${x}_2.fastq.gz
   
   ###### pull container from docker hub, and if nextflow.config include process.container = 'docker://staphb/fastqc:0.11.9'
   #fastqc ${params.output}/${x}/${x}_1.fastq.gz ${params.output}/${x}/${x}_2.fastq.gz
   
   ##### pull container from docker hub, and if multiple containers in a process
   #singularity exec --cleanenv docker://staphb/fastqc:0.11.9 fastqc ${params.output}/${x}/${x}_1.fastq.gz ${params.output}/${x}/${x}_2.fastq.gz

   
   ###Step1: quality filte
   trimmomatic PE -phred33 ${params.output}/${x}/${x}_L001_R1_001.fastq.gz ${params.output}/${x}/${x}_L001_R2_001.fastq.gz ${params.output}/${x}/output_R1.fq.gz ${params.output}/${x}/output_R1_unpaired.fq.gz ${params.output}/${x}/output_R2.fq.gz ${params.output}/${x}/output_R2_unpaired.fq.gz ILLUMINACLIP:${HPC_TRIMMOMATIC_ADAPTER}/TruSeq3-PE.fa:2:30:10 TRAILING:20 SLIDINGWINDOW:4:30 MINLEN:75
   
   ###Step2: assembly
   rnaspades.py --only-assembler --cov-cutoff auto -1 ${params.output}/${x}/output_R1.fq.gz -2 ${params.output}/${x}/output_R2.fq.gz -o ${params.output}/${x}/rna_assembly



   """
}
