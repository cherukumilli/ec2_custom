echo "*** Starting a new ec2 instance"
ec2-start-instances <PLACE HOLDER FOR INSTACE ID FROM AWS -- ONE TIME SETUP ONLY>

sleep 5

export cur_time=$(date +"%s")
export new_describe_file=desc.$cur_time

export ssh_config=$HOME/.ssh/config
export ssh_config_bkup=$ssh_config.$cur_time

echo "*** copying $ssh_config to backup $ssh_config_bkup"
cp $ssh_config $ssh_config_bkup

echo "*** creating a new describe file: $new_describe_file to get the new public DNS"
ec2-describe-instances i-6714836f --filter dns-name=ec2* > $new_describe_file

echo "*** turning off noclobber env variable"
set +o noclobber

echo "*** updating $ssh_config file with the new public DNS"
grep -o "ec2.*aws\.com" $new_describe_file | awk '{print "sed s/ec2.*aws\.com/"$1"/g $ssh_config_bkup > $ssh_config"}' | sh

##stop overwriting of files using redirection
echo "*** turning on noclobber env variable"
set -o noclobber

