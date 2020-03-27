#!/bin/bash

##############################################
#####                                    #####
#####        RUN AT YOUR OWN RISK        #####
#####                                    #####
##############################################

# Script to push and pull git repositories
# 

# pull github files to local repository
echo "Check online repository for updated files"
git pull

# Add file contents to the index
git add --all .

echo 'Enter the commit message:'
read commitMessage

# commit to local repository with message
git commit -m "$commitMessage"

read -p "Enter branch name [master]: " branch
branch=${branch:-master}

# push local files to github
git push -u origin $branch

echo "#####################################"
echo "##          Push Complete          ##"
echo "#####################################"