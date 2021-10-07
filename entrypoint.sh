#!/bin/bash -l

$CUSTOM_MESSAGE = $1

echo "repo: $GITHUB_REPOSITORY"
echo "ref: $GITHUB_REF"
echo "actor: $GITHUB_ACTOR"
echo "custom message: $CUSTOM_MESSAGE"

# Exit if ref is not a tag
if [[ $GITHUB_REF =~ ^refs/tags* ]]
then
    echo "ref is a tag."
else
    echo "ref is not a tag."
    exit 0
fi

# Parse the tag name
TAG_NAME=${GITHUB_REF##*/}
echo "tag name: $TAG_NAME"

# Generate GPG key
echo "$(gpg --batch --passphrase '' --quick-generate-key "ots-action-key" rsa4096)"
KEY_ID="$(gpg --list-secret-keys --keyid-format=long --with-colons | awk -F: '/sec:u:4096:1:/ {print $5}')"

# Configure git
git config --global user.email "fake@email.com"
git config --global user.name "OpenTimestamps Github Action"
git config --global user.signingkey $KEY_ID
git config --global gpg.program /ots-git-gpg-wrapper.sh

NEW_TAG_NAME="$TAG_NAME-ots"
TAG_MESSAGE="$(printf "OpenTimestamps Github Action")"
TAG_MESSAGE="$(printf "${TAG_MESSAGE}\nGithub repository: $GITHUB_REPOSITORY")"
TAG_MESSAGE="$(printf "${TAG_MESSAGE}\nGithub actor: $GITHUB_ACTOR")"

# Append custom message if exists
if [[ -z "$CUSTOM_MESSAGE" ]]
then
    TAG_MESSAGE="$(printf "${TAG_MESSAGE}\n$CUSTOM_MESSAGE")"
fi

# Create and push signed tag
git tag -s -m "$(printf $TAG_MESSAGE)" $NEW_TAG_NAME HEAD
echo "$(git tag)"
git push origin $NEW_TAG_NAME
