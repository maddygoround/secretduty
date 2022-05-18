#!/bin/sh -l
echo "Hello $1"
whispers ./ >> output.txt
filecontent=$(cat output.txt)
echo "::set-output name=time::$filecontent"