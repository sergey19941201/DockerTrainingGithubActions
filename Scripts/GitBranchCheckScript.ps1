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
    [string]$branchName = "";
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
        $branchName ="rc/17.3."+$currentYear+"{0:d2}" -f $currentWeek+";
    }

    $Env:BUILD_BRANCH_NAME_OUTPUT = $branchName
    
    git status

    return $branchName;
}

$branchName = GetCurrentWeek;

Write-Host "##[branchName '$branchName']"