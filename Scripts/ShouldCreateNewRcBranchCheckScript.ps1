param($branch_name)

function CheckIfBranchExists()
{
    [string]$branchList = git branch -a

    if($branchList -Match $branch_name)
    {
        $Env:BUILD_SHOULD_CREATE_NEW_RC_OUTPUT = "false"

        return "branch exists";
    }

    $reminderOfDivision = 11 % 2

    if($reminderOfDivision -ne 0)
    {
        $Env:BUILD_SHOULD_CREATE_NEW_RC_OUTPUT = "false"

        return "branch should not be created this week";
    }

    $Env:BUILD_SHOULD_CREATE_NEW_RC_OUTPUT = "true"
    
    return "branch does not exist";
}

$branchExists = CheckIfBranchExists;

Write-Host "##[branchName '$branchExists']"