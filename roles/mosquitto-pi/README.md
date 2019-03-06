mosquitto-pi
============

Mosquitto is an open source (EPL/EDL licensed) message broker that implements the MQTT protocol versions 3.1 and 3.1.1. Mosquitto is lightweight and is suitable for use on all devices from low power single board computers to full servers. The MQTT protocol provides a lightweight method of carrying out messaging using a publish/subscribe model. This makes it suitable for Internet of Things messaging such as with low power sensors or mobile devices such as phones, embedded computers or microcontrollers.  
For more information visit [Mosquitto](https://mosquitto.org/)

This role installs Mosquitto and configures it with reasonable defaults, including user authentication. It can also configure ssl/tls connectivity, but most importanlty, it allows you to easily introduce new Mosquitto configuration by extending the config dicts.

Requirements
------------

* Ansible 2.7 or above
* Internet access

Role Variables
--------------

* `mosquitto_config` You can add any key:value pair that is supported by mosquitto (https://mosquitto.org/man/mosquitto-conf-5.html)
  * `allow_anonymous` Allow clients to connect without providing a username (Defaut: false)
  * `allow_duplicate_messages` Send only one message to clients that are subscribed to overlapping subscriptions (Default: true)
  * `allow_zero_length_clientid` Allow clients to connect with a zero length client id and have the broker generate a client id for them (Default: true)
  * `autosave_interval` If persistance is enabled, AutoSave the mosquotto.db every N seconds to disk (Default: 60)
  * `autosave_on_changes` AutoSave if the number of changes (subscription changes, retained messages, received and queued messages) exceedes autosave_interval (Defailt: False)
  * `log_timestamp` Add timestamp to each log entry (Default: true)
  * `log_type` List of messages types to log: debug, error, warning, notice, information, subscribe, unsubscribe, websockets, none, all.
  * `max_queued_messages` Maximum number of QoS 1 or 2 messages to hold in the queue (per client) above those messages that are currently in flight (Default: 200)
  * `message_size_limit` Maximum publish payload size that the broker will allow (Default: 0)
  * `password_file` Credentials store for controling client access to the broker (Default: /etc/mosquitto/passwd) 
  * `persistence` Perist connection, subscription and message data in mosquitto.db
* `mosquitto_port` Mosquito port (Default: 1883)
* `mosquitto_address` Mosquito bind address (Default: 0.0.0.0) 
* `mosquitto_port_ssl` Mosquito port for SSL/TLS connections (Default: 8883) **NOTE**: mosquitto_port will be used if SSL/TLS is configured and mosquitto_port_ssl is not defined
* `mosquitto_address_ssl` Mosquito bind address for SSL/TLS connections (Default: 0.0.0.0)
* `mosquitto_cert_config` Certificate based SSL/TLS configuration
  * `cafile` PEM encoded CA certificates that are trusted
  * `certfile` PEM encoded server certificate
  * `keyfile` PEM encoded keyfile
  * `require_certificate` Require client certificate (Default: false)
* `mosquitto_users` Dictionary of usernames and passowrds (user: pass)
* `mosquitto_force_password_change` Force update user passwords (Default: false)


Role Tags
--------------

* `mosquitto_install` Install Mosquitto
* `mosquitto_configure` Configure Mosquitto
* `mosquitto_users` Configure Mosquitto Users

Dependencies
------------

None

Example Playbook
----------------

```yaml
- name:
  hosts: MyPi
  become: yes
  roles:
    - role: mosquitto-pi
      mosquitto_config:
        allow_anonymous: false
        allow_duplicate_messages: true
        allow_zero_length_clientid: true
        autosave_interval: 60
        autosave_on_changes: false
        log_timestamp: true
        log_type:
        - error
        - warning
        - notice
        - information
        max_queued_messages: 200
        message_size_limit: 0
        persistence: true
      mosquitto_port: 1883
      mosquitto_address: 192.168.0.100
      mosquitto_port_ssl: 8883
      mosquitto_address_ssl: 0.0.0.0
      mosquitto_cert_config:
        cafile: /etc/letsencrypt/live/{{ ansible_fqdn }}/chain.pem
        certfile: /etc/letsencrypt/live/{{ ansible_fqdn }}/cert.pem
        keyfile: /etc/letsencrypt/live/{{ ansible_fqdn }}/privkey.pem
        require_certificate: false
      mosquitto_users: 
        mqtt_user1: Passw0rd
        mqtt_user2: s3crEt
      mosquitto_force_password_change: true

License
-------

GPL v3

Author Information
------------------

[Perica Veljanovski](mailto:fBSDmon@gmail.com)