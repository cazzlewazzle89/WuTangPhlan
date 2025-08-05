#!/bin/bash

source ./method.man

# source conda and load env if required
if [[ -n "$CONDA_ENV_PROFILE" ]]; then
    source "$CONDA_SH_PATH"
    conda activate "$CONDA_ENV_PROFILE"
else
    echo "No Conda environment specified for microbiome (read-level) profiling. Assuming required tools are already in PATH."
fi

# run read profiling
while read -r i j k; do
    if [ "$PROFILE_TOOL" == "humann" ]; then

    elif [ "$PROFILE_TOOL" == "metaphlan" ]; then

    else 
        kraken
    fi
done < "$OUTDIR"/manifest_clean.tsv