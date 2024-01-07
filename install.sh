#!/usr/bin/bash

# Install the dependencies
#clear
ansible -i ./hosts "sudo rm -rf ~/*"  --key-file ~/.ssh/ansible_identity

#create working directory on clients
ansible-playbook -i ./hosts ./create_working_directory.yml --key-file ~/.ssh/ansible_identity

#install  dependencies on clients
ansible-playbook -i ./hosts ./setup_dependence.yml --key-file ~/.ssh/ansible_identity



#downlaod s4pred on clients
ansible-playbook -i ./hosts ./down_s4pred.yml --key-file ~/.ssh/ansible_identity


#host 上面下载原始数据 并分割分发给client
#create working directory on host
ansible-playbook -i ./hosts ./down_experiment_data.pml --key-file ~/.ssh/ansible_identity


##数据都主备好了
ansible-playbook -i ./hosts ./exc_script.pml --key-file ~/.ssh/ansible_identity
