#!/bin/bash
echo "Runnning genSS8_new.sh"
if [ $# -ne 2 ]
then
	echo "Usage: ./genSS8.sh <tgt_file> <tmp_root>"
	exit
fi

# ---- get arguments ----#
tgt_file=$1
tmp_root=$2

# ---- process -----#
RaptorX_HOME=/storage1/eliza/git/LRRpred_raptorpaths/LRRpredictor_v1/RaptorX_Property_Fast
fulnam=`basename $tgt_file`
relnam=${fulnam%.*}
mkdir -p $RaptorX_HOME/$tmp_root
SS8Pred=$RaptorX_HOME/bin/DeepCNF_SS_Con
$SS8Pred -t $tgt_file > $tmp_root/$relnam.ss8

