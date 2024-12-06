#!/bin/bash

REPOS=(
  "https://github.com/rqure/qdb.git"
  "https://github.com/rqure/qlib.git"
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
  "https://github.com/rqure/qdb-cli.git"
  "https://github.com/rqure/qsm.git"
  "https://github.com/rqure/qdp.git"
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

/bin/bash