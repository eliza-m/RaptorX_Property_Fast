#!/bin/bash
echo "Runnning genSS8.sh"
if [ $# -ne 2 ]
then
        echo "Usage: ./genSS8 <tgt_name> <tmp_root>"
        exit
fi

# ---- get arguments ----#
tgt_name=$1
tmp_root=$2

# ---- process -----#
RaptorX_HOME=/storage1/eliza/git/LRRpred_raptorpaths/LRRpredictor_v1/RaptorX_Property_Fast
SS8_Pred=$RaptorX_HOME/util/SS8_Predict/bin/run_raptorx-ss8.pl

echo "genSS8.sh input: "$tmp_root/$tgt_name.seq
echo "genSS8.sh input: "$tmp_root/$tgt_name.psp
$SS8_Pred $tmp_root/$tgt_name.seq -pssm $tmp_root/$tgt_name.psp -outdir $tmp_root/

