letsencrypt-pi
==============

[Let’s Encrypt](https://letsencrypt.org/) is a free, automated, and open certificate authority. The `letsencrypt-pi` role will install CertBot, obtain a free certificate for your domain and setup an automated renewal process.


> **IMPORTANT**  
> This CertBot implementation uses the Let's Encrypt HTTP-01 challenge method and listens on port 80 by default. The Let's Encrypt servers must be able to connect to CertBot on port 80 in order to validate your request (ownership of the domain) and issue/renew your certificate.  
> You can cahnge the port on which CertBot is listening on usin the `letsencrypt_port` variable, but you have to configure port-forwarding on your router, as the Let's Encrypt servers must still be able to connect via port 80.


Introduction to Let's Encrypt
-----------------------------

The objective of Let’s Encrypt and the ACME protocol is to make it possible to set up an HTTPS server and have it automatically obtain a browser-trusted certificate, without any human intervention. This is accomplished by running a certificate management agent on the web server.  
There are two steps to this process. First, the agent proves to the CA that the web server controls a domain. Then, the agent can request, renew, and revoke certificates for that domain.

The process is explained in more detail here https://letsencrypt.org/how-it-works/

#### ACME

The Automatic Certificate Management Environment (ACME) protocol is a communications protocol for automating interactions between certificate authorities and their users' web servers, allowing the automated deployment of public key infrastructure at very low cost. It was designed by the Internet Security Research Group (ISRG) for their Let's Encrypt service.

#### ACME challenge types

* The HTTP-01 challenge requires that the public Internet be able to connect to http://:80$HOSTNAME, for each $HOSTNAME you request a cert for. The --http-01-port flag will let certbot listen on a different port, in case you have port forwarding, a reverse proxy, or some other such thing going on, but the Let’s Encrypt servers must still be able to connect via port 80.
* The TLS-SNI challenge requires that the public Internet be able to connect to port 443 on $HOSTNAME. As above, you can specify that certbot listen on a different port, but the Let’s Encrypt servers will connect to port 443.
* The DNS-01 challenge requires that you be able to add TXT DNS records for each requested hostname, ideally through an API or some automated mechanism.


Requirements
------------

* Ansible 2.7 or above
* Internet access
* Port forwarding on your router

Role Variables
--------------

* `letsencrypt_fqdn` Domain (fqdn) for which you want to obtain a certificate (default: MyPi.duckdns.org)
* `letsencrypt_port` CertBot listening port (default: 80)
* `letsencrypt_email` Account (e-mail) under which your domain(s) will be registered


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
    - role: letsencrypt-pi
        letsencrypt_fqdn: "www.example.com"
        letsencrypt_email: your@email.com
        letsencrypt_port: "8080"
        
```

License
-------

GPL v3

Author Information
------------------

[Perica Veljanovski](mailto:fBSDmon@gmail.com)
