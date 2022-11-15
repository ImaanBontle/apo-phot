#!/usr/bin/env bash

version=$1
if [ "${version}" == "" ]; then
	echo Please specify version number!
	exit 1
fi
echo ${version}: >> tmp.txt
echo ----- >> tmp.txt
cat changes.txt >> tmp.txt
echo >> tmp.txt
cat changelog.txt >> tmp.txt
mv changelog.txt oldchanges.txt
mv tmp.txt changelog.txt
