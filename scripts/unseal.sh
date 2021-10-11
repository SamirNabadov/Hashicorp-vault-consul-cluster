#!/bin/bash

#Assignment of variables    
vault_host=$(hostname -I | sed -r 's/( )+//g')
key_path='/home/ansible/keys.log'

# Fetching first three keys to unseal the vault
KEY_1=$(cat $key_path | grep 'Unseal Key 1' | awk '{print $4}')
KEY_2=$(cat $key_path | grep 'Unseal Key 2' | awk '{print $4}')
KEY_3=$(cat $key_path | grep 'Unseal Key 3' | awk '{print $4}')

# Unseal vault
/usr/local/bin/vault operator unseal -address=http://$vault_host:8200 $KEY_1
/usr/local/bin/vault operator unseal -address=http://$vault_host:8200 $KEY_2
/usr/local/bin/vault operator unseal -address=http://$vault_host:8200 $KEY_3
