AWSVPN
======

Start a private VPN server in the cloud. 

These scripts have the following preriquisites
- AWS EC2 Command Line API is installed 
- EC2_HOME environment variable points to command line tools
- EC2_URL environment variables contains AWS endpoint (Europe, US etc ..)
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

Details about why and how to use these scripts are provided at http://www.stormacq.com/?p=534
