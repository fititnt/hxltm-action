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

# working_languages=$(cat <<-END

# arb-Arab@ar
# por-Latn@pt

# hin-Deva@hi

# END
# )

# str=$(printf '%s' "$str" | tr '/' 'a')

# Used to format strings. Compatible with Alpine linux (uses bash)
format_variables () {
    # shellcheck disable=SC2154
    if [ -n "$working_languages" ]; then
        working_languages_str=$(echo "$working_languages" | tr '\r\n' ',' | tr '\n' ',' | sed -e 's/,,/,/g' | sed 's/,$//' | sed 's/^,//')
    fi
    if [ -n "$non_working_languages" ]; then
        non_working_languages_str=$(echo "$non_working_languages" | tr '\r\n' ',' | tr '\n' ',' | sed -e 's/,,/,/g' | sed 's/,$//' | sed 's/^,//')
    fi
    # shellcheck disable=SC2154
    if [ -n "$auxiliary_languages" ]; then
        auxiliary_languages_str=$(echo "$auxiliary_languages" | tr '\r\n' ',' | tr '\n' ',' | sed -e 's/,,/,/g' | sed 's/,$//' | sed 's/^,//')
    fi
}
format_variables

# echo "working_languages $working_languages"
# echo "working_languages_str $working_languages_str"
# exit 1

echo "::group::Debug parameters"
echo "param 1 [[$1]]"
echo "param 2 [[$2]]"
echo "param 3 [[$3]]"
echo "param 4 [[$4]]"
# echo "param $ * $*"
echo "SHELL @ [[$SHELL]]"
echo "GITHUB_WORKSPACE [[$GITHUB_WORKSPACE]]"
echo "WORKDIR [[$WORKDIR]]"
echo "working_languages [[$working_languages]]"
echo "working_languages_str [[$working_languages_str]]"
echo "non_working_languages [[$non_working_languages]]"
echo "non_working_languages_str [[$non_working_languages_str]]"
echo "auxiliary_languages [[$auxiliary_languages]]"
echo "auxiliary_languages_str $auxiliary_languages_str"
echo "source_language [[$source_language]]"
echo "target_language [[$target_language]]"
echo "export_ad_hoc_template [[$export_ad_hoc_template]]"
echo "export_data_exchange_standard [[$export_data_exchange_standard]]"
echo "dump_abstract_syntax_tree [[$dump_abstract_syntax_tree]]"
# cat /etc/*release
# printenv
echo "::endgroup::"

hxltm_action_bin="$1"
hxltm_action_infile="${2:-fontem.ext}"
hxltm_action_outfile="${3:-objectivum.ext}"
hxltm_action_args="$4"

if [ -n "$working_languages_str" ]; then
    hxltm_action_args="$hxltm_action_args --agendum-linguam $working_languages_str"
fi

if [ -n "$non_working_languages_str" ]; then
    hxltm_action_args="$hxltm_action_args --non-agendum-linguam $non_working_languages_str"
fi

if [ -n "$auxiliary_languages_str" ]; then
    hxltm_action_args="$hxltm_action_args --auxilium-linguam $auxiliary_languages_str"
fi

if [ -n "$source_language" ]; then
    hxltm_action_args="$hxltm_action_args --fontem-linguam $source_language"
fi

if [ -n "$target_language" ]; then
    hxltm_action_args="$hxltm_action_args --objectivum-linguam $target_language"
fi

if [ -n "$export_ad_hoc_template" ]; then
    hxltm_action_args="$hxltm_action_args --objectivum-formulam $export_ad_hoc_template"
fi

if [ -n "$export_data_exchange_standard" ]; then
    hxltm_action_args="$hxltm_action_args --objectivum-$export_data_exchange_standard"
fi

if [ -n "$dump_abstract_syntax_tree" ]; then
    hxltm_action_args="$hxltm_action_args --expertum-HXLTM-ASA $dump_abstract_syntax_tree"
fi

# TODO: debug

# if echo "$hxltm_action_bin" | grep -q "hxl"
# then
#     # TODO: simple check for spaces, and etc
#     echo "INFO: [$hxltm_action_bin] Okay"
# else
#     echo "ERROR: [$hxltm_action_bin] not hxltml or libhxl-python binary"
#     exit 1
# fi

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
