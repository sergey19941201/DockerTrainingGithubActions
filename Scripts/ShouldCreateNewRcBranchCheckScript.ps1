param($branch_name, $year_week)

function CheckIfBranchExists()
{
    [string]$branchList = git branch -a

    if($branchList -Match $branch_name)
    {
        $Env:BUILD_SHOULD_CREATE_NEW_RC_OUTPUT = "false"

        return "branch exists";
    }

    $reminderOfDivision = $year_week % 3

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