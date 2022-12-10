#functions
function ConvertToVector {
    param (
        $position,
        $move
    )

    switch ($move[0]) {
        R { $position[0] += $move[1] }
        L { $position[0] -= $move[1] }
        U { $position[1] += $move[1] }
        D { $position[1] -= $move[1] }
    }

    return $position

}

function MakeMove {
    param (
        $head,
        $tail,
        $move
    )
    #head always moves in single direction
    if(($move[0]+$move[1]) -lt 0){
        $multiplier = -1
    }
    $multiplier = 1


    for ($x = 0; $x -lt $move[0]; $x++){
        $head[0] += $multiplier
        

        
        $matrix[$head[0], $head[1]] = 1
        $matrix[$tail[0], $tail[1]] = 1
        
    }
    for ($y = 0; $y -lt $move[1]; $y++){
        $head[1] += $multiplier

        $matrix[$head[0], $head[1]] = 1
        $matrix[$tail[0], $tail[1]] = 1
    }
    return $head, $tail


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
        $startingPoint = ConvertToVector $startingPoint $row
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

    foreach ($movement in $op){
        MakeMove $head $tail $(ConvertToVector @(0,0) $movement)
        
    }
    $matrix
}


$data = gc "$PSScriptRoot/data/input"
$testdata = gc "$PSScriptRoot/data/test"
$testResults = 13


Write-Output "`nAnwsers:"
main $testdata
#main $data


