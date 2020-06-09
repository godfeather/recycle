compare(){	
	eqSign=`expr index "$1" "="`
	if [ $eqSign -eq 0 ];then
		echo "#illegal#"
		return 1
	fi
	index=`expr $eqSign - 1`
	name=${1:0:$index}
	value=${1:$eqSign}
	if [ $name == "$2" ];then
		echo "$1"
		return 0
		else
		
		return 0
	fi
}
compare $1 $2

