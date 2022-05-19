#!/bin/sh -l
echo "$1" >> input.txt
t=`sed -e 's/\[//g' -e 's/\]//g' -e 's/,$//' < input.txt`
echo $t

if [ "${t}" ]; then
  echo "execute with severity - $t"
  whispers --severity $t ./ >> output.txt
else
  whispers ./ >> output.txt
fi

filecontent=`cat output.txt`

echo "$filecontent"

if [ -s output.txt ]; then
  echo "Vulnerabilities found!"
  exit 1
else
    rm -rf output.txt
    echo "::set-output name=result::$filecontent"
fi