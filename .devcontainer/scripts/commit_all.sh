#!/bin/bash

REPOS=(
  "https://github.com/rqure/qdb.git"
  "https://github.com/rqure/qlib.git"
  "https://github.com/rqure/qdeploy.git"
  "https://github.com/rqure/qschematic.git"
  "https://github.com/rqure/qcore.git"
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

for REPO in "${REPOS[@]}"; do
    REPO_NAME=$(basename $REPO .git)
    (cd $REPO_NAME && git commit -am "$1" && git push)
done