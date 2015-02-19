# #########################
# Brent Peterson support@wagento.com
# ** WARNING ** DO NOT USE THIS ON PRODUCTION
# DO NOT USE THIS UNLESS YOU HAVE TESTED IT ON YOUR LOCAL SYSTEM
# DO NOT USE THIS IF YOU HAVE NO IDEA WHAT YOU ARE DOING
#########################
# Looking for your feed back to make this better!
# This is intended to check the core version of Magento with your version of Magento
# To check to make sure core files have not been changed and if they do get changed to alert someone of the changes
# This would best be done at install and patches commited to core version. 
# Requires you have MUTT installed
# You should download the core version of Magento and setup a GIT repo
# the opy your core back into it to ensure you have your patches, but at this point you should check to make sure there are not files that are no pathch files
EMAILTO="brent@wagento.com,creativedata@gmail.com"

# Change the path for the two directories to diff below
# TODO create installer that will generate a file automatically
# TODO download CE version if site is CE, EE Code will have to manually be install
list="app/code/core lib js"
for item in $list; do
TOPATH=$HOME"/Sites/Wholebody/current/"$item
FROMPATH=$HOME"/Sites/Wholebody/magento/"$item

 diff -wr $FROMPATH $TOPATH
 if [ $? -ne 0 ]
 then
      diff -wrql $FROMPATH $TOPATH >> $HOME/core-diff.log
     # diff -wrql $FROMPATH $TOPATH | mutt -s "Core File Changes" -- $EMAILTO
      #TODO copy and commit files to repo and push to git so files can be quickly reviewed
 else
    echo "Core files are the same" >> $HOME/core-diff.log
 fi
done