#!/bin/sh -l
ls
whispers ./ >> output.txt
filecontent=`cat output.txt`
echo "$filecontent"
if [ -s output.txt ]; then
  echo "Vulnerabilities found!"
  exit 1
else
    rm -rf output.txt
    echo "::set-output name=result::$filecontent"
fi