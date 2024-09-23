# Paths and variables
fastq_DIR="/mnt/TooBigData/rnaseq_new"  # Directory containing trimmed FASTQ files
OUTPUT_DIR="/mnt/TooBigData/rnaseq_new/outputfastq"   # Directory where FastQC output will be saved

# Make sure the output directory exists
mkdir -p $OUTPUT_DIR

# Iterate over trimmed FASTQ files
for file in $fastq_DIR/*.trimmed.fastq.gz; do
    # Run FastQC
    fastqc -o $OUTPUT_DIR $file

    echo "FastQC analysis completed for $file"
done

echo "FastQC analysis completed for all files."
