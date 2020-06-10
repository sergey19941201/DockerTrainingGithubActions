#!/bin/sh -l

echo "ReadFileContent $1"
echo "some custom text for testing"

yourfilenames=`ls`
for eachfile in $yourfilenames
do
   echo $eachfile
done


sed -i 's/love/nolove/g' my_package.txt

input="my_package.txt"
txtresult=""
while IFS= read -r line
do
  echo "$line"
  txtresult="$txtresult""$line"
done < "$input"

sed -i 's/$android:versionName/myVersionName/g' AndroidManifest.xml

xmlinput="AndroidManifest.xml"
xmlresult =""
while IFS= read -r line
do
  echo "$line"
  xmlresult="$xmlresult""$line"
done < "$xmlinput"


echo "::set-output name=result_text::$txtresult"
echo "::set-output name=result_xml::$xmlresult"