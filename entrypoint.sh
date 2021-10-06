#!/bin/sh -l

echo "hello $1"
echo "repo name: $2"

# # Generate GPG key
echo "$(gpg --batch --passphrase '' --quick-generate-key "ots-action-key" rsa4096)"
KEY_ID="$(gpg --list-secret-keys --keyid-format=long --with-colons | awk -F: '/sec:u:4096:1:/ {print $5}')"
echo "Using key id: $(echo $KEY_ID)"

git config --global user.name "OpenTimestamps Github Action"
git config --global user.signingkey $KEY_ID
git config --global gpg.program /ots-git-gpg-wrapper.sh

TAG_NAME=$(openssl rand -hex 12)
TAG_MESSAGE="This commit belongs to repository: $2."

#git tag $TAG_NAME
git tag -s -m "$TAG_MESSAGE" $TAG_NAME HEAD

echo "$(git tag)"

git push origin $TAG_NAME
