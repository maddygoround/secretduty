#!/bin/sh -l
echo "$1" >> input.txt
t=`sed -e 's/\[//g' -e 's/\]//g' -e 's/,$//' < input.txt`
echo $t
whispers --severity "$t" ./ >> output.txt
whispers ./ >> output1.txt
cat output.txt
cat output1.txt
filecontent=`cat output.txt`
if [ -s output.txt ]; then
  echo "Vulnerabilities found!"
  echo "::set-output name=result::$filecontent"
  exit 1
else
    rm -rf output.txt
    echo "::set-output name=result::$filecontent"
fi