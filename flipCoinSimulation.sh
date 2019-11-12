#! /bin/bash -x

isHeads=0
isTails=1
headCount=0
tailCount=0
mulByHundred=100
declare -A flipResults 
read -p "enter the number of times you want to flip the coin : " repeatCount

function flip(){
	flipAcoin=$((RANDOM%2)) 
   if [ $flipAcoin -eq $isHeads ]
   then
      flipResults["$i"]=heads
      headCount=$(($headCount+1))
      echo its heads!
   else
      flipResults["$i"]=tails
      tailCount=$(($tailCount+1))
      echo its tails!
   fi
}
for (( i=0; $i<$repeatCount ; i++ ))
do
	flip 
done
function percentage(){
	echo "$(( $(($1*$mulByHundred)) / $2))" 
}
echo all keys : ${!flipResults[@]}
echo all data : ${flipResults[@]}
headPerc="$( percentage $headCount $repeatCount)"
tailPerc=$(( $(($tailCount * $mulByHundred)) / $repeatCount ))
echo heads percentage : $headPerc
echo tails percentage : $tailPerc
