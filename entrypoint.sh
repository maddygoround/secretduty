#!/bin/sh -l
t=`sed -e 's/\[//g' -e 's/\]//g' -e 's/,$//' -e "s/['\"]//g" < $1`
whispers --severity $t ./ >> output.txt
filecontent=`cat output.txt`
if [ -s output.txt ]; then
  echo "Vulnerabilities found!"
  echo "::set-output name=result::$filecontent"
  # rm -rf input.txt
  rm -rf output.txt
  exit 1
else
    # rm -rf input.txt
    rm -rf output.txt
    echo "::set-output name=result::$filecontent"
fi