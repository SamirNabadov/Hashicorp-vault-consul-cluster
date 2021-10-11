Hashicorp vault & consul cluster
================================

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Installs & configures Hashicorp's Consul & Vault + HAProxy to run as an HA cluster

>__Note__: *Please see [this repo](https://github.com/AdamGoldsmith/cloud-gitlab) for a similar project that uses the latest integrated storage backend made available in Vault 1.4 release, removing the need for a Consul-based backend storage deployment*

### Symbolic representation overview of deployment
![Alt text](images/Vault-Consul-Cluster.jpg "Overview of deployment")

### Consul UI Dashboard
[![Alt text](images/Consul-Vault-UI.jpg "Consul UI Dashboard")](https://www.consul.io/docs/index.html)

Although the vault installation creates OpenSSL TLS private key, CSR & resultant certificate, the URI modules in these roles currently use "validate_certs: no". It is up to you to complete the TLS configuration.

> __WARNING__ - When vault is initialized, the master key shards & root token are stored in the ansible user's HOME dir on the Ansible control machine. This is __NOT__ good practice, but was used to get things running. I am considering various future options that won't break the non-interactive execution of the playbooks, such as ansible vault'ing the file with a pre-defined ansible vault password file. But this is really no more secure than the current setup. Hashicorp vault has the ability to encrypt the master key shards using [PGP, GPG, and Keybase](<https://www.vaultproject.io/docs/concepts/pgp-gpg-keybase.html>). This is the ideal solution but might prove too difficult to implement while maintaining non-interactive playbook execution.

Heavily based on the documentation supplied by HashiCorp at <https://www.vaultproject.io/guides/operations/vault-ha-consul.html>

Currently tested on these Operating Systems
* Oracle Linux/RHEL/CentOS 7 (Note: Enables EPEL repo using Jeff Geerling's [EPEL role](<https://galaxy.ansible.com/geerlingguy/repo-epel/>))
* Debian/Stretch64

Requirements
------------

* Hashicorp Vagrant
* Ansible 2.5 or higher

Dependencies
------------

* Requires elevated root privileges
* Copy Ansible control machine user's public SSH key (usually called id_rsa.pub) into the vagrant working directory

Getting the code
----------------

`git clone https://github.com/AdamGoldsmith/consul-vault.git --recurse-submodules`

Running the deployment
----------------------

```
cd vagrant
export BOX_NAME="centos/7"     # Optional (defaults to debian/stretch64)
vagrant up
```

On the Ansible Control Machine  

__To deploy__

`./deploy.sh`

or

`ansible-playbook playbooks/site.yml`

__To remove__

`./deploy.sh -t remove`

or

`ansible-playbook playbooks/site.yml --tags 'remove'`

[![asciicast](https://asciinema.org/a/dhB4noDm88CdISBGAUGonetAv.png)](https://asciinema.org/a/dhB4noDm88CdISBGAUGonetAv?autoplay=1&size=small&cols=140&rows=40)

Known Issues
------------

* __deploy.sh__

The `deploy.sh` script has been updated to use `/bin/bash` which might not be universally available on your system so you may need to update this to use the shell of your choice.

* __PyOpenSSL__

If you get the message "You need to have PyOpenSSL>=0.15 to generate CSRs", then it is most likely an issue with the OpenSSL package that python has imported. When pyOpenSSL is installed/upgraded via the PIP Ansible module in this playbok, it will install the python package under /usr/lib/pythonx.x/site-packages, however it is possible that another OpenSSL python package could be installed under /usr/lib64/pythonx.x/site-packages that is being loaded in preference to the higher-level package.  
In order to prevent this happening, temporarily move the directory "/usr/lib64/pythonx.x/site-packages/OpenSSL" out of the way while running this playbook.  

License
-------

MIT License

Author Information
------------------

Adam Goldsmith

