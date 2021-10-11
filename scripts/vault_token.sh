#!/usr/bin/bash

#Assignment of variables    
CONSUL_HTTP_TOKEN=$1

#Assigning bootstrap token to CONSUL_HTTP_TOKEN
export CONSUL_HTTP_TOKEN=$CONSUL_HTTP_TOKEN

cd /etc/vault.d

#Creating ACL and token for Vault
/usr/local/bin/consul acl policy create -name vault-policy -rules @vault_acl.json
/usr/local/bin/consul acl token create -description "Vault administrative token" -policy-name "vault-policy" > /home/ansible/vault_token.log