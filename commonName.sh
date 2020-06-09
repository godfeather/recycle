#!/bin/bash

# author:Mrright
# version:1.0
#
# 该脚本用于比较文件中是否存在相同的name，该文件中没组数据的格式为name=value,通过比较每组中的name来比较是否存在，如果存在则输出value；每组数据通过“#”分割
# 用法：通过$1传入name,$2传入文件名称

	if [ "$1" == "" ] || [ "$2" == "" ];then
		echo "parameter not enough!"
		echo "need filename and match value"
		exit
	fi 
	data=`cat "$1"`
	arrayIndex=0
	while [ 0 -lt "${#data}" ]
		do
		
			splitIndex=`expr index "$data" "#"`
			if [ 0 -eq "$splitIndex" ];then
				matched=`compare.sh "$data" "$2"`
				
				if [ "$matched" == "#illegal#" ];then
					echo ""	
				elif [ "$matched" == "" ];then
					newData[$arrayIndex]=$data
					arrayIndex=`expr $arrayIndex + 1`
				else
					echo "$matched"
				fi
				
				break
			else
				strOff=`expr $splitIndex - 1`
				dataCell=${data:0:$strOff}
				if [ "$dataCell" == "" ];then
					continue	
				fi	
				matched=`compare.sh "$dataCell" "$2"`
				
				if [ "$matched" == "#illegal#" ];then
					echo ""
				elif [ "$matched" == "" ];then
					newData[$arrayIndex]=$dataCell
					arrayIndex=`expr $arrayIndex + 1`
				else
					echo "$matched"
				fi
					
				data=${data:$splitIndex}
			fi		
		done
runIndex=0
userHome=`ls ~ -d`
# 刷新地址记录表

tabFile="$userHome/.recycleInfo/.recycleTable.tab"
while [ "$runIndex" -lt "$arrayIndex" ]
do
		if [ "${#print}" -eq 0 ];then
			print="${newData[$runIndex]}"
		else
			print="$print#${newData[$runIndex]}"
		fi
	runIndex=`expr $runIndex + 1`
done
printf  "$print" > "$tabFile"
