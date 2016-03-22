#! /bin/bash
# generate .gitignore
# add rules to.gitignore automatically
#author: Atheotsky
 
GIT=.gitignore
 
# find exception under a directory. $1 : directory, $2 keyword
getExceptions()
{
	SUBDIRS=$(find $1 -type d -iname $2 | grep -i media | sort | awk '$0 !~ last "/" {print last} {last=$0} END {print last}')
}
 
find . -name '.svn' -depth -exec rm -rf {} \;
find . -name '*_DS*' -depth -exec rm -rf {} \;
find . -type d -empty -exec touch {}/$GIT \;
touch $GIT;
 
#default rules
echo 'app/etc/local.xml' >> $GIT;
echo 'errors/local.xml' >> $GIT;
echo 'tasks.txt' >> $GIT;
 
#directories must have slash / to make sure git won't mistake it with file
echo '.idea/' >> $GIT;
echo '.modgit/' >> $GIT;
echo 'includes/' >> $GIT;
echo 'media/catalog' >> $GIT;
echo 'nbproject/' >> $GIT;
echo 'var/' >> $GIT;
echo 'dev/' >> $GIT;
echo 'magmi' >> $GIT;

 
echo '.DS_Store' >> $GIT;
echo '*.swp' >> $GIT;
echo '*.swn' >> $GIT;
echo '*.swo' >> $GIT;
echo 'Thumbs.db' >> $GIT;

 
#add exceptions - invoke function with param directory and keyword
echo '#files & folders exception' >> $GIT;
 
getExceptions 'app' 'media'
for line in $SUBDIRS
do
	printf "!%s\n" $line >> $GIT;
done
 
getExceptions 'skin' 'media'
for line in $SUBDIRS
do
	printf "!%s\n" $line >> $GIT;
done
 
getExceptions 'js' 'media'
for line in $SUBDIRS
do
	printf "!%s\n" $line >> $GIT;
done
 
#do git initialize
#git init;
#git add . ;
#git commit -m 'The first Git imporot'
