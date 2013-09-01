#to be run on my laptop


# create and start an instance
#AMI = AMZN Linux 64 Bits
#As of 1 sept 2013, the 64 Bits AMZN Linux AMI are
#"Mappings": {
#       "AWSRegionToAMI": {
#           "us-east-1": { "AMI": "ami-05355a6c" },
#           "us-west-2": { "AMI": "ami-0358ce33" },
#           "us-west-1": { "AMI": "ami-3ffed17a" },
#           "eu-west-1": { "AMI": "ami-c7c0d6b3" },
#           "ap-southeast-1": { "AMI": "ami-fade91a8" },
#           "ap-northeast-1": { "AMI": "ami-39b23d38" },
#           "ap-southeast-2": { "AMI": "ami-d16bfbeb" },
#           "sa-east-1": { "AMI": "ami-5253894f" }
#       }

AMI_ID=ami-c7c0d6b3 #must be adapted to your region
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


