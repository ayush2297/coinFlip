#! /bin/bash -x

isHeads=0
isTails=1

flipAcoin=$((RANDOM%2))

if [ $flipAcoin -eq $isHeads ]
then
	echo its heads!
else
	echo its tails!
fi

