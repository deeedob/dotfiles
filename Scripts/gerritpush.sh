#! /bin/bash

# This script is used to push changes to gerrit for review with additional options.
#  https://gerrit-review.googlesource.com/Documentation/user-upload.html

# Default values for optional arguments
notify="None"
topic=""
hashtag=""
description=""
reviewers=""
ncommits=""
wip=false

# Function to validate if a string contains spaces
contains_spaces() {
    if [[ $1 =~ [[:space:]] ]]; then
        return 0
    else
        return 1
    fi
}

# Function to validate the notify mode
validate_notify_mode() {
    local mode="$1"
    case "$mode" in
        "A" | "O" | "R" | "N")
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Function to expand notify mode to full names
expand_notify_mode() {
    case "$1" in
        "A") echo "All" ;;
        "O") echo "Owner" ;;
        "R") echo "Owner Reviewers" ;;
        "N") echo "None" ;;
    esac
}

# Function to generate Gerrit push options
generate_gerrit_push_options() {
    local options="notify=$notify"
    [ -n "$topic" ] && options="$options,topic=$topic"
    [ -n "$hashtag" ] && options="$options,hashtag=$hashtag"
    [ -n "$description" ] && options="$options,description=$description"
    [ -n "$reviewers" ] && options="$options,$reviewers"
    [ "$wip" = true ] && options="$options,wip"
    [ "$wip" = false ] && options="$options,ready"
    echo "$options"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -n|--notify)
            if validate_notify_mode "$2"; then
                notify=$(expand_notify_mode "$2")
            else
                echo "Error: Invalid notify mode. Use A, O, R, or N."
                exit 1
            fi
            shift 2
            ;;
        -t|--topic)
            if contains_spaces "$2"; then
                echo "Error: Topic cannot contain spaces."
                exit 1
            fi
            topic="$2"
            shift 2
            ;;
        --hashtag)
            if contains_spaces "$2"; then
                echo "Error: Hashtag cannot contain spaces."
                exit 1
            fi
            hashtag="$2"
            shift 2
            ;;
        --description)
            if contains_spaces "$2"; then
                echo "Error: Description cannot contain spaces."
                exit 1
            fi
            description="$2"
            shift 2
            ;;
        -r|--reviewer)
            if contains_spaces "$2"; then
                echo "Error: Reviewer cannot contain spaces."
                exit 1
            fi
            reviewers="$reviewers,r=$2"
            shift 2
            ;;
        -c|--ncommits)
            ncommits="$2"
            shift 2
            ;;
        --wip)
            wip=true
            shift
            ;;
        *)
            branch="$1"
            shift
            ;;
    esac
done

reviewers="${reviewers#,}"

# Check if the branch argument is provided
if [ -z "$branch" ]; then
    echo "Error: Missing branch argument."
    exit 1
fi

push_options=$(generate_gerrit_push_options)
ref="HEAD"

# Check if ncommits is provided and is a valid number. If so, append it to the ref
if [ -n "$ncommits" ]; then
    if [[ "$ncommits" =~ ^[0-9]+$ ]]; then
        ref="$ref~$ncommits"
    else
        echo "Error: Invalid number of commits."
        exit 1
    fi
fi

cmd="git push gerrit $ref:refs/for/$branch%$push_options"

# Print the Gerrit push command for the user to review
RED='\033[0;31m'
NC='\033[0m' # No Color
echo -e "${RED}Generated Gerrit Push Command:${NC}"
echo -e "${RED}$cmd${NC}"

# Ask the user for confirmation
read -p "Do you want to proceed? (y/n): " confirm
if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Operation aborted."
    exit 0
fi

# COMMIT
eval "$cmd"

