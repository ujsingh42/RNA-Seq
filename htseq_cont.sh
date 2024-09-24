# Directory containing BAM files
BAM_DIR=/mnt/TooBigData/humandata/trimmed/samnew/output_BAM/sorted_BAM"
# Directory to save the count files
COUNT_DIR="/mnt/TooBigData/humandata/trimmed/samnew/output_BAM/sorted_BAM/htseq-count"
# Path to your gene annotation file
GTF_FILE="/mnt/TooBigData/rnaseq_new/grch38/Homo_sapiens.GRCh38.112.gtf"

# Create the COUNT_DIR if it doesn't exist
mkdir -p "$COUNT_DIR"

# Function to run htseq-count on a single BAM file
run_htseq_count() {
    bam_file=$1
    base_name=$(basename "$bam_file" .sam_sorted.bam)
    count_file="$COUNT_DIR/${base_name}_counts.txt"
    htseq-count -f bam -r name -s yes "$bam_file" "$GTF_FILE" > "$count_file"
    echo "Counts for $bam_file saved to $count_file"
}

# Export necessary variables
export -f run_htseq_count
export GTF_FILE
export COUNT_DIR

# Loop through all BAM files and process them sequentially
for bam_file in "$BAM_DIR"/*.sam_sorted.bam; do
    run_htseq_count "$bam_file"
done


#-f bam: Input file format is BAM.
#-r pos: Sorted by position (use name if sorted by read names).
#-s no: Strandness of the data (yes, no, or reverse depending on your experiment).
#no: For unstranded data.
#yes: For forward stranded data.
#reverse: For reverse stranded data.
