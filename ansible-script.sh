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
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAlO9us+PsI45z5dMXU4A0Tbd7DXZ6nejDe404xuOSqDsfZxUd
3briE5C48lMzy6E8K3TFCY1MZgyAOc7ljNLLYJ8VzSBb6JRRsHAc0MJfVd3VGFf6
PRYrwAZ1mY9nen73CbYUcycNCwBgAFl9S15pVSnTzGwp+rb8HBBV7/wOFvkVzZR7
jFPprF3YhPyw64W1RyHxA+uCS2T8LGmyYt4gC4PMibJEaG96HdX0U9zcM50LT0HK
E5UgnTPWqsYScIf8KtutghQyrIdFiVeteCLOvGQJk66IavX2mLsFoYAk9kMEL8w0
pMxxXte7KblHF4ridciJXUJWWtmx3av+HC1S1QIDAQABAoIBAGFVMNXjqJl8KYYT
NHVfnc8EkCi2O2AjlE2Ud3yTkW7cZKNri38y+TisJhJICduUXcxQncymST2QAeTF
sAMeZ8eXcBoEgcw30kMqocpUnRVyyicEqAdwC9uM3SIkNA48F5qDIk43QTDlZ9gS
o+2zn8cGdOJt9elh2NVGX8NcyKB92IgenX0P3CC5HWco5uWA49X+t/ySjDOpHt78
/Lwocxy1+4/qDV2Np8K7Y7wNkUKVEGyhFsrJs6KO1y7eIhInMoJvVzTBwIVhz5iy
/S95DEA+YLtcHcGpYJc+I3blcOimpcCUnkIYf71VsqLWjC2y6L3SlKWBDNO0wX+F
z+DuIMECgYEA7VKfIkN9BcrS0GAolrLL9kQ6QmwjSBXtW9zStELgaQRlvfv15Rh1
0Nu01+B/TPzk/6lo4mLRDjwiQcJjrQbnqZGT/3aEhymjtTKSoQ2BcRGpok7nIGBQ
kDVmbmRZdj0ZUK9sp+gUIg2sQ0lNxAlF0FtrCD5fRirBnoWOjvSnSJ0CgYEAoKgO
DG7DHFlvyY/RL20M8ItfC5CzuKK4mzSugiD22HsUNHYOicCXCvU+qMLIGYX8TFWE
iRXcJSVRjONhLuM6qOwo3S4dfMaABuj0YELC9X1uBZ22oMD6MJopAFu2cgHV2gvp
sBsCrZnkCrgjmeMJapuYOIWlvGuFY853T0q6kZkCgYEAmq/Y07+DlSvvnyyeKCPg
d+Neyf6sPIc2UEMt/5r7pNfd7Sh2zV3VJU6foHpO34KTTOVCXRUlyI5/kbc/uv8e
LtOZ0NCSb3s/npKZKmqgLW/izs15Lww4VtbHrjqwaTZH8uR1AThvLwcUekMkchvN
KpL7v8LP3O9vhoDtO9bR1q0CgYEAmh0cfOiz2johdmWz8Z7Wztmjr2B8Rx4xoRGE
ZehhY4GN/FVT1Oke+7APD6zqbzGMuV0/6pFBwZBvDowA6g2oc+s3uBVIzC1PG1HV
O5JPm1dbd5+3VbZJSt5XfrR77Bm+n5DV982xX/9ENtQ1sqWMnuvrtizetEUgjIG/
Ch1Ro+ECgYEAqoCC2OJ1Oz+ZeeBbpKlyJ2BEqMXmCAsf5tiKTDprVuNmp1Ft7XAd
V6R0gZW8bWYj183Bw5GWTXAYUsStZU/1UEZ33eF8I3uZaPEtuqMHXMnUZtcQV6ts
FGSBuJ1Px8T9uzoek8qUr/cbOzjtZLWOUgmLcCrbVyi3dGQLYCP4ZXM=
-----END RSA PRIVATE KEY-----
EOT

sudo chown ubuntu /home/ubuntu/.ssh/Estio-Training-NForester

sudo chmod 600 /home/ubuntu/.ssh/Estio-Training-NForester

sudo echo 'ubuntu ALL=(ALL:ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo


