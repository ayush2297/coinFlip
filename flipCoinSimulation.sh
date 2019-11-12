#! /bin/bash

isHeads=0
isTails=1
headCount=0
tailCount=0
hhCount=0
ttCount=0
htCount=0
thCount=0

mulByHundred=100
declare -A firstCoin
declare -A secondCoin 

read -p "enter the number of times you want to flip the coin : " repeatCount

function flip(){
	flipAcoin=$((RANDOM%2)) 
   if [ $flipAcoin -eq $isHeads ]
   then
		answer="heads"		
      headCount=$(($headCount+1))
   else
		answer="tails"
      tailCount=$(($tailCount+1))
   fi
	echo "$answer"
}

function addToCounter(){
	if [ "$1" ==  "$2" ]
   then
      if [ "$1" == "heads" ]
      then
         hhCount=$(($hhCount+1))
      else
         ttCount=$(($ttCount+1))
      fi
   else
      if [ "$1" == "heads" ]
      then
         htCount=$(($htCount+1))
      else
         thCount=$(($thCount+1))
      fi
   fi
}


for (( i=0; $i<$repeatCount ; i++ ))
do
	firstFlipVal="$(flip )"
	secondFlipVal="$(flip )"
	firstCoin["$i"]=$firstFlipVal
	secondCoin["$i"]=$secondFlipVal
	addToCounter $firstFlipVal $secondFlipVal
done


function percentage(){
	echo "$(( $(($1*$mulByHundred)) / $2))" 
}
countMax=${#firstCoin[@]}



for (( i=0 ; i<$countMax ; i++ ))
do
	echo coin 1 : ${firstCoin["$i"]}      coin 2: ${secondCoin["$i"]}
done

hhPerc="$( percentage $hhCount $repeatCount)"
ttPerc="$( percentage $ttCount $repeatCount)"
htPerc="$( percentage $htCount $repeatCount)"
thPerc="$( percentage $thCount $repeatCount)"
echo both heads percentage : $hhPerc
echo both tails percentage : $ttPerc
echo first heads and second tails percentage : $htPerc
echo first tails and second heads percentage : $thPerc

