#!/bin/sh -l
# ==============================================================================
#
#          FILE:  entrypoint.sh
#
#         USAGE:  ---
#
#   DESCRIPTION:  ---
#
#       OPTIONS:  ---
#
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#       AUTHORS:  Emerson Rocha <rocha[at]ieee.org>
# COLLABORATORS:  <@TODO: put additional non-anonymous names here>
#       COMPANY:  EticaAI
#       LICENSE:  Public Domain dedication OR Zero-Clause BSD
#                 SPDX-License-Identifier: Unlicense OR 0BSD
#       VERSION:  v1.0
#       CREATED:  2021-11-04 11:27 UTC started
# ==============================================================================

# @see https://docs.github.com/en/actions/learn-github-actions/workflow-commands-for-github-actions

# str=$(printf '%s' "$str" | tr '/' 'a')

# formatmultiline () {
#     rawinput="${1//'%'/'%25'}"
#     rawinput="${rawinput//$'\n'/'%0A'}"
#     rawinput="${rawinput//$'\r'/'%0D'}"
#     echo "$rawinput"
# }

echo "::group::Debug parameters"
echo "param 1 $1"
echo "param 2 $2"
echo "param 3 $3"
echo "param 4 $4"
echo "param @ $*"
echo "SHELL @ $SHELL"
echo "GITHUB_WORKSPACE $GITHUB_WORKSPACE"
echo "WORKDIR $WORKDIR"

# shellcheck disable=SC2154
echo "source_language $source_language"
# shellcheck disable=SC2154
echo "target_language $target_language"
# shellcheck disable=SC2154
echo "working_languages $working_languages"
# working_languages2=formatmultiline "$working_languages"
# shellcheck disable=SC2154
# echo "working_languages $working_languages2"
# shellcheck disable=SC2154
echo "auxiliary_languages $auxiliary_languages"
# cat /etc/*release
# printenv
echo "::endgroup::"

hxltm_action_bin="$1"
hxltm_action_infile="${2:-fontem.ext}"
hxltm_action_outfile="${3:-objectivum.ext}"
hxltm_action_args="$4"

if echo "$hxltm_action_bin" | grep -q "hxl"
then
    # TODO: simple check for spaces, and etc
    echo "INFO: [$hxltm_action_bin] Okay"
else
    echo "ERROR: [$hxltm_action_bin] not hxltml or libhxl-python binary"
    exit 1
fi

hxltm_action_cmd="$hxltm_action_bin $hxltm_action_args $hxltm_action_infile $hxltm_action_outfile"

# echo "::group::source file"
# ls -lha "$hxltm_action_infile"
# echo "::endgroup::"

echo "::group::hxltm_action_cmd"
echo "$hxltm_action_cmd"
echo "::endgroup::"

echo "::group::resultatum"
resultatum="$($hxltm_action_cmd)"
echo "$resultatum"
echo "::endgroup::"
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