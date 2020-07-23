function GetCurrentWeek()
{

    $Env:BUILD_BRANCH_NAME_OUTPUT = "hhh"
    
    git status

    git branch -a

    return "";
}

$branchName = GetCurrentWeek;

Write-Host "##[branchName '$branchName']"