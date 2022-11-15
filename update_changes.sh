#!/usr/bin/env bash

cat new_changes.txt >> tmp.txt
cat recent_changes.txt >> tmp.txt
mv new_changes.txt new_changes_backup.txt
mv recent_changes.txt changes_backup.txt
mv tmp.txt recent_changes.txt
touch new_changes.txt
