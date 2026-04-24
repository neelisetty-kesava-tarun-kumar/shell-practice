#!/bin/bash 

#INTEGER FORMAT
NUM1=100
NUM2=200


SUM=$(($NUM1+$NUM2))

echo "Sum is :: $SUM"

#STRING FORMAT
FRUITS=("Apple" "Banana" "Papaya")

echo "Fruits are ${FRUITS[@]}" #@ means everything (will be printed by denoting the @ symbol)
