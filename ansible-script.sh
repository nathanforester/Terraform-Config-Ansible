#!bin/bash

sudo apt update

sudo apt install ansible -y

sudo touch playbook.yaml && cat <<ENDL > playbook.yaml
- hosts: localhost
  become: yes
  ignore_errors: true
  tasks:
    
    - name: create SSH key folder and file
      command: sudo mkdir ~/.ssh && touch Estio-Training-NForester

    - name: copy SSH key to file
      command: cat <<ENDL > <insert key data here>
                            ENDL
    
    - name: change SSH key permission
      ansible.builtin.file:
        path: ~/.ssh/Estio-Training-NForester
        mode: '0600'
---

- hosts: nginx  
  become: yes
  ignore_errors: true
  vars:
  tasks:

    - name: Update apt cache
      apt: update_cache=yes 
     
    - name: install nginx
      apt: nginx
      state: reloaded
ENDL

sudo touch inventory.yaml && cat <<ENDL > inventory.yaml
all:
  children:
    nginx:
      hosts:
        10.0.1.1:
  vars:
    ansible_user: nforester86
    ansible_ssh_private_key_file: "~/.ssh/Estio-Training-NForester"
    ansible_ssh_common_args: "-o StrictHostKeyChecking=no"
ENDL

ansible-playbook -v -i inventory.yaml playbook.yaml