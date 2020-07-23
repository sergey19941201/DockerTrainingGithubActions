function GetCurrentWeek()
{

    $Env:BUILD_BRANCH_NAME_OUTPUT = "hhh"
    
    git status

    git show-branch -a

    return "";
}

$branchName = GetCurrentWeek;

Write-Host "##[branchName '$branchName']"