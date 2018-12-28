rpi
===
Manage Raspberry Pi with Ansible


Introduction
------------

I always take notes. I meticulously craft copy/paste commands for each thing I install and configure, commenting each line and/or block, describe which parts I need to edit before executing in a console. It's a form of automation really, a whole lot of bash code.  
I have notes on how to handle disk paritioning, voume management and formatting from 15 years ago, how to configure exim or postfix, how to cluster and partition MySQL and Postgres, setup OpenLDAP and 389DS, configuring and troubleshootinng BGP and OSPF on Cisco devices, securing/hardening different Linux distros, setting up a MQTT broker, how to do all sorts of home automation with Home Assistant, how to write Alexa skills, Git, Docker.... I can go on for a few pages like this :) Needles to say, it's a decent knowledge base with focus on reusability. 

Some years ago I discovered Ansible, which provided me with a new and more powerfull form of reusability. I've done a lot of it, mostly professionally, which is why I can't share.  
This project is my effort to find the time (yes, time is the main culprit in this story) to automate and simplify the management of a Raspberry Pi's for different use cases, from CIFS shares to Home Assistant. The goal is to have everything described in code with easily configurable inputs that will allow us to configure the Pi in a modular fashion, easily add new functionality or configuration pieces and bring a fresh Pi to the desired state.  


Prerequisites
-------------
* Git
* Ansible 2.7+

#### How-To install Ansible on Raspberry Pi

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
---------

Playbooks are executable and can be run without invoking `ansible-playbook`, just run
```
./playbook.yml
```
By default, all playbooks will run against the the `MyPi` host/group (See the `inventory-examples.yml` for more information). You can execute a playbook against any host/group in the inventory using the `target` variable like this
```
./playbook.yml -e target=<my host or group>
```

Use the provided `local` host definition to run a playbook directly on Raspberry Pi
```
./playbook.yml -e target=local
```

> Some playbooks require the `secrets.vault.yml` which holds all my private data (settings, credentials, etc) and overrides the default values in the roles. You can remove the include_vars pre_tasks from the playbook, empty out the secrets file or setup your own secrets.


Roles
-----

#### update-pi
Update and upgrade Raspbian, clean up after upgrading, restart any services if needed and notify if reboot is neded
[See the README.md for more information](./master/roles/config-pi/README.md)

#### config-pi
Basic Rasbian OS configuration, system hardening, standard packages installation, etc. See the Role Variables and Tags serction for more informaiton.

