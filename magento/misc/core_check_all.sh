# Looking for your feed back to make this better!
# This is intended to check the core version of Magento with your version of Magento
# To check to make sure core files have not been changed and if they do get changed to alert someone of the changes
# This would best be done at install and patches commited to core version. 
# Requires you have MUTT installed
# You should download the core version of Magento and setup a GIT repo
# the opy your core back into it to ensure you have your patches, but at this point you should check to make sure there are not files that are no pathch files
EMAILTO="brent@wagento.com"
#FOR TESTING EMAILTO="brent@wagento.com"
# Change the path for the two directories to diff below
# TODO create installer that will generate a file automatically
# TODO download CE version if site is CE, EE Code will have to manually be install
diff -wr --exclude-from='$HOME/exclude-list.txt' /$HOME/current/ /$HOME/compare-repo/
if [ $? -ne 0 ]
then
      diff -wrql --exclude-from='/$HOME/exclude-list.txt' /$HOME/current/ /$HOME/compare-repo/ >> $HOME/core-diff.log
      diff -wrql --exclude-from='/$HOME/exclude-list.txt' /$HOME/current/ /$HOME/compare-repo/ | mutt -s "File Changes" -- $EMAILTO
      #TODO copy and commit files to repo and push to git so files can be quickly reviewed
else
    echo "Files are the same" >> $HOME/core-diff.log
fi
# Add 
