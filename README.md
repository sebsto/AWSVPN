AWSVPN
======

License
-------

Licensed under the BSD 3 Clauses License (http://opensource.org/licenses/BSD-3-Clause)

Distributed on an "AS IS" basis without warranties or conditions of any kind, either express or implied.

Known Issue
-----------

Modify the startup script to adapt to the AMI ID available in your region

How To ?
--------
  
Start a private VPN server in the cloud. 

- vpn-ec2-start script is run from your computer.  It starts a machine on EC2
- vpn-ec2-install script will be run from AWS' EC2 instance to setup VPN
- vpn-ec2-terminate script is run from your computer to terminate (shutdown) the VPN server

THESE SCRIPTS MUST BE MODIFIED TO RUN IN YOUR ENVIRONMENT - PLEASE READ BELOW

The vpn-ec2-start script requires AWS CLI command line interface.
- Intallation instructions : http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html
- Configuration Instructions : http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

Here is an example of my $HOME/.aws/config
```bash
[default]
aws_access_key_id = AK..OQ
aws_secret_access_key = gj...T8
region = eu-west-1```

You also need the following 

- an account on AWS EC2 :-)
- to define a ssh key pair in AWS console (or through the command line)
- to define an AWS Security Group with the following rules :
  - TCP 500 0.0.0.0/0
  - UDP 500 0.0.0.0/0
  - UDP 4500 0.0.0.0/0

vpn-ec2-start.sh must be modified 

- KEY_ID : change the name of the ssh key pair (line 9)
- SEC_ID : change the name of the Security Group (line 10)

vpn-ec2-install.sh must be modified to include your VPN credentials 

- IPSEC_PSK - your shared secret (line 4)
- VPN_USER - your VPN username (line 5)
- VPN_PASSWORD - your VPN password (line 6)

Details about why and how to use these scripts are provided at http://www.stormacq.com/?p=534
