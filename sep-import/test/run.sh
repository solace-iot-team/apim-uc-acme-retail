#!/usr/bin/env bash

scriptDir=$(cd $(dirname "$0") && pwd);
scriptName=$(basename $(test -L "$0" && readlink "$0" || echo "$0"));

############################################################################################################################
# Prepare

  LOG_DIR="$scriptDir/logs";
  mkdir -p $LOG_DIR;
  rm -rf $LOG_DIR/*;
  FAILED=0

############################################################################################################################
# Run

  logFile="$LOG_DIR/$scriptName.out";
  mkdir -p "$(dirname "$logFile")";

  runScript="npx sep-async-api-importer -fp ../../specs/**/*.spec.yml"
  echo "starting: $runScript ..."

  # $runScript
  $runScript | npx pino-pretty > $logFile 2>&1
  code=$?;
  if [[ $code != 0 ]]; then
    echo ">>> ERROR - code=$code - runScript='$runScript' - $scriptName";
    echo ">>> See log file for details: $logFile"
    FAILED=1;
  fi

##############################################################################################################################
# Check for errors

filePattern="$LOG_DIR"
errors=$(grep -n -r -e " ERROR " $filePattern )
if [ ! -z "$errors" ]; then
  FAILED=1
  echo "   found ${#errors[@]} ERRORS"
  while IFS= read line; do
    echo $line >> "$LOG_DIR/$scriptName.ERROR.out"
  done < <(printf '%s\n' "$errors")
else
  echo "   no ERROR found"
fi

if [[ "$FAILED" -eq 0 ]]; then
  echo ">>> FINISHED:SUCCESS - $scriptName"
  touch "$LOG_DIR/$scriptName.SUCCESS.out"
else
  echo ">>> FINISHED:FAILED";
  exit 1
fi

###
# The End.
