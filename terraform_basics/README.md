# terraform-basics

This folder conatins the basics needed to understand and start learning and implementing in Github

```
Latest version of terraform available in terraform.io
version : 1.4.5
```

### How to install terraform?
https://developer.hashicorp.com/terraform/downloads

### Points to be remembered in terraform 

```
    1) Terraform is case sensitive 
    2) There is no concept of single quotes and usage of it is strictly prohibited
    3) By default terraform picks the file with the name terraform.tfvars and any varible that's declared outside of terraform.tfvars needs to be explicitly mentioned. 
    ### varaibale precedence

    <--- high              ---> low
    -var, -var-file ; auto.tfvars; terrafrom.tfvars; SHELL, ENV, VARS 

    4) How to pass a SHELL variable in terraform : export TF_VAR_STATE=AP
    5) Datasource in Terraform helps us in querying the information that is already available on Provider and this eliminates the static declarartion of variables
```
### Provisioners
Provisioner in terraform helps us to achieve executing tasks on the local machine or on the remote machine.

```
        1) File Provisioner        : To copy the file to the destination machine 
        2) Connection Provisioner  : This is to establish connection to the remote machine with authentication
        3) Local Provisioner       : This is to execute some task on the top of the machine where we run terraform
        4) Remote Provisioner      : This is to execute some task on the top of the machine where we run terraform
```
Use case using provisoners :
```
    1) First I want to create a EC2 Instance along with a security group

    2) Once the Ec2 is created, on the top of the EC2, I'd like to create run the ansible-pull command and run the ansible playbook so that my server will be operationally ready.

    3) For the second step to happen, we need to ensure first, connection-provisoner has to be executed, so that  connection will be established and then we can run the `remote-exec` provisioner to run the ansible-pull command.

    4) Provisioners by default are `create-time` provisioners, that means provisioners by default will only run during the creation of the resource, not all the time you run the `terraform-apply`

    5) There are also a type of provisioners called `destroy-time` provsioners which will only be executed during the deletion of the resource.
```
