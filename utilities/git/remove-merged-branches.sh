#!/bin/bash
#Pull all remote branches and make local

for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
	    git branch --track ${branch##*/} $branch
done

#Delete all local branches that have already been merged to master
git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d
