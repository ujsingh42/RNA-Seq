GENOMEDIR=/mnt/TooBigData/rnaseq_new/refrance
fastqtrimmed=/mnt/TooBigData/rnaseq_new
output_dir=$fastqtrimmed/output

# Create the output directory if it doesn't exist
mkdir -p $output_dir

# Loop through all R1 files and assume corresponding R2 file exists for each R1 file
for R1_file in $fastqtrimmed/*_R1.trimmed.fastq.gz; do
    # Get the sample name from R1_file
    sample_name=$(basename $R1_file _R1.trimmed.fastq.gz)
    R2_file=$fastqtrimmed/${sample_name}_R2.trimmed.fastq.gz

    # Check if the corresponding R2 file exists
    if [ -f $R2_file ]; then
        echo "Processing sample: $sample_name"
        
        STAR --runThreadN 10 --genomeDir $GENOMEDIR \
             --readFilesIn $R1_file $R2_file \
             --outFileNamePrefix $output_dir/${sample_name}_ \
             --readFilesCommand zcat \
             --outSAMtype BAM Unsorted --quantMode TranscriptomeSAM --outFilterType BySJout \
             --alignSJoverhangMin 8 --outFilterMultimapNmax 20 --alignSJDBoverhangMin 1 \
             --outFilterMismatchNmax 999 --outFilterMismatchNoverReadLmax 0.04 --alignIntronMin 20 \
             --alignIntronMax 1000000 --alignMatesGapMax 1000000 --outSAMattributes NH HI AS NM MD

    else
        echo "Warning: R2 file for sample $sample_name not found, skipping."
    fi
done
