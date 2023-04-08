# ansible

Ansible automates the management of remote systems and controls there desired state.

A basic ansible environment consists of three main components:
- Control node: a system on ansible is installed
- Managed node: a remote system or host that ansible controls
- Inventory: a list of managed nodes that are logically organized

Ansible by default installs 2.9 as by default on AMI's we will get python2.

Install latest python version 3.0<, then install ansible

```
Variables should be passed to ansible by using the flag -e 
    
    Ex: ansible -i INVENTORY all  -e ansible_user=userName -e ansible_password=password 
    $ ansible -i inv all  -e ansible_user=centos -e ansible_password=xyz123 -m shell -a uptime

```

### INVENTORY : Inventory is nothing but the list of machine ip or dns names that you want ansible to be managed

all is a group which included all the entries in INVENTORY File

ANSIBLE has lot of pre-defined variables.
we need to use them to supply userName and password it has to use to authenticate to the nodes.
 
### ansible_user     : Predefined variable for userName 
### ansible_password : Predefined variable for password  


Ansible is a collection of modules / collections : Whatever the task that you want to perform is already predefined, all you need is just to consume them.

There 1000's of modules available : -m shell.  -m yum , -m service


### Ansible can be executed in 2 ways : 

```

1) Manual Approach      : using ansible command  : With this you can execute one command at time.
2) Automated Approach   : using ansible playbook : With this we can mention all the set of tasks that needs to be executed, things will happen in the declared approach.

## Automated Approach : This uses Playbook 

```
Playbooks are written using a language called YAML.

YAML is just  markup languaga ; Markup language is nothing a presentation language

```

`YAML` is indendation specific.


### What is a playbook ?

```
* Playbook : A Playbook is a list of plays ( and that's why it always starts with - )
* Play     : A Play is a list of tasks.
* Task     : A Task is nothing but an action that we wish to perform

```
### Ansible Facts :

```
Facts are the properties of the remote nodes that you ansible is going to collect ;  Based on these facts collected ansible decides whether to perform the action or not 

How do I know, what all are the facts that are collected by ANSIBLE ?

* Ansible uses a module called as setup using that we can check the collected facts 

    $ ansible -i inventory all -m setup 

```
### Ansible-Pull 

```
ansible-pull -U urlName.git playbookName.yml -e COMPONENT=componentName
```

### Block and Rescue :

Block is nothing but a group of tasks; 
Rescue will only be executed if any of the tasks in the block of tasks fail.

### Ansible-Dryrun Command 

```
ansible-playbook robot-dryrun.yaml -e COMPONENT=mongodb -e ansible_user=centos -e ansible_password=xyz123 -e ENV=qa