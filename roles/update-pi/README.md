update-pi
==========

Upgrade Raspbian (Raspberry Pi):
* Erase old downloaded archive files (autoclean)
* Remove automatically all unused packages (autoremove)
* Remove packages and config files (purge)
* Check and restart srvices after library updates
* Prompt if reboot is needed

Requirements
------------

* Ansible 2.4 or above
* Internet access

Role Variables
--------------

* `autoclean` Erase old downloaded archive files (default: true)
* `autoremove` Remove automatically all unused packages (default: true)
* `purge` Remove packages and config files (default: true)


Example Playbook
----------------

```yaml
- name: Update and Upgrade Raspbian
  hosts: MyPi
  become: yes
  roles:
    - role: update-pi  
        autoclean: false
        autoremove: false
        purge: false
```

License
-------

GPL v3

Author Information
------------------

fBSDmon@gmail.com
