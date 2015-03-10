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
#TODO Make sure it is not master
       git branch -d $branch
       git push origin :$branch

   done
}
merged_branches
