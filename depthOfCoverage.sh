CHROMOSOME="chr22" # change this to any chromosome you like
BASE_PATH='/hackathon/Hackathon_Project_4/'

#INDEXED_RG_BAMPATHS="/hackathon/Hackathon_Project_4/ENCODE_DATA_GM12878/COMPLETED/*_rg*bai" # TODO: change this to bam when everything is indexed
#REFERENCE="/hackathon/Hackathon_Project_4/REFERENCE_GENOME/hg19_ENCODE.fa"
#GENEFILE="/hackathon/Hackathon_Project_4/REFERENCE_GENOME/refGene_"$CHROMOSOME"_sorted.txt"
#OUTPUT_DIRECTORY="/hackathon/Hackathon_Project_4/ENCODE_DATA_GM12878/COMPLETED/DepthOfCoverage"

REFERENCE=$BASE_PATH"REFERENCE_GENOME/hg19_ENCODE.fa"
GENEFILE=$BASE_PATH"REFERENCE_GENOME/refGene_"$CHROMOSOME"_sorted.txt"

BAM_PATHS=$BASE_PATH"ENCODE_DATA_GM12878/COMPLETED/rg_bams/"
#BAM_PATHS=$BASE_PATH"ENCODE_DATA_GM12878/COMPLETED/DepthOfCoverage/"
OUTPUT_DIRECTORY=$BASE_PATH"ENCODE_DATA_GM12878/COMPLETED/DepthOfCoverage1"
BAMS=$BAM_PATHS"*_rg*bai" # Get indexed rg bam files (Run "readGroup.sh")
#BAMS=$BAM_PATHS"ENCFF000WCN*_rg*bai" # Get indexed rg bam files (Run "readGroup.sh")
#BAMS=$BAM_PATHS"ENCFF000WCQ*_rg*bai" # Get indexed rg bam files (Run "readGroup.sh")
#BAMS=$BAM_PATHS"ENCFF000WD*_rg*bai" # Get indexed rg bam files (Run "readGroup.sh")
#mkdir $OUTPUT_DIRECTORY

DEPTH_COMMANDS_FILE=${OUTPUT_DIRECTORY}/"depth_commands.sh"

for bam in $(ls $BAMS);
do
    # change the regex extension replacement 
    DEPTH_COMMAND="gatk -T DepthOfCoverage -R $REFERENCE -I $(echo $bam|sed 's/.bai//g') -L $CHROMOSOME --minBaseQuality 20 --minMappingQuality 10 --maxBaseQuality 1000000 -l INFO --calculateCoverageOverGenes $GENEFILE -o ${OUTPUT_DIRECTORY}/$(basename $bam|sed 's/.bam.bai/.depth/g')"
    $DEPTH_COMMAND
    #echo $DEPTH_COMMAND
done > $DEPTH_COMMANDS_FILE
