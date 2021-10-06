#!/bin/sh -l

echo "hello $1"

# echo "$(cat /ots-git-gpg-wrapper.sh)"

# echo "$(git status)"
# echo "$(git log)"

# # Generate GPG key
echo "$(gpg --batch --passphrase '' --quick-generate-key "example-key" rsa4097 cert never)"
# echo "$(gpg --list-secret-keys --keyid-format=long)"
echo "$(gpg --list-keys --with-colons  | awk -F: '/fpr:/ {print $10}')"

TAG_NAME=$(openssl rand -hex 12)

git tag $TAG_NAME

echo "$(git tag)"

git push origin $TAG_NAME
