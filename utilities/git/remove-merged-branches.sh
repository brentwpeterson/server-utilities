#!/bin/bash
#Pull all remote branches and make local

for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
	    git branch --track ${branch##*/} $branch
done

#Delete all local branches that have already been merged to master
#git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d

merged_branches(){
local current_branch=$(git rev-parse --abbrev-ref HEAD)
for branch in $(git branch --merged | cut -c3-)
  do
  echo "Branch $branch is already merged into $current_branch."
#  echo "Would you like to delete it? [Y]es/[N]o "
#  read REPLY
#  if [[ $REPLY =~ ^[Yy] ]]; then
  if [[ $branch -ne 'master' ]]; then
    git branch -d $branch
#       git push origin :$branch
   else
	   echo 'This is the master branch'
   fi
   done
}
merged_branches
