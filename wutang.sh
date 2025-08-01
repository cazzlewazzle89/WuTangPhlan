#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# check that config file exists and load
if [[ -f ./method.man ]]
then

  source ./method.man

else

  echo "Config file 'method.man' not found in current working directory!"
  exit 1

fi

# source conda
if [[ -f "$CONDA_SH_PATH" ]]
then

  source "$CONDA_SH_PATH"

else

  echo "ERROR: Cannot find conda.sh at ${CONDA_SH_PATH}"
  exit 1

fi

# confirm that manifest exists and all read files exist
if [ ! -f "$MANIFEST" ]
then

  echo "Manifest file not found: ${MANIFEST}"
  exit 1

  else

    inputerror="false"

    while read -r i j k
    do
    
      if [ ! -f "$j" ]
      then
		  
        echo "File not found: ${j}"
        inputerror="true"
      
      fi

      if [ ! -f "$k" ]
      then

        echo "File not found: ${k}"
        inputerror="true"
      
      fi

  done < "$MANIFEST"

  if [ "$inputerror" == "true" ]
  then

    echo "One or more input files are missing. Exiting."
    exit 1
  
  fi

fi

# confirm that specified qc tool is valid
if [ "$QUALITY_TOOL" == 'fastp' ] || [ "$QUALITY_TOOL" == 'trimgalore' ]
then

  :

else

  echo 'qc tool not recognised'
  exit 1

fi

# print configuration
echo "Input: ${MANIFEST}"
echo "Output: ${OUTDIR}"
echo "Quality control: ${QUALITY_TOOL}"
echo "Host removal: ${DECONTAM_TOOL}"

# make output directory
mkdir "$OUTDIR"

# run qc
bash "$SCRIPT_DIR"/SCRIPTS/qc.sh

