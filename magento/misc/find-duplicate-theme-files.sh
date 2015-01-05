#This is only a start
#TODO EVERYTHING
fileclean='clean/path'
filecustom='custom/path'
diff -wsqrBt $filepath $filecustom | grep "identical" | cut -f 4 -d ' ' > $HOME/textfilesomewhere.txt; xargs rm < $HOME/textfilesomewhere.txt
