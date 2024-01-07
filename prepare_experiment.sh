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

scp  -y /data/coursework/data/split_ids/datafile_part_aa  ec2-35-176-93-106.eu-west-2.compute.amazonaws.com:/tmp/rawdata.fasta
scp -y /data/coursework/data/split_ids/datafile_part_ab   ec2-3-11-209-4.eu-west-2.compute.amazonaws.com:/tmp/rawdata.fasta
scp -y /data/coursework/data/split_ids/datafile_part_ac   ec2-3-9-251-72.eu-west-2.compute.amazonaws.com:/tmp/rawdata.fasta
scp -y /data/coursework/data/split_ids/datafile_part_ad   ec2-35-178-89-67.eu-west-2.compute.amazonaws.com:/tmp/rawdata.fasta
scp -y /data/coursework/data/split_ids/datafile_part_ae   ec2-35-179-98-206.eu-west-2.compute.amazonaws.com:/tmp/rawdata.fasta