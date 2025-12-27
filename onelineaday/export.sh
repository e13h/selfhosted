#!/bin/bash

ONELINEADAY_PORT=3800
OUTPUT_FILENAME="onelineaday_export_$(date -Is).json"
wget http://localhost:${ONELINEADAY_PORT}/api/export -O $OUTPUT_FILENAME
echo $OUTPUT_FILENAME
