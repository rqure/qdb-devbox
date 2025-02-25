#!/bin/bash

REPOS=(
  "https://github.com/rqure/qschematic.git"
  "https://github.com/rqure/qcore.git"
  "https://github.com/rqure/qgarage.git"
  "https://github.com/rqure/qadhan.git"
  "https://github.com/rqure/qalert.git"
  "https://github.com/rqure/qmqttgateway.git"
  "https://github.com/rqure/qaudio-player.git"
  "https://github.com/rqure/qclock.git"
  "https://github.com/rqure/qsmtp.git"
  "https://github.com/rqure/qsm.git"
  "https://github.com/rqure/qdp.git"
)

for REPO in "${REPOS[@]}"; do
    REPO_NAME=$(basename $REPO .git)
    (
        cd $REPO_NAME
        go get -u ./...
        go mod tidy
    )
done