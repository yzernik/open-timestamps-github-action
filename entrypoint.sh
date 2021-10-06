#!/bin/sh -l

echo "hello $1"

echo "$(cat /ots-git-gpg-wrapper.sh)"

echo "$(git status)"
echo "$(git log)"

$TAG_NAME = $(openssl rand -base64 12)

git tag $TAG_NAME

echo "$(git tag)"

git push origin $TAG_NAME
