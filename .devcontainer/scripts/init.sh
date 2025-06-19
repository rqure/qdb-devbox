#!/bin/bash

REPOS=(
  "https://github.com/rqure/qlib-rs.git"
  "https://github.com/rqure/qcore.git"
  "https://github.com/rqure/qui.git"
)

# Clone each repository if it doesn't already exist
for REPO in "${REPOS[@]}"; do
  REPO_NAME=$(basename $REPO .git)
  if [ ! -d "$REPO_NAME" ]; then
    git clone $REPO
  else
    echo "Repository $REPO_NAME already exists. Skipping clone."
    (cd $REPO_NAME && git pull)
  fi
done

/workspace/.devcontainer/scripts/generate_ssl_certs.sh

/bin/bash