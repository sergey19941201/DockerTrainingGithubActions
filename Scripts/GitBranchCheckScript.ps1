param($branch_name)

function CheckIfBranchExists()
{
    $branch_name

    [string]$branchList = git branch -a

    if($branchList -Contains $branch_name)
    {
        "FALSE"
        $Env:BUILD_SHOULD_CREATE_NEW_RC_OUTPUT = "false"

        return "branch exists";
    }

    $Env:BUILD_SHOULD_CREATE_NEW_RC_OUTPUT = "true"
    
    return "branch does not exist";
}

$branchExists = CheckIfBranchExists;

Write-Host "##[branchName '$branchExists']"