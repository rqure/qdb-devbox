#!/bin/bash

REPOS=(
  "https://github.com/rqure/qlib.git"
  "https://github.com/rqure/qcore.git"
)

for REPO in "${REPOS[@]}"; do
    REPO_NAME=$(basename $REPO .git)
    (cd $REPO_NAME && git commit -am "$1" && git push)
done