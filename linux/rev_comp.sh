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
reverse=no
complement=no

# display usage
usage() {
	cat <<EOF
Usage: $PROGRAM [-c|-r|-rc|--help] gene_sequence_file
Options:
	-c: complement
	-r: reverse
	-rc: reverse and complement
EOF
}

# output error and exit 1
error() {
	echo "$@" 1>&2
	usage_and_exit 1
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
	-c ) com=yes
		;;
	-r ) rev=yes
		;;
	-rc|-cr ) 
		rev=yes
		com=yes
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

[ -z $1 ] && error "No sequence input."
[ -f $1 ] && seq=`cat $1` || seq="$1"

# reverse or complement
[ "$com" = yes ] && seq=`complement "$seq"`
[ "$rev" = yes ] && seq=`echo "$seq" | rev`
echo "$seq"
