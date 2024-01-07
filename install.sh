#!/usr/bin/bash

# Install the dependencies
#clear
cd  /home/ansible/ansible
ansible -i ./hosts all -a "sudo rm -rf /data/*"  --key-file ~/.ssh/id_rsa

ansible -i ./hosts all -a "ls -lt ~/coursework"  --key-file ~/.ssh/id_rsa

#create working directory on clients
ansible-playbook -i ./hosts ./create_working_directory.yml --key-file ~/.ssh/id_rsa

#install  dependencies on clients
ansible-playbook -i ./hosts ./setup_dependence.yml --key-file ~/.ssh/id_rsa


#downlaod s4pred on clients
ansible-playbook -i ./hosts ./down_s4pred.yml --key-file ~/.ssh/id_rsa


#host ��������ԭʼ���� ���ָ�ַ���client
#create working directory on host
ansible-playbook -i ./hosts ./down_experiment_data.pml --key-file ~/.ssh/id_rsa


##���ݶ���������
ansible-playbook -i ./hosts ./exc_script.pml --key-file ~/.ssh/id_rsa



ansible -i ./hosts all -a "ls -lt /data/"  --key-file ~/.ssh/id_rsa
