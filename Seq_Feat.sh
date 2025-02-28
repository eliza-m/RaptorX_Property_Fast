#!/bin/bash

# ----- usage ------ #
usage()
{
	echo "Sequence Feature Generate "
	echo ""
	echo "USAGE:  ./Seq_Feat.sh [-i input_fasta]"
	echo ""
	exit 1
}

if [ $# -lt 1 ];
then
        usage
fi
curdir="$(pwd)"

# ----- main directory ---#
util=bin
RaptorX_HOME=~/GitBucket/RaptorX_Property_Fast
#-> check directory
if [ ! -f "$RaptorX_HOME/Seq_Feat.sh" ]
then
	echo "AUCpreD program file $RaptorX_HOME/Seq_Feat.sh not exist."
	echo "please run './setup.pl' to configure the package."
	exit 1
fi


# ----- get arguments ----- #
#-> required arguments
input=""
input_fasta=""
Keep_file=0

#-> parse arguments
while getopts ":i:" opt;
do
	case $opt in
	#-> required arguments
	i)
		input=$OPTARG
		;;
	#-> default
	\?)
		echo "Invalid option: -$OPTARG" >&2
		exit 1
		;;
	:)
		echo "Option -$OPTARG requires an argument." >&2
		exit 1
		;;
	esac
done

# ------ judge fasta or tgt -------- #
filename=`basename $input`
extension=${filename##*.}
filename=${filename%.*}
input_fasta=$input

# ------ check required arguments ------ #
#-> check input_fasta
has_fasta=0
if [ ! -f "$curdir/$input_fasta" ]
then
	if [ ! -f "$input_fasta" ]
	then
		has_fasta=0
	else
		has_fasta=1
	fi
else
	input_fasta=$curdir/$input_fasta
	has_fasta=1
fi

# ------ final check ------#
if [ $has_fasta -eq 0 ] 
then
	echo "input_fasta $input_fasta not found" >&2
	exit 1
fi

# ------ part 0 ------ # related path
if [ $has_fasta -eq 1 ]
then
	fulnam=`basename $input_fasta`
	relnam=${fulnam%.*}
fi

# ----- pre process ------ #
cd $RaptorX_HOME
tmp=tmp"_"$relnam"_"$RANDOM
mkdir -p $tmp/
rm -f $tmp/$relnam.seq
if [ $has_fasta -eq 1 ]
then
	cp $input_fasta $tmp/$relnam.seq
fi

# ----- main procedure ------ #
program_suc=1
for ((i=0;i<1;i++))
do
	# ----- generate predicted SSE and ACC ----- #
	cd util/psisolvpred
		./runxxxpred_single ../../$tmp/$relnam.seq 1> $relnam.ws1 2> $relnam.ws2
		mv $relnam.solv $relnam.ss2 ../../$tmp
		rm -f $relnam.ss $relnam.horiz $relnam.ws1 $relnam.ws2
	cd ../../
	# ----- generate feature ----- #
	$util/Diso_Feature_Make_noprof $tmp/$relnam.seq $tmp/$relnam.ss2 $tmp/$relnam.solv -1 > $tmp/$relnam.feat_noprof
	OUT=$?
	if [ $OUT -ne 0 ]
	then
		echo "Failed in generating feature file (no_profile mode) for sequence $relnam"
		program_suc=0
		break
	fi
	cp $tmp/$relnam.feat_noprof $relnam.feat_noprof
done

# ----- return back ----#
cd $RaptorX_HOME
if [ $Keep_file -eq 0 ]
then
	rm -rf $tmp/
fi
cd $curdir

# ---- exit ----- #
if [ $program_suc -ne 0 ]
then
	exit 0
else
	exit 1
fi


