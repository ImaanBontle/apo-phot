#!/usr/bin/env bash

version=$1
if [ "${version}" == "" ]; then
	echo "Please provide version number!"
	exit 1
fi
echo "v${version}" >> tmp.txt
echo "-----" >> tmp.txt
cat Logs/recent_changes.txt >> tmp.txt
mv Logs/recent_changes.txt Logs/Backups/recent_changes_backup.txt
cp tmp.txt Logs/changes.txt
echo -e "\n" >> tmp.txt
cat Logs/changelog.txt >> tmp.txt
mv Logs/changelog.txt Logs/Backups/changelog_backup.txt
mv tmp.txt Logs/changelog.txt
touch Logs/recent_changes.txt
