#!/bin/bash

REPOS=(
  "https://github.com/rqure/qdb.git"
  "https://github.com/rqure/qdeploy.git"
  "https://github.com/rqure/qschematic.git"
  "https://github.com/rqure/qwebgateway.git"
  "https://github.com/rqure/qgarage.git"
  "https://github.com/rqure/qadhan.git"
  "https://github.com/rqure/qalert.git"
  "https://github.com/rqure/qmqttgateway.git"
  "https://github.com/rqure/qaudio-player.git"
  "https://github.com/rqure/qclock.git"
  "https://github.com/rqure/qsmtp.git"
  "https://github.com/rqure/qlogger.git"
  "https://github.com/rqure/qdb-cli.git"
  "https://github.com/rqure/qsm.git"
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