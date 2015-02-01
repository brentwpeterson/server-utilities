# This is intended to check the core version of Magento with your version of Magento
# You should download the core version of Magento and setup a GIT repo
# the opy your core back into it to ensure you have your patches, but at this point you should check to make sure there are not files that are no pathch files
EMAILTO="brent@wagento.com,creativedata@gmail.com"
diff $HOME/magento-core-files/app/code/core/ $HOME/current/app/code/core/
if [ $? -ne 0 ]
then
      diff -wrql $HOME/magento-core-files/app/code/core/ $HOME/current/app/code/core/ >> $HOME/core-diff.log
      diff -wrql $HOME/magento-core-files/app/code/core/ $HOME/current/app/code/core/ | mutt -s "Core File Changes" -- $EMAILTO
else
    echo "Core files are the same" >> $HOME/core-diff.log
fi
diff $HOME/magento-core-files/lib/ $HOME/current/lib/
if [ $? -ne 0 ]
then
      diff -wrql $HOME/magento-core-files/lib/ $HOME/current/lib/ >> $HOME/core-diff.log
      diff -wrql $HOME/magento-core-files/lib/ $HOME/current/lib/ | mutt -s "Core File Changes" -- $EMAILTO
else
    echo "lib files are the same" >> $HOME/core-diff.log
fi
