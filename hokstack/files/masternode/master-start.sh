#!/bin/bash
sed -i "s/hostname=localhost/hostname=$AMBARISERVER/" /etc/ambari-agent/conf/ambari-agent.ini
ambari-agent start
    
curl -i -H "X-Requested-By: ambari" -u admin:admin -X POST -d @/scripts/masternode-hostgroup.json http://$AMBARISERVER:8080/api/v1/clusters/$NAMESPACE/hosts/$PODNAME.$NAMESPACE
    
/etc/init.d/sshd start

while true; do
    sleep 3
    tail -f /var/log/ambari-agent/ambari-agent.log
done