#!bin/bash

sudo apt update

sudo apt install ansible -y

sudo touch /home/ubuntu/playbook.yaml 

sudo touch /home/ubuntu/inventory.yaml

sudo chmod 777 /home/ubuntu/playbook.yaml 

sudo chmod 777 /home/ubuntu/inventory.yaml

cat <<ENDL > /home/ubuntu/playbook.yaml
- hosts: nginx  
  become: yes
  tasks:

    - name: Update apt cache
      apt: update_cache=yes 
          
    - name: install nginx
      apt: 
        name: nginx
        state: latest

ENDL

cat <<ENDL > /home/ubuntu/inventory.yaml
all:
  children:
    nginx:
      hosts:
        167.0.1.10:
  vars:
    ansible_user: ubuntu
    ansible_ssh_private_key_file: "/home/ubuntu/.ssh/<insert key name here>"
    ansible_ssh_common_args: "-o StrictHostKeyChecking=no"
ENDL

sudo chmod 640 /home/ubuntu/playbook.yaml

sudo chmod 640 /home/ubuntu/inventory.yaml

sudo chown ubuntu /home/ubuntu/inventory.yaml

sudo chown ubuntu /home/ubuntu/inventory.yaml

sudo touch /home/ubuntu/.ssh/<insert key name here>

sudo chmod 777 /home/ubuntu/.ssh/<insert key name here>

sudo cat <<EOT > /home/ubuntu/.ssh/<insert key name here>
<insert key data here>
EOT

sudo chown ubuntu /home/ubuntu/.ssh/<insert key name here>

sudo chmod 600 /home/ubuntu/.ssh/<insert key name here>

sudo echo 'ubuntu ALL=(ALL:ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo


