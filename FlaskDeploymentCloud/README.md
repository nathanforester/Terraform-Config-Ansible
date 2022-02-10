# Deployment of Flask App

## Using:

- Ansible

- Jenkins CI Server - hosted through AWS

- Docker Deployment Server - hosted through AWS

- Python - Flask framework

- Unit testing (pytest)

- Bash provisioning scripts

### Steps Taken:

- Spin up the necessary number of virtual machines using a cloud provider (could be GCP, AWS, Microsoft etc).

- Create an SSH key for each machine.

- Use your Jenkins server SSH key to access the Jenkins Server VM/instance.

- Complete the previous step by accessing your local .ssh folder and entering the following command:

```
   ssh -i <yourkeyname.pem> <user>@ip address 

```

- Replace the key name with your own key name and the IP address with that of your Jenkins instance.

- Run a script to setup your Jenkins Server. This changes with software deprecations, please research for current version - it is available open source. 

- Upon being given the initial admin password, access the server on port 8080.

- Follow the instructions to set up the server.

- Configure your pipeline and add a webhook to both your Jenkins project and your SCM.

- Ensure that your inventory file has the correct IP address of the deployment instance you are using (can also be found on the AWS instances console)

- Copy the private key (.pem) file of your deployment instance and place it in the .ssh folder of your Jenkins instance under both the jenkins user and ubuntu user (this step may be edited - it may also involve root user, although this is unlikely).

- Change permissions on the newly created and copied key file, either with chmod 400 or 600 (I prefer 400 myself for an extra layer of security).

- Test your build on the Jenkins Server. Hopefully it will fail a few times before it builds successfully - it's all part of the fun!

- Currently on build 27

- This approach has been rather complicated - a private key has to be generated on the jenkins instance as jenkins user with 'NOPASSWD' enabled in sudo visudo.

- Anomolous results with reconfiguration - not building this repo

- may need to configure Ansible plugin - and also install Ansible onto node, ensuring it is in the PATH

- Add key files to .ssh folder in jenkins folder. If no .ssh folder exists, create one.

- The Jenkins pipeline should not require such ridiculously complex configuration.
