#!/usr/bin/env bash

version=$1
if [ "${version}" == "" ]; then
	echo Please specify version number!
	exit 1
fi
release=$2
if [ "${release}" == "" ]; then
	echo Please specify release type!
	exit 2
fi
git push origin ${release}-${version}
gh pr create --fill
