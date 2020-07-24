param($branch_name)

function CheckIfBranchExists()
{
    [string]$branchList = git branch -a

    if($branchList -Match $branch_name)
    {
        $Env:BUILD_SHOULD_CREATE_NEW_RC_OUTPUT = "false"

        return "branch exists";
    }

    $Env:BUILD_SHOULD_CREATE_NEW_RC_OUTPUT = "true"
    
    return "branch does not exist";
}

$branchExists = CheckIfBranchExists;

Write-Host "##[branchName '$branchExists']"