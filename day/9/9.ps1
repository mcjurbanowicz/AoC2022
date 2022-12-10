#functions
function MoveHead {
    param (
        $current,
        $move
    )

    switch ($move[0]) {
        R { $current[0] += $move[1] }
        L { $current[0] -= $move[1] }
        U { $current[1] += $move[1] }
        D { $current[1] -= $move[1] }
    }

    return $current

}

function Move {
    param (
        $head,
        $tail,
        $move
    )

    #for ()
    
    $matrix[$tail[0], $tail[1]] = 1
}

function ReadOperations {
    param (
        $in
    )
    #operations
    #[array]$op = $null

    for ($y = 0; $y -lt $in.count; $y++) {
        $row = ($in[$y] -split " ")
        $op += ,@($row)
    }

    return $op
}

function GetMaxDimensions {
    param (
        $op
    )

    $H = @()
    $V = @()

    $startingPoint = @(0,0)

    foreach ($row in $op){
        $startingPoint = MoveHead $startingPoint $row
        $H += $startingPoint[0]
        $V += $startingPoint[1]
    }

    $Hmax = 1 + ($H | Measure-Object -Maximum).Maximum
    $Vmax = 1 + ($V | Measure-Object -Maximum).Maximum

    return $Hmax, $Vmax
}

#main
function main {
    param (
        $in
    )
    $op = ReadOperations $in

    $matrix = New-Object 'object[,]' $(GetMaxDimensions $op)
    $matrix[0,0] = 1

    $head = @(0, 0)
    $tail = @(0, 0)

    foreach ($o in $op){
        MoveHead $head $o
        
    }
    $matrix
}


$data = gc "$PSScriptRoot/data/input"
$testdata = gc "$PSScriptRoot/data/test"
$testResults = 13


Write-Output "`nAnwsers:"
main $testdata
#main $data


