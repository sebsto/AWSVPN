#!/bin/bash -x
#to be run on my laptop


# create and start an instance
#AMI = AMZN Linux 64 Bits
#As of 24 dec 2013, the 64 Bits AMZN Linux AMI are
#"Mappings": {
#        "AWSRegionToAMI": {
#            "us-east-1": { "AMI": "ami-bba18dd2" },
#            "us-west-2": { "AMI": "ami-ccf297fc" },
#            "us-west-1": { "AMI": "ami-a43909e1" },
#            "eu-west-1": { "AMI": "ami-5256b825" },
#            "ap-southeast-1": { "AMI": "ami-b4baeee6" },
#            "ap-northeast-1": { "AMI": "ami-0d13700c" },
#            "ap-southeast-2": { "AMI": "ami-5ba83761" },
#            "sa-east-1": { "AMI": "ami-c99130d4" },
#            "us-gov-west-1": { "AMI": "ami-97fb9fb4" }
#        }
#    }

AMI_ID=ami-5256b825 #must be adapted to your region (Amazon Linux, PV, 64 Bits, 2013.09.02, eu-west)
KEY_ID=sst-aws
SEC_ID=VPN
BOOTSTRAP_SCRIPT=vpn-ec2-install.sh 

echo "Starting Instance..."
INSTANCE_DETAILS=`aws ec2 run-instances --image-id $AMI_ID --key-name $KEY_ID --security-groups $SEC_ID --instance-type t1.micro --user-data file://./$BOOTSTRAP_SCRIPT --output text | grep INSTANCES`

INSTANCE_ID=`echo $INSTANCE_DETAILS | awk '{print $8}'`
echo $INSTANCE_ID > $HOME/vpn-ec2.id 

# wait for instance to be started
STATUS=`aws ec2 describe-instance-status --instance-ids $INSTANCE_ID --output text | grep INSTANCESTATUS | grep -v INSTANCESTATUSES | awk '{print $2}'`

while [ "$STATUS" != "ok" ]
do
    echo "Waiting for instance to start...."
    sleep 5
    STATUS=`aws ec2 describe-instance-status --instance-ids $INSTANCE_ID --output text | grep INSTANCESTATUS | grep -v INSTANCESTATUSES | awk '{print $2}'`
done

echo "Instance started"

echo "Instance ID = " $INSTANCE_ID
DNS_NAME=`aws ec2 describe-instances --instance-ids $INSTANCE_ID --output text | grep INSTANCES | awk '{print $15}'`
AVAILABILITY_ZONE=`aws ec2 describe-instances --instance-ids $INSTANCE_ID --output text | grep PLACEMENT | awk '{print $2}'`
echo "DNS = " $DNS_NAME " in availability zone " $AVAILABILITY_ZONE


