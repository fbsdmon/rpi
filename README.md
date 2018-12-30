Manage Raspberry Pi with Ansible

**Table Of Contents**
- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
  - [How-To install Ansible on Raspberry Pi](#how-to-install-ansible-on-raspberry-pi)
- [Playbooks](#playbooks)
  - [Target](#target)
  - [Vault](#vault)
- [Roles](#roles)
  - [update-pi](#update-pi)
  - [config-pi](#config-pi)
  - [duckdns-pi](#duckdns-pi)
  - [unifi-controller](#unifi-controller)


Introduction
============

I always take notes. I meticulously craft copy/paste commands for each thing I install and configure, commenting each line and/or block, describe which parts I need to edit before executing in a console. It's a form of automation really, a whole lot of bash code.  
I have notes on how to handle disk paritioning, voume management and formatting from 15 years ago, how to configure exim or postfix, how to cluster and partition MySQL and Postgres, setup OpenLDAP and 389DS, configuring and troubleshootinng BGP and OSPF on Cisco devices, securing/hardening different Linux distros, setting up a MQTT broker, how to do all sorts of home automation with Home Assistant, how to write Alexa skills, Git, Docker.... I can go on for a few pages like this :) Needles to say, it's a decent knowledge base with focus on reusability. 

Some years ago I discovered Ansible, which provided me with a new and more powerfull form of reusability. I've done a lot of it, mostly professionally, which is why I can't share.  
This project is my effort to find the time (yes, time is the main culprit in this story) to automate and simplify the management of a Raspberry Pi's for different use cases, from CIFS shares to Home Assistant. The goal is to have everything described in code with easily configurable inputs that will allow us to configure the Pi in a modular fashion, easily add new functionality or configuration pieces and bring a fresh Pi to the desired state.  


Prerequisites
=============
* Git
* Ansible 2.7+

How-To install Ansible on Raspberry Pi
--------------------------------------

I recommend always running the latest version of Ansible. The following copy/paste instructions should work on any Raspbian/Debian based system:

```bash
# Install latest Ansible from source (run as root)
apt update

# Install dependecies
apt install make git make gcc python-setuptools python-dev libffi-dev libssl-dev ieee-data libyaml-0-2 python-paramiko python-jinja2 python-httplib2 python-jinja2 python-kerberos python-markupsafe python-netaddr python-paramiko python-selinux python-xmltodict python-yaml python-crypto python-pkg-resources python-apt python3-apt python-pip

apt install $(apt-cache depends ansible | grep Depends | grep -v python:any | sed "s/.*ends:\ //" | tr '\n' ' ')

# Fetch the latest Ansible code
cd /opt
git clone git://github.com/ansible/ansible.git --recursive
cd ./ansible

# Checout the latest stable branch
git checkout $(git branch -a | grep stable | tail -n 1 | cut -d'/' -f 3)

# Install python dependencies
pip install -r ./requirements.txt
pip install packaging

# Compile and install Ansible
source ./hacking/env-setup
make
make install

# Check
ansible --version
```


Playbooks 
=========

Playbooks are executable and can be run without invoking `ansible-playbook`, just run
```bash
./playbook.yml
```

Target
------

You will prmopted to enter the "target host", against which the playbook will run. You should define all hosts in the Ansible inventory (See the `inventory-examples.yml`)  
The target host can be povided on the command line using the `target` variable, for example  
```bash
./playbook.yml -e target=MyPi
./playbook.yml -e target=192.168.1.101
```
Use the provided `local` host definition to run a playbook directly on Raspberry Pi
```bash
./playbook.yml -e target=local
```

Vault
-----
 
Some playbooks will expect a `<target>.vault.yml` file. The idea is to store all your private data (configuraiton variables, credentials, etc.) needed to configure and run your Raspberry Pi in a single encrypted file, which the playbook will load based on the target host you are provisioning and override the default variables from the roles. (See the `MyPi.vault-example.yml`)  
You can provide a different vault file using the `vault` variable, for example
```bash
./playbook.yml -e target=MyPi vault=secrets.vault.yml
```
> You can bypas the vault file by remove the include_vars task from the playbook or providing an empty vault file


Roles
=====

update-pi
---------
Update and upgrade Raspbian, clean up after upgrading, restart any services if needed and notify if reboot is neded  
[See the README.md for more information](./roles/update-pi/README.md)

config-pi
---------
Basic Rasbian OS configuration, system hardening, standard packages installation, etc. See the Role Variables and Tags serction for more informaiton.  
[See the README.md for more information](./roles/config-pi/README.md)

duckdns-pi
----------
Configure Duck DNS on your Raspberry Pi, a free dynamic DNS service  
[See the README.md for more information](./roles/duckdns-pi/README.md)


unifi-controller
----------------
Install and Configure UniFi Controller   
*NOTE*: Installs MongoDB and Oracle Java as dependencies  
[See the README.md for more information](./roles/unifi-controller/README.md)