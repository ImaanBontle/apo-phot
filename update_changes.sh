#!/usr/bin/env bash

cat new_changes.txt >> tmp.txt
cat changes.txt >> tmp.txt
mv changes.txt backup_changes.txt
mv tmp.txt changes.txt
mv new_changes.txt backup_new.txt
git commit -a -F "backup_new.txt"
touch new_changes.txt
