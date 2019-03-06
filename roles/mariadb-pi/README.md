mariadb-pi
==========

Install, configure and harden MariaDB + add databases and users

Requirements
------------

* Ansible 2.7 or above
* Internet access

Role Variables
--------------

* `mariadb_datadir` MariaDB datadir/storage (default: /var/lib/mysql) **NOTE**: Any existing data will be moved to the new location
* `mariadb_bind_address` MariaDB bind address (default: 127.0.0.1)
* `mariadb_bind_port` MariaDB bind port (default: 3306)
* `mariadb_server_config` MariaDB server configuration file (default: /etc/mysql/mariadb.conf.d/50-server.cnf)
* `mariadb_force_reset_root_pass` Force cahnge the root passowrd (default: False) **NOTE**: The root password is randomly generated and stored under /root/.my.cnf
* `mariadb_databases` List of databases to be created (default encoding: utf8mb4) **NOTE**: Changing the encoding will not chage the encoding on a existing database
* `mariadb_users` List of users to be created (default location: localhost) **NOTE**: changing the host will create another user

Role Tags
--------------

* `mariadb_install` Install MariaDB only
* `mariadb_harden` Harden MariaDB only
* `mariadb_databases` Setup a default bash resource script for all users
* `mariadb_users` Set the timezone


Dependencies
------------

Dependencies will be installed automatically


Example Playbook
----------------

```yaml
- name:
  hosts: MyPi
  become: yes
  roles:
    - role: mariadb-pi
      mariadb_bind_address: 0.0.0.0
      mariadb_force_reset_root_pass: true
      mariadb_databases:
        - name: database1
          encoding: utf8mb4
        - name: database2
        - name: database3
          encoding: latin1
      mariadb_users:
        - name: user1
          host: localhost
          password: S3cr3t1
          priv: 'database1.*:ALL'
        - name: user2
          host: mypi.duckdns.org
          password: S3cr3t2
          priv: '*.*:ALL,GRANT'
        - name: replication
          password: S3cr3t3
          priv: '*.*:REPLICATION CLIENT'
        - name: user3
          password: S3cr3t4
          priv: 'database1.*:INSERT,UPDATE/database2.*:SELECT/database3.*:ALL'

```

License
-------

GPL v3

Author Information
------------------

[Perica Veljanovski](mailto:fBSDmon@gmail.com)
