#functions
function ReadOperations {
    param (
        $in
    )
    #operations 
    $op = New-Object 'Object[,]' 2, $in.Count

    for ($y = 0; $y -le $op.GetUpperBound(1); $y++) {
        $op[0, $y] , $op[1, $y] = ($in[$y] -split " ")
    }

    return $op
}

function GetMaxDimensions {
    param (
        $op
    )
    
    $left = $op
    
}

#main
function main {
    param (
        $in
    )
    $op = ReadOperations $in

    GetMaxDimensions $op
}


$data = gc "$PSScriptRoot/data/input"
$testdata = gc "$PSScriptRoot/data/test"
$testResults = 13


Write-Output "`nAnwsers:"
main $testdata
#main $data


