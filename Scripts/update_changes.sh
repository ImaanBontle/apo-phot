#!/usr/bin/env bash

cat Logs/recent_changes.txt >> tmp.txt
cat Logs/new_changes.txt >> tmp.txt
mv Logs/new_changes.txt Logs/Backups/new_changes_backup.txt
mv Logs/recent_changes.txt Logs/Backups/recent_changes_backup.txt
mv tmp.txt Logs/recent_changes.txt
touch Logs/new_changes.txt
