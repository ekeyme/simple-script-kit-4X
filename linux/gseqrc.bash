#! /bin/bash -
#
# 此脚本可反转基因字符序列，并能转换成互补基因序列。
# 可用于测序序列分析，特别适合懒得开或者没有下载序列分析软件。
# Make it for fun. ekeyme

# Set separator = newline
IFS='
'

PATH=/usr/local/bin:/bin:/usr/bin
export PATH

PROGRAM=$(basename $0)
# by default, sequece will be reversed and complemented
reverse=yes
complement=yes

# display usage
usage() {
	cat <<EOF

Usage: $PROGRAM [-c|-r|--help] [-f gene_sequence_file]|gene_sequence
Options:
	-c: complement ONLY
	-r: reverse ONLY
	-f: input sequence in file
	--help: display this help and exit
Notice: if option -c OR -r is not given, then, by default your sequence will be reversed and complemented.
EOF
}

# output error and exit 1
error() {
	echo "$@" 1>&2
	usage_and_exit 1
}

# rise notic
notice() {
	echo "Notice: $@" 1>&2
}

# print usage and exit program
#- param1: int, exit number
usage_and_exit() {
	usage
	exit $1
}

# complement sequence
#- param1: string, gene sequence 
complement() {
	echo $1 | tr 'ATGCatgc' 'TACGtacg'
}

#---
#parse param
while [ $# -gt 0 ]
do
	case $1 in
	-c ) reverse=no
		;;
	-r ) complement=no
		;;
	-f ) 
		is_file=yes
		;;
	--help|-h|- ) usage_and_exit
		;;
	-* ) error "Invalid param: $1"
		;;
	* ) break
		;;
	esac
	shift
done

# check arguments
arguments="$@"
[ -z "$arguments" ] && error "No sequence or file inputted."
if [ "$is_file" = 'yes' ]
then
	if [ ! -r "$arguments" ]
	then
		echo "Invalid file: $arguments" 1>&2
		exit 1
	fi

	seq=`cat "$arguments"`
else
	seq="$arguments"
fi

# reverse or complement
[ ` echo $seq | grep -e '[^ATGCatgc]' ` ] && notice "Your sequence contains invalid characters of DNA."
[ "$complement" = 'yes' ] && seq=`complement "$seq"`
[ "$reverse" = 'yes' ] && seq=`echo "$seq" | rev`
echo "$seq"