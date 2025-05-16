#!/bin/bash

REPOS=(
  "https://github.com/rqure/qcore.git"
)

for REPO in "${REPOS[@]}"; do
    REPO_NAME=$(basename $REPO .git)
    (
        cd $REPO_NAME
        go get -u ./...
        go mod tidy
    )
done