#!/usr/bin/bash

#Assignment of variables    
CONSUL_HTTP_TOKEN=$1

#Assigning bootstrap token to CONSUL_HTTP_TOKEN
export CONSUL_HTTP_TOKEN=$CONSUL_HTTP_TOKEN

#Add node list policy for Anonymous Token
/usr/local/bin/consul acl policy create -name 'list-all-nodes' -rules 'node_prefix "" { policy = "read" }'
/usr/local/bin/consul acl token update -id 00000000-0000-0000-0000-000000000002 -policy-name list-all-nodes -description "Anonymous Token"

#Add consul service policy for Anonymous Token
/usr/local/bin/consul acl policy create -name 'service-consul-read' -rules 'service "consul" { policy = "read" }'
/usr/local/bin/consul acl token update -id 00000000-0000-0000-0000-000000000002 --merge-policies -description "Anonymous Token" -policy-name service-consul-read

#Add vault service policy for Anonymous Token
/usr/local/bin/consul acl policy create -name 'service-vault-read' -rules 'service "vault" { policy = "read" }'
/usr/local/bin/consul acl token update -id 00000000-0000-0000-0000-000000000002 --merge-policies -description "Anonymous Token" -policy-name service-vault-read
