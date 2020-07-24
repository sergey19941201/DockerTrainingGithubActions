param($branch_name, $week_number)

function CheckIfBranchExists()
{
    "Input week number:"
    $week_number
    
    [string]$branchList = git branch -a

    if($branchList -Match $branch_name)
    {
        $Env:BUILD_SHOULD_CREATE_NEW_RC_OUTPUT = "false"

        return "branch exists";
    }

    $reminderOfDivision = $week_number % 3
    "reminderOfDivision:"
    $reminderOfDivision

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