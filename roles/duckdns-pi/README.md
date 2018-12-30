DuckDNS-Pi
==========

Configure Duck DNS on your Raspberry Pi, a free dynamic DNS service  
More info here https://www.duckdns.org/


Requirements
------------

* Ansible 2.7+


Role Variables
--------------
  
* `duckdns_subdomain` The duckdns.org subdomain you want to update (default: MyPi)
* `duckdns_token` Your DuckDNS account token


Dependencies
------------

None


Example Playbook
----------------

```yaml
- name: Configure DuckDNS
  hosts: MyPi
  become: yes
  roles:
    - role: duckdns-pi  
        duckdns_subdomain: MyPi
        duckdns_token: a7c4d0ad-114e-40ef-ba1d-d217904a50f2
```


License
-------

GPL v3


Author Information
------------------

[Perica Veljanovski](mailto:fBSDmon@gmail.com)
