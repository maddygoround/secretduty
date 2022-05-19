#!/bin/sh -l
echo "$1"
t=$(sed -e 's/\[//g' -e 's/\]//g' -e 's/,$//' <<< $1)
echo $t
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