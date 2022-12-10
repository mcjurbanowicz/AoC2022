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

function CheckIsTailAround {
    param (
        $head,
        $tail
    )
    (($head[0] - $tail[0]) -in (-1..1)) -and
    (($head[1] - $tail[1]) -in (-1..1))
}

function MakeMove {
    param (
        $head,
        $tail,
        $move
    )

    #horizontal
    if($move[1] -eq 0){
        $multiplier = $move[0] / [Math]::Abs($move[0])

        for ($x = 0; $x -ne $move[0]; $x+=$multiplier){
            $head[0] += $multiplier
            #$matrix[$head[0], $head[1]] = 1

            if (-not (CheckIsTailAround $head $tail)){
                $tail[1] = $head[1]
                $tail[0] += $multiplier
                $matrix[$tail[0], $tail[1]] = 1
            }
        }
    }

    #vertical
    if($move[0] -eq 0){
        $multiplier = $move[1] / [Math]::Abs($move[1])

        for ($x = 0; $x -ne $move[1]; $x+=$multiplier){
            $head[1] += $multiplier
            #$matrix[$head[0], $head[1]] = 1

            if (-not (CheckIsTailAround $head $tail)){
                $tail[0] = $head[0]
                $tail[1] += $multiplier
                $matrix[$tail[0], $tail[1]] = 1
            }
        }
    }
    
    return $head, $tail
}

function ReadOperations {
    param (
        $in
    )
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

    #$matrix = New-Object 'object[,]' $(GetMaxDimensions $op) #bug
    $matrix = New-Object 'object[,]' 500,500
    $matrix[0,0] = 1

    $head = @(0, 0)
    $tail = @(0, 0)

    foreach ($movement in $op){
        $head, $tail = MakeMove $head $tail $(ConvertToVector @(0,0) $movement)
        
    }

    return $matrix 
}


$data = gc "$PSScriptRoot/data/input"
$testdata = gc "$PSScriptRoot/data/test"
$testResults = 13


Write-Output "`nAnwsers:"
Write-Output (main $testdata | Measure -Sum).Sum
Write-Output (main $data | Measure -Sum).Sum


