function GetCurrentWeek()
{

    $Env:BUILD_BRANCH_NAME_OUTPUT = "hhh"
    
    git branch -a

    return "";
}

$branchName = GetCurrentWeek;

Write-Host "##[branchName '$branchName']"