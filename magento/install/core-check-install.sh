#!bin/bash
echo "The following script will install a core-checking script to you Home directory, can choose a different directory"
echo "Choose your install directory"
read dir
echo "Include your HOME path?"
echo "Choose a file name (Default is core-checker.sh )"
read file
#########################
# The path from ~/your_directory
#########################
dir=${dir:-scripts}
file=${file:-core-checker.sh}

if [ ! -d "$HOME/$dir" ]; then
	mkdir -p "$HOME/$dir"
fi
checkfile="$HOME/$dir/$file"
if [ -e "$checkfile" ]; then
	mv $HOME/$dir/$file $HOME/$dir/$file-bak-$(date +%d%m%Y_%H%M).bak
else
	touch $HOME/$dir/$file
	echo $file ' was created' 
fi
excl="var media"
list="app/code/core js lib"
while true; do
echo "Create your file list, hit 'q' to quit"
read arg
	if [[ $arg = 'q' ]]; then
		break;
	elif [[ ! $arg = '' ]]; then
	list=$list" "$arg
        fi
	echo "Your list so far ->" $list
done
EMAILTO="brent@wagento.com"
while true; do
echo "Add Emails to a watch list, hit 'q' to quit"
read arg
	if [[ $arg = 'q' ]]; then
		break;
	elif [[ ! $arg = '' ]]; then
	EMAILTO=$EMAILTO","$arg
        fi
	echo "Your Emails: "$EMAILTO
done
# Start Script
echo "EMAILTO=\""$EMAILTO"\""  >> $HOME/$dir/$file
echo "list=\""$list"\""  >> $HOME/$dir/$file
echo "for item in \$list; do" >> $HOME/$dir/$file
echo "TOPATH=$HOME/current/$item" >> $HOME/$dir/$file
echo "FROMPATH=$HOME/magento/$item" >> $HOME/$dir/$file

echo " diff -wr \$FROMPATH \$TOPATH" >> $HOME/$dir/$file
echo "	if [ \$? -ne 0 ]; then" >> $HOME/$dir/$file
echo "	diff -wrql \$FROMPATH \$TOPATH >> "$HOME"/"$dir"/core-diff.log" >> $HOME/$dir/$file
# diff -wrql $FROMPATH $TOPATH | mutt -s "Core File Changes" -- $EMAILTO
  		#TODO copy and commit files to repo and push to git so files can be quickly reviewed	
echo "		else"  >> $HOME/$dir/$file
echo "		echo 'Core files are the same' >> "$HOME"/"$dir"/core-diff.log" >> $HOME/$dir/$file
echo "		fi" >> $HOME/$dir/$file
echo "	done" >> $HOME/$dir/$file

