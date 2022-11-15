#!/usr/bin/env bash

version=$1
if [ ${version} == "" ]; then
	echo "Please provide version number!"
	exit 1
fi
echo "v${version}" >> tmp.txt
echo "-----" >> tmp.txt
cat recent_changes.txt >> tmp.txt
mv recent_changes.txt changes_backup.txt
mv tmp.txt changes.txt
cat changes.txt >> tmp.txt
echo "\n" >> tmp.txt
cat changelog.txt >> tmp.txt
mv changelog.txt changelog_backup.txt
mv tmp.txt changelog.txt
touch new_changes.txt
