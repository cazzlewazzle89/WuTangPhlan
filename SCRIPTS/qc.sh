#!/bin/bash

source ./method.man

# limit threads to 16 if running fastp
if [[ "$QUALITY_TOOL" == "fastp" ]]; then
    if [[ "$QC_THREADS" -gt 16 ]]; then
        FASTP_THREADS=16
    else
        FASTP_THREADS="$QC_THREADS"
    fi
fi

# source conda
source "$CONDA_SH_PATH"

# activate conda environment
conda activate "$CONDA_ENV_QC"

# make output directory
mkdir -p "$OUTDIR"/FASTQ

# run qc
while read -r i j k; do
    if [[ "$QUALITY_TOOL" == "trimgalore" ]]; then
        trim_galore \
            --fastqc \
            --length 50 \
            -o "$OUTDIR"/FASTQ/ \
            --basename "$i" \
            --cores "$QC_THREADS" \
            --paired \
            "$j" "$k"

        mv "$OUTDIR"/FASTQ/"$i"_val_1.fq.gz "$OUTDIR"/FASTQ/"$i"_trimmed_R1.fastq.gz
        mv "$OUTDIR"/FASTQ/"$i"_val_2.fq.gz "$OUTDIR"/FASTQ/"$i"_trimmed_R2.fastq.gz
    else
        fastp \
            --in1 "$j" \
            --in2 "$k" \
            --out1 "$OUTDIR"/FASTQ/"$i"_trimmed_R1.fastq.gz \
            --out2 "$OUTDIR"/FASTQ/"$i"_trimmed_R2.fastq.gz \
            --detect_adapter_for_pe \
            --length_required 50 \
            --thread "$FASTP_THREADS" \
            --html "$OUTDIR"/FASTQ/"$i"_fastp.html \
            --json "$OUTDIR"/FASTQ/"$i"_fastp.json
    fi 
done < "$MANIFEST"
