#!bin/bash
#simple script to change users on a server - Change the name of your script
echo "Please choose from one of the following users [ENTER]:"

echo "[1] %example1%"

echo "[2] %example2%"

read C
case "$C" in
"1")
echo "Switching to %example1%"
    	sudo su - example1
 	cd ~/
echo "You are now the user %example1%"
    ;;
"2")
echo "Switching to %example2%"
    sudo su - example2 
    cd ~/
echo "You are now the user %example2%"
    ;;
*)
    echo "Sorry, I really don't feel like doing anything"
    ;;
esac
