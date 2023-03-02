#!/usr/bin/env bash

# Allow passing a commit message
message=$1


if [ "$message" == "" ]; then
  #Use last git commit message for deploying into github pages
  message=`git log -1 --pretty=%B`
fi

git remote add ghub git@github.com:nordsh/nordsh.github.io.git

git add .

git commit -m "$message"

git push ghub main

##################################################################
# Generate static site into public & copy files into dist folder #
##################################################################
git checkout gh-pages 2>/dev/null || git checkout -b gh-pages

hugo -d public

rsync -avh --delete public/* dist

# Push the files into github pages
cd dist

git remote add ghub git@github.com:nordsh/nordsh.github.io.git

git add .

git commit -m "$message"

git push ghub gh-pages 

# Replace "master" with "gh-pages" if you are deploying into a project site

# go back to source directory

cd ../