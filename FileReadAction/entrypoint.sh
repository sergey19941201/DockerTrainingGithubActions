#!/bin/sh -l

echo "ReadFileContent $1"
echo "some custom text for testing"

yourfilenames=`ls`
for eachfile in $yourfilenames
do
   echo $eachfile
done

input="my_package.txt"
while IFS= read -r line
do
  echo "$line"
done < "$input"

sed -i 's/love/nolove/g' my_package.txt

input="my_package.txt"
result=""
while IFS= read -r line
do
  echo "$line"
  result="$result""$line"
done < "$input"


echo "::set-output name=surname::$result"