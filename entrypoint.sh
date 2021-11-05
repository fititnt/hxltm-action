#!/bin/sh -l

echo "Hello $1"
echo "Hello $2"

if [ "$2" != "vacuum" ]; then
#   echo "$2"
#   time="$($2)"
#   eval "$2"
  resultatum="$($2)"
  echo "::set-output name=resultatum::$resultatum"
fi

time=$(date)
echo "::set-output name=time::$time"