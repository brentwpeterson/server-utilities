#This is only a start
# #########################
# Brent Peterson support@wagento.com
# ** WARNING ** DO NOT USE THIS ON PRODUCTION
# DO NOT USE THIS UNLESS YOU HAVE TESTED IT ON YOUR LOCAL SYSTEM
# DO NOT USE THIS IF YOU HAVE NO IDEA WHAT YOU ARE DOING
#########################
#TODO EVERYTHING
fileclean='clean/path'
filecustom='custom/path'
diff -wsqrBt $filepath $filecustom | grep "identical" | cut -f 4 -d ' ' > $HOME/textfilesomewhere.txt; xargs rm < $HOME/textfilesomewhere.txt
