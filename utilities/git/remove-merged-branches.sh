#!/bin/bash

# Defaults

DRY_RUN=false
LOCAL_ONLY=false

# Globals

ORIGINAL_BRANCH=$(git rev-parse --abbrev-ref HEAD)
CURRENT_BRANCH=$ORIGINAL_BRANCH

# Colors

ESCAPE_SEQUENCE="\x1b["
COLOR_RESET=$ESCAPE_SEQUENCE"39;49;00m"
COLOR_RED=$ESCAPE_SEQUENCE"31;01m"
COLOR_GREEN=$ESCAPE_SEQUENCE"32;01m"
COLOR_YELLOW=$ESCAPE_SEQUENCE"33;01m"

# Error Handling

trap exit_gracefully SIGINT

# Functions

get_flags() {
	while test $# -gt 0; do
		case "$1" in
			-n|--dryrun)
				DRY_RUN=true
				shift
				;;
			-l|--local)
				LOCAL_ONLY=true
				shift
				;;
			*)
				break
				;;
		esac
	done
}

checkout_branch() {
	local branch="$1"

	if [ "$CURRENT_BRANCH" = "$branch" ]; then
		return 0
	fi

	git checkout -q "$branch"

	CURRENT_BRANCH=$branch
}

track_remote_braches() {
	# Pull all remote branches and make local
	for remote_branch in $(git branch -a | grep remotes | grep -v HEAD | grep -v master); do
		local local_branch=${remote_branch##*/}

		if git show-ref --quiet --verify -- "refs/heads/$local_branch"; then
			continue
		fi

		git branch -q -t "$local_branch" "$remote_branch"

		if [ $? -eq 0 ]; then
			echo -e "${COLOR_GREEN}Created ${local_branch} to track ${remote_branch}${COLOR_RESET}"
			echo
		else
			echo -e "${COLOR_RED}Could not create ${local_branch} to track ${remote_branch}${COLOR_RESET}"
			echo
		fi
	done
}

remove_merged_branches() {
	for branch in $(git branch --merged | cut -c3-); do
		if [ "$branch" = 'master' ]; then
			continue
		fi

		read -p "$branch is already merged into $CURRENT_BRANCH. Would you like to delete it? [Y]es/[N]o " REPLY
		echo

		if ! [[ $REPLY =~ ^[Yy] ]]; then
			continue
		fi

		if [ "$DRY_RUN" = true ]; then
			echo -e "${COLOR_YELLOW}Would delete ${branch}${COLOR_RESET}"
			echo

			continue
		fi

		git branch -q -d "$branch" # Remove the local branch

		if [ $? -eq 0 ]; then
			echo -e "${COLOR_GREEN}Deleted ${branch} from local repository${COLOR_RESET}"
			echo
		else
			echo -e "${COLOR_RED}Could not delete ${branch} from local repository${COLOR_RESET}"
			echo
		fi

		if [ "$LOCAL_ONLY" = true ]; then
			continue
		fi

		git push -q origin :"$branch"  # Remove the remote branch

		if [ $? -eq 0 ]; then
			echo -e "${COLOR_GREEN}Deleted ${branch} from remote repository${COLOR_RESET}"
			echo
		else
			echo -e "${COLOR_RED}Could not delete ${branch} from remote repository${COLOR_RESET}"
			echo
		fi
	done
}

exit_gracefully() {
	# Perform any necessay clean up before exit

	local retval="${1:-1}"

	checkout_branch "$ORIGINAL_BRANCH"

	exit $retval
}

# Execution

get_flags "$@"
checkout_branch "master"
track_remote_braches
remove_merged_branches
exit_gracefully 0
