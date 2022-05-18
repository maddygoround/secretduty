#!/bin/sh -l
echo "Hello $1"
echo "Mahendra"
whispers ./secrets-not-allowed >> output.txt
filecontent=`cat output.txt`
echo "$filecontent"
echo "::set-output name=time::$filecontent"