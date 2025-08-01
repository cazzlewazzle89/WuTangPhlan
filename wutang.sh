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

# print pipeline options
echo "Input: ${MANIFEST}"
echo "Output: ${OUTDIR}"
echo "Quality Control: ${RUN_QC}"
echo "Host Removal: ${RUN_HOST}"

# confirm that specified qc tool is valid (if applicable)
if [ "$RUN_QC" == "TRUE" ]
then

  if [ "$QUALITY_TOOL" == "fastp" ] || [ "$QUALITY_TOOL" == "trimgalore" ]
  then

    :

  else

    echo "qc tool not recognised: ${QUALITY_TOOL}"
    exit 1

  fi

fi

# confirm that specified host removal tool is valid (if applicable)
if [ "$RUN_HOST" == "TRUE" ]
then

  if [ "$HOST_TOOL" == "bowtie2" ] || [ "$HOST_TOOL" == "hostile" ]
  then

    :

  else

    echo "Host removal tool not recognised: ${HOST_TOOL}"
    exit 1

  fi

fi

# print configuration for specified steps
echo "Quality control: ${QUALITY_TOOL}"
echo "Host removal: ${HOST_TOOL}"
echo "Host database: ${HOST_DATABASE}"

# make output directory
mkdir "$OUTDIR"

# run qc
if [[ "$RUN_QC" == "FALSE" ]]
then
  
  echo "Skipping qc as specified"
  
  else 
  
  bash "$SCRIPT_DIR"/SCRIPTS/qc.sh

fi

# run host removal
if [[ "$RUN_HOST" == "FALSE" ]]
then
  
  echo "Skipping host removal as specified"
  
  else
  
  bash "$SCRIPT_DIR"/SCRIPTS/host_removal.sh

fi

