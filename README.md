# ec2 custom scripts to automate setup (start, stop) of ec2 instances on Ubuntu

Problem: AWS keeps charges for the free plans if you are not careful in managing the cpu time for your micro instance.

Solution: Use scripting to stop the running instance at the end of the work day and start the instance at the beginning of the work day.

Approach: Use the EC2 CLI api's to stop and start the instance. Use the Linux bash scripts to update the ssh config file.

Assumption: 
i.   These scripts assume that you are dealing with a single instance of the micro instance
ii.  AWS EC2 console has been used to create a micro instance 
iii. AWS EC2 console is used to create a security group to support ssh and other required protocols
iv.  AWS EC2 console is sued to create the security key file xxxx.pem file
v.   On Ubuntu dev box, ssh-keygen has been used to generate the proper keys
        Copy the xxxx.pem file from step# iv to the $HOME/.ssh folder
        Create a "config" file with the entry for only one instance for example:
           Host helphd
           HostName ec2-54-200-197-55.us-west-2.compute.amazonaws.com
           User ubuntu
           IdentityFile "~/.ssh/xxxx.pem"
    


## start and stop ec2 instance using the scripts
To stop the instance type (without the $):
$ ./stopec2.sh

To start the instance type (without the $):
$ ./startec2.sh

To run the scripts above you need to do the following one time setup

#################################################################
## BEGIN - ONE TIME SETUP SECTION
#################################################################
## setup ec2 cli api's for control from command line and scripting

mkdir /usr/local/ec2
cd /usr/local/ec2
wget http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip
unzip ec2-api-tools.zip #go to next step if ec2-api-tools-1.* directory exists
rm ec2-api-tools.zip   #remove the zip file as it is no longer needed

## PREREQUISITE 2 - ONE TIME SETUP
## download the ec2 custom scripts

cd   # go back to the home directory
git clone git@github.com:cherukumilli/ec2_custom.git 
cd ec2_custom


## copy the pk*.pem, cert*.pem, rootkey.csv files from AWS to the "ec2_custom" folder
1. Goto https://console.aws.amazon.com/iam/home?#security_credential
2. Generate the Access Keys (Access Key ID and Secret Access Key)
3. Download the Access Keys file. It is called rootkey.csv.
4. Generate the X.509 Certificates
5. Download the certicates. They start with pk-*.pem and cert-*.pem
6. Copy all 3 files into the $HOME/ec2_custom foler
7. open the file $HOME/ec2_custom/dotfiles/.ec2 
8. Edit entry AWS_ACCESS_KEY with the key from rootkey.csv (step #3)
9. Edit entry AWS_SECRET_KEY with the key from rootkey.csv (step #3)
10.Edit entry EC2_URL with the URL region for your instance. Check http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/SettingUp_CommandLine.html#set_ec2_url_linux for more info.
11.Edit the JAVA_HOME entry if needed. It currently pointing to: /usr/lib/jvm/java-7-openjdk-amd64/jre.
12.save the file

## update the start and stop scripts
a. Goto the AWS console: https://console.aws.amazon.com/console/home
b. Goto EC2 and create your instance if you haven't done so already
c. Copy the Instance ID (for example: i-1234567a)
d. Go to the $EC2_CUSTOM directory on your ubuntu dev box (cd $EC2_CUSTOM)
e. Replace the Instance ID place holder in startec2.sh and stopec2.sh with your Instance ID from step# c
f. save the files

## update your .bashrc file with the changes
./update_bashrc.sh


## restart all your shell windows for the changes to take effect
exit

!! HURRAY !!!
You are ready to use the ec2 custom scripts for starting and stopping your instance

#################################################################
## END - ONE TIME SETUP SECTION
#################################################################

