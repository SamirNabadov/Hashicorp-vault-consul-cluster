#!/usr/bin/bash

#Deploying Consul + Vault + HAProxy + Keepalived

#Assignment of variables        
SECONDS=0
project_dir=$(pwd)
host_path=$project_dir/hosts
haproxy_var_path=$project_dir/ansible-haproxy/defaults/main.yml
haproxy_vip_ip=$(awk '{if(NR==3) print $0}' $host_path)
haproxy_subnet=$(echo $haproxy_vip_ip| sed 's/\.[0-9]*$/./')

#Replacing IP and subnet address in default parameters haproxy role
sed -i "s/ka_base_ip:.*/ka_base_ip: '$haproxy_subnet'/" $haproxy_var_path
sed -i "s/ka_vip:.*/ka_vip: '$haproxy_vip_ip'/" $haproxy_var_path

# Installing and configuring Consul
ansible-playbook consul.yml -i hosts
if [ $? -eq 0 ];
then
    echo "Consul Configured!"
else
    echo "Failed!"
    exit 1
fi

# Installing and configuring Vault
ansible-playbook vault.yml -i hosts
if [ $? -eq 0 ];
then
    echo "Vault Configured!"
else
    echo "Failed!"
    exit 1
fi

# Installing and configuring Haproxy and Keepalived
ansible-playbook haproxy.yml -i hosts
if [ $? -eq 0 ];
then
    echo "Haproxy Configured!"
else
   echo "Failed!"
    exit 
fi

echo "Time spent configuring Environment: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo "---------------------------------------"
echo "Vault & Consul cluster has been successfully configured!"


