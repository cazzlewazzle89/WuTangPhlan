#!/bin/bash

source ./method.man
source "$CONDA_SH_PATH"

# limit threads to 16 if running fastp
if [[ "$QUALITY_TOOL" == "fastp" ]]
then

    if [[ "$THREADS" -gt 16 ]]
    then

        FASTP_THREADS=16

    else

        FASTP_THREADS="$THREADS"

    fi

fi

# activate conda environment
conda activate "$CONDA_ENV_QC"

# make output directory
mkdir -p "$OUTDIR"/FASTQ

# run qc
while read -r i j k 
do

    if [ "$QUALITY_TOOL" == "fastp" ]
    then
        
        fastp \
            --in1 "$j" \
            --in2 "$k" \
            --out1 "$OUTDIR"/FASTQ/"$i"_R1_trimmed.fq.gz \
            --out2 "$OUTDIR"/FASTQ/"$i"_R2_trimmed.fq.gz \
            --detect_adapter_for_pe \
            --length_required 50 \
            --thread "$FASTP_THREADS" \
            --html "$OUTDIR"/FASTQ/"$i"_fastp.html \
            --json "$OUTDIR"/FASTQ/"$i"_fastp.json

    else

        trim_galore \
            --fastqc \
            --length 50 \
            -o "$OUTDIR"/FASTQ/ \
            --basename "$i" \
            --cores 1 \
            --paired \
            "$j" "$k"
            
    fi 

done < "$MANIFEST"

