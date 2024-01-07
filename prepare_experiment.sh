#!/usr/bin/bash

#split experiment_ids
ROOTPATH=/data/coursework/

cd $ROOTPATH

CLI_NUM=5
totalNum=`wc -l /data/coursework/data/uniprotkb_proteome_UP000005640_2023_10_05.fasta | awk '{print $1}'`
echo $totalNum
avgNum=`expr $totalNum / $CLI_NUM + 1`
echo $avgNum

split -l $avgNum /data/coursework/data/uniprotkb_proteome_UP000005640_2023_10_05.fasta /data/coursework/data/split_ids/datafile_part_
