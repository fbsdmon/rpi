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
  - [letsencrypt-pi](#letsencrypt-pi)
  - [mariadb-pi](#mariadb-pi)
  - [mosquitto-pi](#mosquitto-pi)
  - [unifi-controller](#unifi-controller)


Introduction
============

This project is my effort to find the time (yes, time is the main culprit in this story) to automate and simplify the management of a Raspberry Pi's for different use cases, from system hardening, to MySQL management, CIFS shares, to setting up Home Assistant and alike. The goal is to have everything described in code with easily configurable inputs that will allow us to configure the Raspberry Pi in a modular fashion, easily add new functionality or configuration pieces, and bring a fresh Pi to the desired state.  


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

All playbooks will prmopted you to enter the "target host", against which the playbook will run. You should define all targets (hosts/groups) in the Ansible inventory (See the `inventory-examples.yml`)  
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
For more information please check the [update-pi README.md](./roles/update-pi/README.md)

config-pi
---------
Basic Rasbian OS configuration, system hardening, standard packages installation, etc. See the Role Variables and Tags serction for more informaiton.  
For more information please check the [confing-pi](./roles/config-pi/README.md)

duckdns-pi
----------
Configure Duck DNS on your Raspberry Pi, a free dynamic DNS service  
For more information please check the [duckdns-pi README.md](./roles/duckdns-pi/README.md)

letsencrypt-pi
--------------

[Let’s Encrypt](https://letsencrypt.org/) is a free, automated, and open certificate authority. The `letsencrypt-pi` role will install CertBot, obtain a free certificate for your domain and setup an automated renewal process.  
For more information please check the [letsencrypt-pi README.md](./roles/letsencrypt-pi/README.md)

mariadb-pi
--------------

[MariaDB](https://go.mariadb.com/) is a free relational database management system (RDBMS) which is a MySQL (fork) drop-in replacement. The `mariadb-pi` role will install, configure and harden MariaDB + add databases and users.  
For more information please check the [mariadb-pi README.md](./roles/mariadb-pi/README.md) 

mosquitto-pi
--------------

[Mosquitto](https://mosquitto.org/) is an open source message broker that implements the MQTT protocol versions 3.1 and 3.1.1. The `mosquitto-pi` role will install and configure Mosquitto with resonable defaults, including user authentication, as well as  allow you to easilty extend the configuraton.  
For more information please check the [mosquitto-pi README.md](./roles/mamosquittoriadb-pi/README.md) 


unifi-controller
----------------
Install and Configure UniFi Controller   
*NOTE*: Installs MongoDB and Oracle Java as dependencies  
For more informatin please check the [unifi-controller README.md](./roles/unifi-controller/README.md)