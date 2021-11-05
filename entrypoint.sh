#!/bin/sh -l
# SPDX-License-Identifier: Unlicense OR 0BSD

# @see https://docs.github.com/en/actions/learn-github-actions/workflow-commands-for-github-actions

echo "param 1 $1"
echo "param 2 $2"
echo "param 3 $2"

if [ "$1" != "vacuum" ]; then
#   echo "$2"
#   time="$($2)"
#   eval "$2"
  resultatum="$($1)"
  echo "::set-output name=resultatum::$resultatum"
  echo ""
  echo "resultatum"
  echo "$resultatum"
fi

echo "::group::My title"
echo "Inside group"
echo "::endgroup::"

# time=$(date)
# echo "::set-output name=time::$time"