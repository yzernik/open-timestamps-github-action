#!/bin/sh -l

echo "hello $1"

# # Generate GPG key
echo "$(gpg --batch --passphrase '' --quick-generate-key "example-14" rsa4096)"
KEY_ID="$(gpg --list-secret-keys --keyid-format=long --with-colons | awk -F: '/sec:u:4096:1:/ {print $5}')"
echo "Using key id: $(echo $KEY_ID)"

git config --global user.email "fake@email.com"
git config --global user.name "Fake name"
git config --global user.signingkey $KEY_ID
git config --global gpg.program gpg
#GIT_TRACE=1 git tag -s -m 'Hello World!' test-tag HEAD
git config --global gpg.program /ots-git-gpg-wrapper.sh

TAG_NAME=$(openssl rand -hex 12)

#git tag $TAG_NAME
git tag -s -m 'Hello World!' $TAG_NAME HEAD

echo "$(git tag)"

git push origin $TAG_NAME
