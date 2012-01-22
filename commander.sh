#!/bin/bash
keypath=
certpath=
pemPath=
java_home=
ssh_user=

export EC2_HOME=$apitoolspath
export JAVA_HOME=$java_home

command=$1

echo 'Executing command *' $command '* on all server instances'
servers=`$apitoolspath/bin/ec2-describe-instances --filter root-device-type=ebs -K $keypath -C $certpath | awk '($1=="INSTANCE") {print $4}'`
servers=$servers

for i in $(echo $servers | tr " " "\n")
do
    echo "Executing command on "$i
    echo ""
    ssh -i $pemPath $ssh_user@$i "$command"
    echo ""
done
