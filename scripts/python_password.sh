#!/usr/bin/env bash
set -e

cwd=$(pwd)

abspath_portable() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
abs_path=$(abspath_portable "$0")
script_dir=$(dirname "${abs_path}")

script_abs_path=$(readlink "${abs_path}" || echo "${abs_path}")
script_abs_dir=$(cd "$(dirname "${script_abs_path}")" && pwd -P)
script_name="${abs_path#$script_abs_dir/}"
script_abs_name="${script_abs_path#$script_abs_dir/}"

# $script_dir is the absolute path to the script's directory, as
#             called by the user
# $script_abs_dir is the absolute path to the script's directory, all
#                 symlinks resolved
# $script_name is the name of the script only, as called by the user
# $script_abs_name is the name of the script only, all symlinks resolved

cd "${script_abs_dir}" && python python_password.py $*
