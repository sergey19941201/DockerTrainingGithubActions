#!/bin/sh -l

echo "ReadFileContent $1"
value=`\MobileAccess\MobileAccess.Droid\Properties\AndroidManifest.xml`
echo "::set-output name=surname::$value"
