#! /bin/bash -x

isHeads=0
isTails=1

hCount=0
tCount=0
hhCount=0
ttCount=0
htCount=0
thCount=0
hhhCounter=0
hhtCounter=0
hthCounter=0
httCounter=0
thhCounter=0
thtCounter=0
tthCounter=0
tttCounter=0

mulByHundred=100

declare -A SfirstCoin
declare -A DfirstCoin
declare -A DsecondCoin
declare -A TfirstCoin
declare -A TsecondCoin 
declare -A TthirdCoin

read -p "enter the number of times you want to flip the coin : " repeatCount
#To Flip The Coin ==========================
function flip(){
	flipAcoin=$((RANDOM%2)) 
   if [ $flipAcoin -eq $isHeads ]
   then
		answer="heads"		
   else
		answer="tails"
   fi
	echo "$answer"
}

#Singlet Function ==============
function singlet(){
	Scoin1="$(flip )"
	SfirstCoin["$1"]=$Scoin1
	SaddToCounter $Scoin1
}

#Doublet Function
function doublet(){
	Dcoin1="$(flip )"
	Dcoin2="$(flip )"
	DfirstCoin["$1"]=$Dcoin1
	DsecondCoin["$1"]=$Dcoin2
	DaddToCounter $Dcoin1 $Dcoin2
}

#Triplet Function
function triplet(){
	Tcoin1="$(flip )"
	Tcoin2="$(flip )"
	Tcoin3="$(flip )"	
	TfirstCoin["$1"]=$Tcoin1
	TsecondCoin["$1"]=$Tcoin2
	TthirdCoin["$1"]=$Tcoin3	
	TaddToCounter $Tcoin1 $Tcoin2 $Tcoin3
}


#Counters For Combinations of Singlet =======================
function SaddToCounter(){
      if [ "$1" == "heads" ]
      then
         hCount=$(($hCount+1))
      else
         tCount=$(($tCount+1))
      fi
}

#Counters For Combinations of Doublets =======================
function DaddToCounter(){
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

#Counters For Combinations of Triplets =======================
function TaddToCounter(){
	if [[ "$1" ==  "heads" ]] && [[ "$2" ==  "heads" ]] && [[ "$3" ==  			"heads" ]] 
  	then
		hhhCounter=$(($hhhCounter+1))
	elif [[ "$1" ==  "heads" ]] && [[ "$2" ==  "heads" ]] && [[ "$3" ==  			"tails" ]] 
  	then
		hhtCounter=$(($hhhCounter+1))
	elif [[ "$1" ==  "heads" ]] && [[ "$2" ==  "tails" ]] && [[ "$3" ==  			"heads" ]] 
  	then
		hthCounter=$(($hhhCounter+1))
	elif [[ "$1" ==  "heads" ]] && [[ "$2" ==  "tails" ]] && [[ "$3" ==  			"tails" ]] 
  	then
		httCounter=$(($hhhCounter+1))
	elif [[ "$1" ==  "tails" ]] && [[ "$2" ==  "heads" ]] && [[ "$3" ==  			"heads" ]] 
  	then
		thhCounter=$(($hhhCounter+1))
	elif [[ "$1" ==  "tails" ]] && [[ "$2" ==  "heads" ]] && [[ "$3" ==  			"tails" ]] 
  	then
		thtCounter=$(($hhhCounter+1))
	elif [[ "$1" ==  "tails" ]] && [[ "$2" ==  "tails" ]] && [[ "$3" ==  			"heads" ]] 
  	then
		tthCounter=$(($hhhCounter+1))
	elif [[ "$1" ==  "tails" ]] && [[ "$2" ==  "tails" ]] && [[ "$3" ==  			"tails" ]] 
  	then
		tttCounter=$(($hhhCounter+1))
	fi
}

#============== MAIN FUNCTION =======================

for (( i=0; $i<$repeatCount ; i++ ))
do
	singlet $i
	doublet $i
	triplet $i
done


#To Calculate Percentage Of Various combinations =============
function percentage(){
	echo "$(( $(($1*$mulByHundred)) / $2))" 
}



#To Print Singlet Array ===========
countMax=${#SfirstCoin[@]}
echo singlet array!!!!!!!!!!!!!!
echo ${SfirstCoin[@]}
for (( i=0 ; i<$countMax ; i++ ))
do
	echo coin 1 : ${SfirstCoin["$i"]}
done


#To Print Doublet Array ===========
countMax=${#DfirstCoin[@]}
echo doublet array!!!!!!!!!!!!!!
for (( i=0 ; i<$countMax ; i++ ))
do
	echo coin 1 : ${DfirstCoin["$i"]}      coin 2: ${DsecondCoin["$i"]}
done


#To Print triplet Array ===========
countMax=${#TfirstCoin[@]}
echo triplet array!!!!!!!!!!!!!!
for (( i=0 ; i<$countMax ; i++ ))
do
	echo coin 1 : ${TfirstCoin["$i"]}      coin 2: ${TsecondCoin["$i"]}		coin 3 : ${TthirdCoin["$i"]} 
done
#To Display All Percentages =====================
hPerc="$( percentage $hCount $repeatCount)"
tPerc="$( percentage $tCount $repeatCount)"
hhPerc="$( percentage $hhCount $repeatCount)"
ttPerc="$( percentage $ttCount $repeatCount)"
htPerc="$( percentage $htCount $repeatCount)"
thPerc="$( percentage $thCount $repeatCount)"
hhhPerc="$( percentage $hhhCounter $repeatCount)"
hhtPerc="$( percentage $hhtCounter $repeatCount)"
hthPerc="$( percentage $hthCounter $repeatCount)"
httPerc="$( percentage $httCounter $repeatCount)"
thhPerc="$( percentage $thhCounter $repeatCount)"
thtPerc="$( percentage $thtCounter $repeatCount)"
tthPerc="$( percentage $tthCounter $repeatCount)"
tttPerc="$( percentage $tttCounter $repeatCount)"

echo FOR DOUBLETS **************
echo heads percentage : $hPerc
echo tails percentage : $tPerc

echo FOR DOUBLETS **************
echo both heads percentage : $hhPerc
echo both tails percentage : $ttPerc
echo first heads and second tails percentage : $htPerc
echo first tails and second heads percentage : $thPerc

echo FOR TRIPLETS **************
echo heads-heads-heads percentage : $hhhPerc
echo heads-heads-tails percentage : $hhtPerc
echo heads-tails-heads percentage : $hthPerc
echo heads-tails-tails percentage : $httPerc
echo tails-heads-heads percentage : $thhPerc
echo tails-heads-tails percentage : $thtPerc
echo tails-tails-heads percentage : $tthPerc
echo tails-tails-tails percentage : $tttPerc



