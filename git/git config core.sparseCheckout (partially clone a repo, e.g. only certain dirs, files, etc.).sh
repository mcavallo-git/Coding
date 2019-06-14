#!/bin/bash
#
# ------------------------------------------------------------
#
#	git config core.sparseCheckout 
#	 |--> partially clone a repo, e.g. only certain dirs, files, etc.
#
# ------------------------------------------------------------
#
#	[ Begin citation.1 (see citation(s), below) ...]
#
# What you are trying to do is called a sparse checkout, and that feature was added in git 1.7.0 (Feb. 2012). The steps to do a sparse clone are as follows:
mkdir <repo>
cd <repo>
git init
git remote add -f origin <url>
# This creates an empty repository with your remote, and fetches all objects but doesn't check them out. Then do:
#
git config core.sparseCheckout true
# Now you need to define which files/folders you want to actually check out. This is done by listing them in .git/info/sparse-checkout, eg:
#
echo "some/dir/" >> .git/info/sparse-checkout
echo "another/sub/tree" >> .git/info/sparse-checkout
# Last but not least, update your empty repo with the state from the remote:
#
git pull origin master
# You will now have files "checked out" for some/dir and another/sub/tree on your file system (with those paths still), and no other paths present.
#
# You might want to have a look at the extended tutorial and you should probably read the official documentation for sparse checkout.
#
# As a function:
function git_sparse_clone() (
	rurl="$1" localdir="$2" && shift 2

	mkdir -p "$localdir"
	cd "$localdir"

	git init
	git remote add -f origin "$rurl"

	git config core.sparseCheckout true

	# Loops over remaining args
	for i; do
		echo "$i" >> .git/info/sparse-checkout
	done

	git pull origin master
)
#
# Usage:
git_sparse_clone "http://github.com/tj/n" "./local/location" "/bin"
#
#
#	[ End citation.1 ]
#
# ------------------------------------------------------------
#
#	Citation(s)
#
#	1) Thanks to StackOverflow users [ Chronial ] & [ Nick Bull ] on forum [ https://stackoverflow.com/a/13738951 ]
#
# ------------------------------------------------------------