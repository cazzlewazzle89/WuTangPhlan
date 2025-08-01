#!/bin/bash

source ./method.man
source utility.sh

# confirm existence
check_bowtie2_index "$HOST_DATABASE" || exit 1

# source conda
source "$CONDA_SH_PATH"

# activate conda environment
conda activate "$CONDA_ENV_HOST"

# run qc
while read -r i j k 
do

    if [ "$HOST_TOOL" == "bowtie2" ]
    then
        
        bowtie2 \
            --threads "$HOST_THREADS" \
            --seed 42 \
            -x "$HOST_DATABASE" \
            -1 "$OUTDIR"/FASTQ/"$i"_trimmed_R1.fastq.gz \
            -2 "$OUTDIR"/FASTQ/"$i"_trimmed_R2.fastq.gz | samtools view -b > "$OUTDIR"/FASTQ/"$i".bam 

        samtools view -f 12 -F 256 "$OUTDIR"/FASTQ/"$i".bam > "$OUTDIR"/FASTQ/"$i"_microbial.bam        

        samtools fastq \
            -1 "$OUTDIR"/FASTQ/"$i"_R1.fastq.gz \
            -2 "$OUTDIR"/FASTQ/"$i"_R2.fastq.gz \
            -0 /dev/null \
            -s /dev/null \
            -n \
            "$OUTDIR"/FASTQ/"$i"_microbial.bam

        rm -f "$OUTDIR"/FASTQ/"$i".bam
        rm -f "$OUTDIR"/FASTQ/"$i"_trimmed_R1.fastq.gz 
        rm -f "$OUTDIR"/FASTQ/"$i"_trimmed_R2.fastq.gz 
        rm -f "$OUTDIR"/FASTQ/"$i"_microbial.bam

    else

        hostile clean \
            --fastq1 "$OUTDIR"/FASTQ/"$i"_trimmed_R1.fastq.gz \
            --fastq2 "$OUTDIR"/FASTQ/"$i"_trimmed_R2.fastq.gz \
            --aligner bowtie2 \
            --index "$HOST_DATABASE" \
            --output "$OUTDIR"/FASTQ/ \
            --threads "$HOST_THREADS"

        mv "$OUTDIR"/FASTQ/"$i"_trimmed_R1.clean_1.fastq.gz "$OUTDIR"/FASTQ/"$i"_R1.fastq.gz
        mv "$OUTDIR"/FASTQ/"$i"_trimmed_R2.clean_2.fastq.gz "$OUTDIR"/FASTQ/"$i"_R2.fastq.gz

        rm -f "$OUTDIR"/FASTQ/"$i"_trimmed_R1.fastq.gz
        rm -f "$OUTDIR"/FASTQ/"$i"_trimmed_R2.fastq.gz
            
    fi 

done < "$MANIFEST"