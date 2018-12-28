config-pi
=========

Basic Rasbian OS configuration, system hardening, standard packages installation, etc. See the Role Variables and Tags serction for more informaiton.

Requirements
------------

* Ansible 2.7 or above
* Internet access

Role Variables
--------------

* `hostname` System hostname (default: MyPi)
* `domain` Domain-part of the hostname (default: duckdns.org)
* `fqdn` The Fully Qualified Domain Name (defaults: hostname.domain)
* `timezone` Set the timezone (default: Europe/Berlin)
* `umask` The default umask for all users (default: 0007)
* `disable_ipv6` Disables IPv6 in kernel (default: false)
* `disable_wifi` Disable WiFi in kernel (default: false)
* `disable_bluetooth` Disable Bluetooth in kernel (default: false)


Role Tags
--------------

* `hostname` Configure the hostname and hosts file
* `motd` Set the login banner
* `timezone` Set the timezone
* `bashrc` Setup a default bash resource script for all users
* `harden` Run system hardening tasks
  * `swappienss` Set swappiness to 0
  * `core_dumps` Disable core dumps
  * `remove_users` Remove default users
  * `umask` Set the default umask for all users
* `blacklist` Run the kernel module blacklisting tasks
* `packages` Install/Remove packages

Dependencies
------------

None

Example Playbook
----------------

```yaml
- name: Configure Raspberry Pi
  hosts: MyPi
  become: yes
  roles:
    - role: config-pi  
        hostname: MyNewPi
        disable_bluetooth: true
```

License
-------

GPL v3

Author Information
------------------

fBSDmon@gmail.com
