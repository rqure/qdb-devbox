#!/bin/bash

REPOS=(
  "https://github.com/rqure/qcore-rs.git"
  "https://github.com/rqure/qweb.git"
  "https://github.com/rqure/qsession_manager.git"
)

for REPO in "${REPOS[@]}"; do
    REPO_NAME=$(basename $REPO .git)

    (
        cd $REPO_NAME
        # Fetch all tags to ensure we have the latest tag information
        git fetch --tags
        # Determine the next tag version (this example assumes semantic versioning)
        LATEST_TAG=$(git describe --tags --abbrev=0)
        NEW_TAG=$(echo $LATEST_TAG | awk -F. '{$NF += 1; print $1"."$2"."$3}')
        
        # Create and push a new tag
        git tag $NEW_TAG
        git push origin $NEW_TAG
    )
done