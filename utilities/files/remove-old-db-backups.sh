####This is just a start
# #########################
# Brent Peterson support@wagento.com
# ** WARNING ** DO NOT USE THIS ON PRODUCTION
# DO NOT USE THIS UNLESS YOU HAVE TESTED IT ON YOUR LOCAL SYSTEM
# DO NOT USE THIS IF YOU HAVE NO IDEA WHAT YOU ARE DOING
# It would probably be better that no one uses this one
#########################
find $home/path/to/files/ -mtime +30 -name '*.gz' -exec rm {} \;
