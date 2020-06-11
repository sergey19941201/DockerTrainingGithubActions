##############################################
#Script Title: Download File PowerShell Tool
#Script File Name: Download-File.ps1 
#Author: Ron Ratzlaff  
#Date Created: 4/21/2016 
##############################################

#Requires -Version 3.0
function Get-WeekNumber([datetime]$DateTime = (Get-Date)) {
    $cultureInfo = [System.Globalization.CultureInfo]::CurrentCulture
    return $cultureInfo.Calendar.GetWeekOfYear($DateTime,$cultureInfo.DateTimeFormat.CalendarWeekRule,$cultureInfo.DateTimeFormat.FirstDayOfWeek)
}

function GetCurrentWeek()
{
    param([string]$branch)
    $buildCounter = "%build.counter%";

    [string]$assemblyVersion =  "%AssemblyVersion%";

    if($assemblyVersion -ne "0.0.0.0")
    {
        return $assemblyVersion;
    }
    
    [string]$buildNumber = "";
    if($branch.StartsWith("develop"))
    {
        [datetime]$startDate =  Get-Date -Date "2019-09-30 00:00:00Z"
        [datetime]$currentDate = Get-Date ;
        While((New-TimeSpan -Start $startDate -End $currentDate).Days -gt 21)
        {
            $startDate = $startDate.AddDays(21);
        }

       
        [int]$currentWeek =  Get-WeekNumber($startDate)
        $currentYear = Get-Date  $startDate -UFormat "%Y";
        [string]$currentYear = $currentYear.Substring($currentYear.Length - 2)
        $buildNumber ="17.3."+$currentYear+"{0:d2}" -f $currentWeek+"."+$buildCounter;
    }

    if($branch.StartsWith("master"))
    {
      [string]$masterVersion = "%MasterVersion%";
      $buildNumber =  $masterVersion +"."+$buildCounter;
    }

   

    if($branch.StartsWith("rc"))
    {
       $buildNumber =  $branch.substring(3)+"."+$buildCounter;
    }

    if($branch.StartsWith("release") -and !($branch.StartsWith("release/NG-Specific")))
    {
       $buildNumber =  $branch.substring(8)+"."+$buildCounter;
    }

    if($buildNumber -eq "")
    {
       $buildNumber =  "17.3.0."+$buildCounter;
    }

    return $buildNumber;
}

# This gets the name of the current Git branch. 
$branch = "%teamcity.build.branch%"

Write-Host "Branch: $branch"

$buildNumber = GetCurrentWeek -branch $branch;

$splitVersion = $buildNumber.Split('.')
$ApkNumber = $splitVersion[2]+$splitVersion[3]

Write-Host "##teamcity[buildNumber '$buildNumber']"

$splitVersion = $buildNumber.Split('.')
$ApkNumber = $splitVersion[2]+$splitVersion[3]

Write-Host "s: " $ApkNumber

$changeVersionName = 'android:versionName="' +$buildNumber +'"';
$changeVersionCode = 'android:versionCode="' +$ApkNumber +'"';

(Get-Content .\MobileAccess\MobileAccess.Droid\Properties\AndroidManifest.xml) `
-replace 'android:versionName="\d+.\d+.\d+.\d+"', $changeVersionName `
    -replace 'android:versionCode="\d+"', $changeVersionCode |
  Out-File .\MobileAccess\MobileAccess.Droid\Properties\AndroidManifest.xml -Encoding UTF8


  $keystorePassword = "%KeystorePassword%";
  $changekeystorePassword= '<AndroidSigningKeyPass>' +$keystorePassword +'</AndroidSigningKeyPass>';
  $changeAndroidSigningStorePass= '<AndroidSigningStorePass>' +$keystorePassword +'</AndroidSigningStorePass>';

(Get-Content .\MobileAccess\MobileAccess.Droid\MobileAccess.Droid.csproj) `
-replace '<AndroidSigningKeyPass>.+<\/AndroidSigningKeyPass>', $changekeystorePassword `
    -replace '<AndroidSigningStorePass>.+<\/AndroidSigningStorePass>', $changeAndroidSigningStorePass `
     -replace '<AndroidKeyStore>.+<\/AndroidKeyStore>', '<AndroidKeyStore>true</AndroidKeyStore>' |
  Out-File .\MobileAccess\MobileAccess.Droid\MobileAccess.Droid.csproj -Encoding UTF8