#!/bin/bash
#
# rename.sh: A Bash implementation of Perl rename
#
# Copyright (C) 2016 Panagiotis Theocharis <ptheoch@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

display_usage() {
    echo -e "Usage: $(basename $0) [-n] 's/../../' <FILES>"
}

# Check whether user had supplied -h or --help . If yes display usage
if [[ ( $1 == "--help") ||  $1 == "-h" ]]; then
    display_usage
    exit 0
fi

# Check for OPTIONS
if [[ $1 == -[a-z] ]]
then
    if [[ $1 == "-n" ]]; then
        COMMAND=$1
        shift
    else
        >&2 echo "ERROR: Unrecognised option '$1'"
        display_usage
        exit 1
    fi
fi

# Check for sed regular expression
if [[ "$1" == s/*/*/ ]]; then
    PATTERN=$1
    shift
else
    >&2 echo "ERROR: Unsupported regular expression '$1'"
    display_usage
    exit 2
fi

# Check for <FILES>
if (( $# == 0 )); then
    >&2 echo "ERROR: No files provided for renaming"
    display_usage
    exit 3
fi


while [[ -n "$1" ]]; do
    f=$1
    shift
    a="$(echo "$f" | sed "$PATTERN")"
    if [[ "$f" != "$a" ]]; then
        echo "$f" ">" "$a"
        if [[ "$COMMAND" != "-n" ]]; then
            mv "$f" "$a"
        fi
    fi
done
