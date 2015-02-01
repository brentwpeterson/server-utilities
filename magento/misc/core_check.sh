# This is intended to check the core version of Magento with your version of Magento
# To check to make sure core files have not been changed and if they do get changed to alert someone of the changes
# Requires you have MUTT installed
# You should download the core version of Magento and setup a GIT repo
# the opy your core back into it to ensure you have your patches, but at this point you should check to make sure there are not files that are no pathch files
EMAILTO="brent@wagento.com,creativedata@gmail.com"
diff $HOME/magento-core-files/app/code/core/ $HOME/current/app/code/core/
if [ $? -ne 0 ]
then
      diff -wrql $HOME/magento-core-files/app/code/core/ $HOME/current/app/code/core/ >> $HOME/core-diff.log
      diff -wrql $HOME/magento-core-files/app/code/core/ $HOME/current/app/code/core/ | mutt -s "Core File Changes" -- $EMAILTO
      #TODO copy and commit files to repo and push to git so files can be quickly reviewed
else
    echo "Core files are the same"
fi
