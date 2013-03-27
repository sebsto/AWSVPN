#to be run on my laptop


# create and start an instance
#AMI = AMZN Linux 64 Bits
#AMI_DESCRIPTION="amazon/amzn-ami-pv-2013.03.0.x86_64-ebs"
AMI_ID=ami-44939930
KEY_ID=sst-ec2
SEC_ID=VPN
BOOTSTRAP_SCRIPT=vpn-ec2-install.sh 

echo "Starting Instance..."
INSTANCE_DETAILS=`$EC2_HOME/bin/ec2-run-instances $AMI_ID -k $KEY_ID -t t1.micro -g $SEC_ID -f $BOOTSTRAP_SCRIPT | grep INSTANCE`
echo $INSTANCE_DETAILS

AVAILABILITY_ZONE=`echo $INSTANCE_DETAILS | awk '{print $9}'`
INSTANCE_ID=`echo $INSTANCE_DETAILS | awk '{print $2}'`
echo $INSTANCE_ID > $HOME/vpn-ec2.id 

# wait for instance to be started
DNS_NAME=`$EC2_HOME/bin/ec2-describe-instances --filter "image-id=$AMI_ID" --filter "instance-state-name=running" | grep INSTANCE | awk '{print $4}'`

while [ -z "$DNS_NAME" ]
do
    echo "Waiting for instance to start...."
    sleep 5
    DNS_NAME=`$EC2_HOME/bin/ec2-describe-instances --filter "image-id=$AMI_ID" --filter "instance-state-name=running" | grep INSTANCE | awk '{print $4}'`
done

echo "Instance started"

echo "Instance ID = " $INSTANCE_ID
echo "DNS = " $DNS_NAME " in availability zone " $AVAILABILITY_ZONE


