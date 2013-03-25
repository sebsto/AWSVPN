AWSVPN
======

License
-------

Licensed under the BSD 3 Clauses License (http://opensource.org/licenses/BSD-3-Clause)

Distributed on an "AS IS" basis without warranties or conditions of any kind, either express or implied.

How To ?
--------
  
Start a private VPN server in the cloud. 

- vpn-ec2-start script is run from your computer.  It starts a machine on EC2
- vpn-ec2-install script will be run from AWS' EC2 instance to setup VPN
- vpn-ec2-terminate script is run from your computer to terminate (shutdown) the VPN server

THESE SCRIPTS MUST BE MODIFIED TO RUN IN YOUR ENVIRONMENT - PLEASE READ BELOW

These local scripts have the following preriquisites
- AWS EC2 Command Line API is installed (http://aws.amazon.com/developertools/351)
- EC2_HOME environment variable points to command line tools
- EC2_URL environment variables contains AWS endpoint (http://docs.aws.amazon.com/general/latest/gr/rande.html#ec2_region)
- AWS_ACCESS_KEY environment variable contains your AWS access key
- AWS_SECRET_KEY environment variable contains your AWS secret key

Here is an example of my $HOME/.profile
```bash
export JAVA_HOME=`/usr/libexec/java_home`
export EC2_HOME=/Users/sst/Projects/aws/ec2-api-tools-latest
export AWS_ACCESS_KEY=<access key>
export AWS_SECRET_KEY=<secret key>
export EC2_URL=http://ec2.eu-west-1.amazonaws.com
```

You also need to have 

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
