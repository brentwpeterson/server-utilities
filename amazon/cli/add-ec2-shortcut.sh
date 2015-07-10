touch $HOME/ec2-short.sh
echo 'ssh ec2-user@$1' >> $HOME/ec2-short.sh
echo 'alias ec2="sh ~/ec2-short.sh"' >> $HOME/.bashrc
