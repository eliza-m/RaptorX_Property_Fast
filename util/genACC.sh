#!/bin/bash
echo "Runnning genACC.sh"
if [ $# -ne 2 ]
then
        echo "Usage: ./genACC <tgt_name> <tmp_root> "
        exit
fi

# ---- get arguments ----#
tgt_name=$1
tmp_root=$2

echo "ACC input is : "$tmp_root/$tgt_name.hhm

# ---- process -----#
RaptorX_HOME=/storage1/eliza/git/LRRpred_raptorpaths/LRRpredictor_v1/RaptorX_Property_Fast
ACCPred=$RaptorX_HOME/util/ACC_Predict/acc_pred

#$ACCPred $RaptorX_HOME/$tmp_root/$tgt_name.hhm $RaptorX_HOME/$tmp_root/$tgt_name.ss2 $RaptorX_HOME/$tmp_root/$tgt_name.ss8 $RaptorX_HOME/util/ACC_Predict/model.accpred $RaptorX_HOME/$tmp_root/$tgt_name.acc
$ACCPred $tmp_root/$tgt_name.hhm $tmp_root/$tgt_name.ss2 $tmp_root/$tgt_name.ss8 $RaptorX_HOME/util/ACC_Predict/model.accpred $tmp_root/$tgt_name.acc
