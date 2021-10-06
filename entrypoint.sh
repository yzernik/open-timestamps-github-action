#!/bin/bash -l

echo "repo: $GITHUB_REPOSITORY"
echo "ref: $GITHUB_REF"

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
TAG_MESSAGE="This commit belongs to repository: ${GITHUB_REPOSITORY}."

# Create and push signed tag
git tag -s -m "$TAG_MESSAGE" $NEW_TAG_NAME HEAD
echo "$(git tag)"
git push origin $NEW_TAG_NAME
