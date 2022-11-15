#!/usr/bin/env bash

version=$1
if [ "${version}" == "" ]; then
	echo Please specify version number!
	exit 1
fi
git switch main
git pull
git tag -a v${version} -m "Bumped version number to v${version}"
git push origin v${version}
gh release create v${version} changelog.txt Apo_Phot.ipynb -t "apo-phot_v${version}" --generate-notes -d
