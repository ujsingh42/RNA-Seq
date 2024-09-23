# Define directories
INDEX_DIR="/mnt/TooBigData/ujjawal"
FASTQ_DIR="/home/manoj/Desktop/script/trimmed"
OUTPUT_DIR="/mnt/TooBigData/humandata/trimmed/samnew"

# Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Define the HISAT2 index base name (prefix)
INDEX_PREFIX="${INDEX_DIR}/Homo_sapiens_GRCh38_index"

# Number of CPU threads to use
THREADS=8

# Quality score encoding (choose --phred33 or --phred64)
PHRED="--phred33"

# RNA strandness (choose appropriate value: FR, RF, etc.)
STRANDNESS="--rna-strandness RF"

# Loop through all FASTQ files in the input directory
for FASTQ_FILE_1 in ${FASTQ_DIR}/*_R1.trimmed.fastq.gz
do
    # Extract the base name of the file (without path and suffix)
    BASE_NAME=$(basename ${FASTQ_FILE_1} _R1.trimmed.fastq.gz)
    
    # Define the paired FASTQ file
    FASTQ_FILE_2="${FASTQ_DIR}/${BASE_NAME}_R2.trimmed.fastq.gz"
    
    # Define the output SAM file name
    OUTPUT_FILE="${OUTPUT_DIR}/${BASE_NAME}.sam"
    
    # Define the summary file name
    SUMMARY_FILE="${OUTPUT_DIR}/${BASE_NAME}_summary.txt"
    
    # Run HISAT2 alignment with additional parameters
    hisat2 -x $INDEX_PREFIX -1 $FASTQ_FILE_1 -2 $FASTQ_FILE_2 -S $OUTPUT_FILE \
        -p $THREADS $PHRED $STRANDNESS --dta --summary-file $SUMMARY_FILE
    
    echo "Aligned ${FASTQ_FILE_1} and ${FASTQ_FILE_2} to ${OUTPUT_FILE}"
done
