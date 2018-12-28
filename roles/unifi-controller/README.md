Role Name
=========

Install and Configure UniFi Controller   
*NOTE*: Installs MongoDB and Oracle Java as dependencies


Role Variables
--------------

* `unifi_repo` UniFi repository
* `unifi_repo_gpg_key` GPG Key for the UniFi repository
* `jvm_init_heap` Java Virtual Machine initial heap size
* `jvm_max_heap`  Java Virtual Machine maximum heap size


Dependencies
------------

* MongoDB 
* Oracle Java

Example Playbook
----------------

```yml
- name: Install and Configure UniFi Controller
  hosts: pies
  become: yes
  roles:
    - role: unifi-controller
      unifi_repo: "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti"
      unifi_repo_gpg_key: C0A52C50
      jvm_max_heap: 256M
      jvm_init_heap: 128M
```

License
-------

GPL v3

Author Information
------------------

fBSDmon@gmail.com
