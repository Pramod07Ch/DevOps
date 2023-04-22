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

    5) There are also a type of provisioners called `destroy-time` provisioners which will only be executed during the deletion of the resource.
```
### Essential step of any project is 'Network Creation'
1) We need to design the network and then we will provision the infra 

2) The design should include the size of the network and also future demands of growth in mind.

3) Network has to be designed in such a way that only the needed infra should be PUBLIC Facing, rest of them should be 100% private.

4) When I say private, none of them should be accessible directly from the internet.

5) In AWS, we have a service called VPC : `Virtual Private Cloud` , using this we will design and provision our network.

6) In each and every region of AWS, we have a default network where all the infra will be created on that network by default. But, in reality, every organization creates their own network as per their needs.

## What is Network Peering ?
By default, one network cannot communicate with another network directly. In order to establish direct / private communication, we need to perform peering between the networks, then only they can talk to each other.

### Public IP Address vs Private IP Address ?
    Public IP Address is issued by the ISP and is unique across the globe.

    Private IP Adress is unique only with in the Infranet vs Corporate Network 
IP Address as classified in to classes based on their usage :

```
    1) Class A
    2) Class B
    3) Class C
    4) Class D
    5) Class E
```
![img](https://sp-ao.shortpixel.ai/client/to_webp,q_glossy,ret_img,w_575/https://embeddedgeeks.com/wp-content/uploads/2020/06/ip_Class-1.png)

Networking Goals to learn network :
    What are my goals ?
```
    1) I'd like to create a network 
    2) I'd like to break that network in to 2 piece ( subnets )
    3) One should public subnet  ( should have a public ip and access to internet )
    4) One should private subnet ( should only have private ip and no direct access to internet )
    5) Also my ws from default network should be able to talk to Public / Private network, using private IP.

    Network CIDR        : 10.0.0.0/24 
    Public Subnet CIDR  : 10.0.0.0/25
    Private Subnet CIDR : 10.0.0.128/25
```
