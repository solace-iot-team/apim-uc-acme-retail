#!/usr/bin/env bash

scriptDir=$(cd $(dirname "$0") && pwd);
scriptName=$(basename $(test -L "$0" && readlink "$0" || echo "$0"));

############################################################################################################################
# Prepare

  TMP_DIR="$scriptDir/tmp";
  LOG_DIR="$TMP_DIR/logs";
  mkdir -p $LOG_DIR;
  rm -rf $LOG_DIR/*;
  FAILED=0

  cd $scriptDir

############################################################################################################################
# Run

  logFile="$LOG_DIR/$scriptName.out";
  mkdir -p "$(dirname "$logFile")";

  runScript="npx ep-async-api-importer -fp $scriptDir/../../specs/**/*.spec.yml"
  echo "starting: $runScript ..."

  $runScript 2>&1 > $logFile 2>&1

  code=${PIPESTATUS[0]}

  if [[ $code != 0 ]]; then
    echo ">>> ERROR - code=$code - runScript='$runScript' - $scriptName";
    echo ">>> See log file for details: $logFile"
    FAILED=1;
  fi

##############################################################################################################################
# Check for errors

filePattern="$LOG_DIR"
cliErrors=$(grep -n -r -e "CliError" $filePattern )
errors=$(grep -n -r -e " ERROR " $filePattern )

if [ ! -z "$cliErrors" ]; then
  FAILED=1
  echo "   found ${#cliErrors[@]} CliError(s)"
  while IFS= read line; do
    echo $line >> "$LOG_DIR/$scriptName.ERROR.out"
  done < <(printf '%s\n' "$cliErrors")
else
  echo "   no CliError found"
fi

if [ ! -z "$errors" ]; then
  FAILED=1
  echo "   found ${#errors[@]} ERROR(s)"
  while IFS= read line; do
    echo $line >> "$LOG_DIR/$scriptName.ERROR.out"
  done < <(printf '%s\n' "$errors")
else
  echo "   no ERROR(s) found"
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
