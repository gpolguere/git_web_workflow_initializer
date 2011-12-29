#!/bin/bash
originalPath=`pwd`
remoteAlias="beanstalk"

cd $1
remoteRepositories=`git remote -v`

for s in $remoteRepositories; do
	if [ $s = "(fetch)" ]
	then
		remoteRepository=$registeredRepository
	fi
	registeredRepository=$s
done

git init
git remote add $remoteAlias $remoteRepository

touch README
initMessage="Initialized with 3 branches : prod, preprod, dev"
echo $initMessage > README

git add . 
git commit -m "Repository Initialized with by_git_init"
git push $remoteAlias master

git checkout master
git branch prod
git checkout prod
git push $remoteAlias prod

git checkout master
git branch preprod
git checkout preprod
git push $remoteAlias preprod

git checkout master
git branch dev
git checkout dev
git push $remoteAlias dev

#git push $remoteAlias :master
#git branch -d master

cd $originalPath