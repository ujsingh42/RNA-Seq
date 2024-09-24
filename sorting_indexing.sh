input_dir="/mnt/TooBigData/humandata/trimmed/samnew/test"
sorted_dir="/mnt/TooBigData/humandata/trimmed/samnew/output_BAM/sorted_BAM"
threads=9  # Set the desired number of threads

mkdir -p "$sorted_dir"

# Sorting and indexing BAM files by read names
for file in "$input_dir"/*.bam; do
    base=$(basename "$file" .bam)
    sorted_file="$sorted_dir/${base}_sorted.bam"
    
    # Sort BAM file by read names
    samtools sort -n -@ "$threads" -o "$sorted_file" "$file"
    
    # Index the sorted BAM file
    samtools index "$sorted_file"
done
