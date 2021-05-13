#!/bin/bash
echo "Runnning genACC_new.sh"
if [ $# -ne 2 ]
then
	echo "Usage: ./genACC.sh <tgt_file> <tmp_root> "
	exit
fi

# ---- get arguments ----#
tgt_file=$1
tmp_root=$2

# ---- process -----#
RaptorX_HOME=/storage1/eliza/git/LRRpred_raptorpaths/LRRpredictor_v1/RaptorX_Property_Fast
fulnam=`basename $tgt_file`
relnam=${fulnam%.*}

ACCPred=$RaptorX_HOME/bin/AcconPred
$ACCPred $tgt_file 1 > $tmp_root/$relnam.acc

echo "Finished genACC_new.sh"
