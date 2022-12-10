#functions
function CalculatePosition {
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

function ReadOperations {
    param (
        $in
    )
    #operations
    $op = @()

    for ($y = 0; $y -le $in.count; $y++) {
        $row = ($in[$y] -split " ")
        $op += ,@($row)
    }

    return $op
}

function GetMaxDimensions {
    param (
        $op
    )

    $Hmax = @()
    $Vmax = @()
    $Hmin= @()
    $Vmin = @()
    $H = 0
    $V = 0

    foreach ($row in $op){
        switch ($row[0]) {
            U { $V+=$row[1]; $Vmax+=$V}
            D { $V-=$row[1]; $Vmin+=$V}
            R { $H+=$row[1]; $Hmax+=$H}
            L { $H-=$row[1]; $Hmin+=$H}
        }
    }
    $Hmax = ($Hmax | Measure-Object -Maximum).Maximum
    $Vmax = ($Vmax | Measure-Object -Maximum).Maximum

    return $Hmax, $Vmax
}

#main
function main {
    param (
        $in
    )
    $op = ReadOperations $in

    $matrix = New-Object 'object[,]' $(GetMaxDimensions $op)
    1+2
}


$data = gc "$PSScriptRoot/data/input"
$testdata = gc "$PSScriptRoot/data/test"
$testResults = 13


Write-Output "`nAnwsers:"
main $testdata
#main $data


