#!/bin/sh -l

echo "ReadFileContent $1"
echo "::set-output name=surname::Get-Content .\MobileAccess\MobileAccess.Droid\Properties\AndroidManifest.xml"
