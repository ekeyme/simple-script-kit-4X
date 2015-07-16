#! /bin/bash -
#
# 此脚本可反转基因字符序列，并能转换成互补基因序列。
# 可用于测序序列分析，特别适合懒得开或者没有下载序列分析软件。
# Make it for fun. @ekeyme

# Set separator = newline
IFS='
'

PATH=/usr/local/bin:/bin:/usr/bin
export PATH

rev=no
com=no

usage() {
	cat <<EOF
用法：
		rev_comp [-c|-r|--help] gene_sequence_file

选项:	-c 转换基因序列，呈现其互补序列
		-r 反转基因序列

!注:	不提供如何选项，不作改变。
EOF
	exit
}

complement() {
	seq=`echo "$1" | sed \
		-e 's/A/大/g' -e 's/a/小/g' \
		-e 's/T/A/g' -e 's/t/a/g' \
		-e 's/大/T/g' -e 's/小/t/g' \
		-e 's/G/大/g' -e 's/g/小/g' \
		-e 's/C/G/g' -e 's/c/g/g' \
		-e 's/大/C/g' -e 's/小/c/g' \
		`
}

while [ $# -gt 0 ]
do
	case $1 in
	-c ) com=yes
		;;
	-r ) rev=yes
		;;
	--help ) usage
		;;
	-* ) echo "无法识别选项: $1" >&2
		 exit 1
		;;
	* ) break
		;;
	esac
	shift
done

[ -z $1 ] && {
	echo "没有可用基因序列！" >&2
	exit 1
	}

[ -f $1 ] && seq=`cat $1` || seq="$1"

[ "$com" = yes ] && complement "$seq"
[ "$rev" = yes ] && seq=`echo "$seq" | rev`

echo "$seq"
