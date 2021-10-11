Hashicorp vault & consul cluster
================================


Installs & configures Hashicorp's Consul & Vault + HAProxy to run as an HA cluster

### Symbolic representation overview of deployment
![Vault-Consul-Cluster](https://user-images.githubusercontent.com/32331362/136788224-49d37bbd-3ae2-412c-8090-d8791171b9c3.jpg)


Configured software and tools
------------
* Consul 1.10.3
* Vault 1.8.2
* HAProxy 2.0.7
* Keepalived 1.3.5


Basic settings
------------
* Vault use Consul as storange backend 
* ACL is activated in Consul
* Vault is connected to the consul via ACL
* Bootstrap and unseal keys are stored in the /home/ansible folder on the remote machines
* HTTPS protocol is activated for Haproxy VIP IP


Currently tested on these Operating Systems
* Linux/RHEL/CentOS 7

Requirements
------------
* Ansible 2.11.5

Dependencies
------------
* Requires elevated root privileges
* Copy Ansible control machine user's public SSH key (usually called id_rsa.pub) into the remote machines working directory
* Add hosts address and names for VMs : hosts


Running the deployment
----------------------

On the Ansible Control Machine  

__To deploy__

`./scripts/deploy.sh`


Author Information
------------------

Samir Nabadov

