#!/bin/bash
echo "$1" >> input.txt
t=`sed -e 's/\[//g' -e 's/\]//g' -e 's/,$//' -e "s/['\"]//g" < input.txt`
whispers --severity $t ./ >> output.txt
filecontent=`cat output.txt`
rm -rf input.txt output.txt
if [[ $filecontent ]]; then
  echo "Breaking vulnerabilities found!"
  echo "::set-output name=result::$filecontent"
  exit 1
else
    echo "::set-output name=result::$filecontent"
fi