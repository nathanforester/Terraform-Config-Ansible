#!bin/bash

sudo apt update

sudo apt install ansible -y

sudo touch /home/ubuntu/playbook.yaml 

sudo touch /home/ubuntu/inventory.yaml

sudo chmod 777 /home/ubuntu/playbook.yaml 

sudo chmod 777 /home/ubuntu/inventory.yaml

cat <<ENDL > /home/ubuntu/playbook.yaml
- hosts: jenkins  
  become: yes
  tasks:

    - name: Update apt cache
      apt: update_cache=yes cache_valid_time=3600

    - name: Upgrade all apt packages
      apt: upgrade=dist

    - name: Install dependencies
      apt:
        name: "{{ packages }}"
        state: present
        update_cache: yes
      vars:
        packages:
        - openjdk-8-jre
        - curl
        - git
        - acl

    - name: Clone remote application repository
      command: git clone https://github.com/nathanforester/FlaskMovieDB

    - name: Add jenkins user and append to admin group
      user:
        name: jenkins
        shell: /bin/bash
        password: ''
        groups: admin
        append: yes
    
    - name: Allow 'jenkins' user to have passwordless sudo
      lineinfile:
        dest: /etc/sudoers
        state: present
        line: 'jenkins ALL=(ALL) NOPASSWD:ALL'
        validate: 'visudo -cf %s'

    - name: Import a key from a url
      ansible.builtin.apt_key:
        url: https://pkg.jenkins.io/debian/jenkins.io.key
        state: present

    - name: download jenkins binary
      command: sh -c "echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list"
      
    - name: Update apt cache
      apt: update_cache=yes cache_valid_time=3600

    - name: install jenkins
      apt:
        name: jenkins
        state: present
        update_cache: yes

    - name: Just force systemd to re-execute itself
      ansible.builtin.systemd:
        daemon_reload: yes
        scope: system

    - name: start service jenkins
      ansible.builtin.systemd:
        name: jenkins
        state: started
        scope: system

    - name: get password
      command: cat /var/lib/jenkins/secrets/initialAdminPassword

ENDL

cat <<ENDL > /home/ubuntu/inventory.yaml
all:
  children:
    nginx:
      hosts:
        167.0.1.10:
  vars:
    ansible_user: ubuntu
    ansible_ssh_private_key_file: "/home/ubuntu/.ssh/Estio-Training-NForester"
    ansible_ssh_common_args: "-o StrictHostKeyChecking=no"
ENDL

sudo chmod 640 /home/ubuntu/playbook.yaml

sudo chmod 640 /home/ubuntu/inventory.yaml

sudo chown ubuntu /home/ubuntu/inventory.yaml

sudo chown ubuntu /home/ubuntu/inventory.yaml

sudo touch /home/ubuntu/.ssh/Estio-Training-NForester

sudo chmod 777 /home/ubuntu/.ssh/Estio-Training-NForester

sudo cat <<EOT > /home/ubuntu/.ssh/Estio-Training-NForester
<insert key data here>
EOT

sudo chown ubuntu /home/ubuntu/.ssh/Estio-Training-NForester

sudo chmod 600 /home/ubuntu/.ssh/Estio-Training-NForester

sudo echo 'ubuntu ALL=(ALL:ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo


