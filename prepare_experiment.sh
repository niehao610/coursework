#!/usr/bin/bash

#split experiment_ids
ROOTPATH=/home/ec2_user/coursework/

cd $ROOTPATH

CLI_NUM=5
totalNum=`wc -l ./data/experiment_ids.txt | awk '{print $1}'`
echo $totalNum
avgNum=`expr $totalNum / $CLI_NUM + 1`
echo $avgNum

split -l $avgNum ./experiment_ids.txt ./data/split_ids/datafile_part_
