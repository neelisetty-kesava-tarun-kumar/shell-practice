#!/bin/bash

START_TIME=$(date +%s)

echo "Script executed at:: $START_TIME"

sleep 10 

END_TIME=$(date +%s)

TOTaL_TIME=$(($END_TIME-$START_TIME))

echo "Script executd in:: $TOTaL_TIME"