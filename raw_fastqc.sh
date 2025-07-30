#!/bin/bash

# Set input and output directories
INPUT_DIR="./fastq_files"        # Change this to your actual input path
OUTPUT_DIR="./fastqc_results"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Run FastQC on all .fastq.gz files in the input directory
for file in "$INPUT_DIR"/*.fastq.gz; do
    echo "Running FastQC on: $file"
    fastqc "$file" --outdir="$OUTPUT_DIR"
done

echo "FastQC analysis complete. Results saved in $OUTPUT_DIR"
