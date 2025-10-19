#!/bin/bash

REPOS=(
  "https://github.com/rqure/qlib-rs.git"
  "https://github.com/rqure/qcore-rs.git"
  "https://github.com/rqure/qweb.git"
  "https://github.com/rqure/qsession_manager.git"
  "https://github.com/rqure/qui.git"
)

for REPO in "${REPOS[@]}"; do
    REPO_NAME=$(basename $REPO .git)
    (cd $REPO_NAME && git commit -am "$1" && git push)
done