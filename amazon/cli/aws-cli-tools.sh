read -p "This will add your Amazon keys to your bashrc, are you sure?  [yn]" answer
if [[ $answer = y ]] ; then
echo "Enter your Amazon Access key [ENTER]:"
read awskey
echo "Enter your Amazon TOP secret key [ENTER]:"
read awssecret
echo "export AWS_ACCESS_KEY=$awskey" >> $HOME/.bashrc
echo "export AWS_SECRET_KEY=$awssecret" >> $HOME/.bashrc
source $HOME/.bashrc
fi
aws configure
