#!/bin/bash

# check that config file exists and load
if [[ -f method.man ]]
then

  source method.man

else

  echo "Config file 'method.man' not found!"
  exit 1

fi

# source conda
if [[ -f "${CONDA_SH_PATH}" ]]
then

    source "${CONDA_SH_PATH}"

else

    echo "ERROR: Cannot find conda.sh at ${CONDA_SH_PATH}"
    exit 1

fi

# print configuration
echo "Input: ${MANIFEST_FILE}"
echo "Output: ${OUTPUT_DIR}"
echo "Quality control: ${QUALITY_TOOL}"
echo "Host removal: ${DECONTAM_TOOL}"



