#!/bin/sh
to_check=$(git diff --name-only --cached --diff-filter=d | grep '\.ex')
to_check_len=$(echo ${to_check} | wc -l)

if [ "${to_check_len}" = 1 ] && [ "${to_check}" = "" ]; then
  echo "no files to be formatted"
  exit 0
fi

echo "files to be checked ${to_check} (${to_check_len})"
mix format --check-formatted ${to_check}
if [ $? = 1 ]; then
  echo "commit failed due to format issues ..."
  exit 1
fi
