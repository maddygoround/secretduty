#!/bin/sh -l
echo "Hello $1"
echo "Mahendra Rathod"
date
ls
whispers ./secrets-not-allowed >> output.txt
echo "hello" >> output.txt
filecontent=`cat output.txt`
echo "::set-output name=time::$filecontent"