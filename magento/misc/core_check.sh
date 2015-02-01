# This is intended to check the core version of Magento with your version of Magento
# You should download the core version of Magento and setup a GIT repo
# the opy your core back into it to ensure you have your patches, but at this point you should check to make sure there are not files that are no pathch files
diff $HOME/magento-core-files/app/code/core/ $HOME/current/app/code/core/
if [ $? -ne 0 ]
then
    echo "The directory was modified"
else
    echo "Core files are the same"
fi
