#!/bin/bash  

declare -A keyArr
declare -A valArr
declare -A result

mulByHundred=100

function percentage(){
  echo "$(( $(($1*$mulByHundred)) / $2))"
}


function coinFlipSimulation() {
for (( i=1; i<=$1; i++ ))
do
s=""
  for(( j=0; j<$2; j++ ))
  do
    coinFlip=$(( RANDOM % 2 ))
     if [ $coinFlip == 1 ]
then
    s=$s"H"
        headCount=$(( $headCount + 1 ))
  else
           s=$s"T"
        tailCount=$(( $tailCount + 1))
fi
done
echo final key : $s
result["$s"]=$(( ${result["$s"]} + 1 ))  
done
}


function displayData()
{
	echo ${!result[@]}
	echo ${result[@]}
	elCount=${#result[@]}
	
	index=0
	for key in  ${!result[@]}
	do
		keyArr[$index]=$key
		valArr[$index]=${result[$key]}
		index=$(($index+1))
	done
	
	echo "key arr::::::::::::: ${keyArr[@]}"
	echo "val arr::::::::::::: ${valArr[@]}"
	for (( ind=0 ; $ind<$elCount ;ind++ ))
	do
		echo -e "$ind	${keyArr[$ind]}	${valArr[$ind]}"
	done
	

	for (( ind=0 ; $ind<$elCount ;ind++ ))
	do
	  perc="$( percentage ${valArr[$ind]} $repititions )"
	  echo "${keyArr[$ind]}	%	=	$perc"	
	done
	
	echo key arr before sorting : ${keyArr[@]}
	echo val arr before sorting : ${valArr[@]}
	for ((i = 0; i<elCount; i++))	
	do
		jCount=$(( $elCount - 1 ))
		for (( j=0 ; $j < $jCount ; j++ ))
		do	
			k=$(($j+1))
			num1="${valArr[$j]}"
			num2="${valArr[$k]}"
			if (( ${valArr[$j]:-0} < ${valArr[$k]:-0} ))
			then
				temp=${valArr[$j]}
				valArr[$j]=${valArr[$k]}
				valArr[$k]=$temp
	
				temp1=${keyArr[$j]}
	     	keyArr[$j]=${keyArr[$k]}
	      	keyArr[$k]=$temp1
		fi
		done
	done
	for (( ind=0 ; $ind<$elCount ;ind++ ))
	do
		echo $ind	${keyArr[$ind]}	${valArr[$ind]}
	done
}

read -p "how much time you flip coin " repititions
#read -p "number of coins? : " numberOfCoins
for (( coins=1 ; $coins<4 ; coins++ ))
do
echo "*************COMBINATIONS FOR $coins COINS************************"
coinFlipSimulation $repititions $coins
echo "*************DISPLAYING PERCENTAGES************************"
displayData
done

