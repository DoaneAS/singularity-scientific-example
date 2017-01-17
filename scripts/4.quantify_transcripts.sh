if [ $# -eq 0 ]; then
    echo "\nUsage:"
    echo "./4.quantify_transcripts.sh [DATADIR]"
    exit
else

DATADIR=$1

if [ ! -d $DATADIR ]; then
    echo "$DATADIR does not exist! Exiting."
    exit
fi


if [ ! -d $DATADIR/Kallisto ]; then
    mkdir $DATADIR/Kallisto
fi

OUT_DIR=$DATADIR/Kallisto/rna
if [ ! -d $OUT_DIR ]; then
    mkdir $OUT_DIR
fi

kallisto quant -b 100 --seed=1 --plaintext -t 4 -i $DATADIR/Reference/kallisto_index $DATADIR/Fastq/rna_1.fq.gz $DATADIR/Fastq/rna_2.fq.gz -o $OUT_DIR