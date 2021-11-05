#!/bin/sh -l
# SPDX-License-Identifier: Unlicense OR 0BSD

# @see https://docs.github.com/en/actions/learn-github-actions/workflow-commands-for-github-actions

echo "param 1 $1"
echo "param 2 $2"
echo "param 3 $3"

hxltm_action_bin="$1"
hxltm_action_infile="${2:-fontem.ext}"
hxltm_action_outfile="${3:-objectivum.ext}"

if echo "$hxltm_action_bin" | grep -q "hxl"
then
    # TODO: simple check for spaces, and etc
    echo "hxl okay"
else
    echo "ERROR: [$hxltm_action_bin] not hxltml or libhxl-python binary"
    exit 1
fi

hxltm_action_cmd="$hxltm_action_bin $hxltm_action_infile $hxltm_action_outfile"

echo "hxltm_action_cmd [$hxltm_action_cmd]"

echo "::group::resultatum"
resultatum="$($hxltm_action_cmd)"
echo "$resultatum"
echo "::set-output name=resultatum::$resultatum"

# echo "::endgroup::"
# if [ "$1" != "vacuum" ]; then
# #   echo "$2"
# #   time="$($2)"
# #   eval "$2"
#   resultatum="$($1)"
#   echo "::set-output name=resultatum::$resultatum"
#   echo ""
#   echo "resultatum"
#   echo "$resultatum"
# fi

# echo "::group::My title"
# echo "Inside group"
# echo "::endgroup::"

# time=$(date)
# echo "::set-output name=time::$time"