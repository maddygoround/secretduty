#!/bin/sh -l
echo "Hello $1"
echo "Mahendra Rathod"
date
ls
whispers ./secrets-not-allowed >> output.txt
filecontent=`cat output.txt`
echo "$filecontent"
if [ -s output.txt ]; then
  echo "Vulnerabilities found!"
  exit 1
else
    rm -rf output.txt
    echo "::set-output name=result::$filecontent"
fi