TRIMMOMATIC="trimmomatic"  # Assuming trimmomatic is in your PATH
ADAPTERS="/mnt/TooBigData/humandata/adapterfile/adapters.fasta"  # Path to the adapters FASTA file
INPUT_DIR="/home/manoj/Desktop/script"  # Directory containing paired-end FASTQ.gz files
OUTPUT_DIR="/mnt/TooBigData/humandata/trimmed"  # Directory where trimmed FASTQ files will be saved

# Make sure the output directory exists
mkdir -p $OUTPUT_DIR

# Iterate over paired-end files (assuming they follow a specific naming pattern, adjust as needed)
for file in $INPUT_DIR/*_R1.fastq.gz; do
    # Get base filename without extension
    base=$(basename $file _R1.fastq.gz)

    # Define input and output file paths
    input_R1="$INPUT_DIR/${base}_R1.fastq.gz"
    input_R2="$INPUT_DIR/${base}_R2.fastq.gz"
    output_R1="$OUTPUT_DIR/${base}_R1.trimmed.fastq.gz"
    output_R1_unpaired="$OUTPUT_DIR/${base}_R1.unpaired.fastq.gz"
    output_R2="$OUTPUT_DIR/${base}_R2.trimmed.fastq.gz"
    output_R2_unpaired="$OUTPUT_DIR/${base}_R2.unpaired.fastq.gz"

    # Run Trimmomatic
    $TRIMMOMATIC PE -threads 9 -phred33 \
        $input_R1 $input_R2 \
        $output_R1 $output_R1_unpaired \
        $output_R2 $output_R2_unpaired \
        ILLUMINACLIP:$ADAPTERS:2:30:10 \
        LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

    # Output progress
    echo "Trimmed files saved for $base"
done

echo "Trimming complete."
