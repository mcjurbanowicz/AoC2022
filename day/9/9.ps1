#functions
function ReadOperations {
    param (
        $in
    )
    #operations
    $op = @()

    for ($y = 0; $y -le $in.count; $y++) {
        $row = ($in[$y] -split " ")
        $op += ,@($row)
        #$op += @{$row[0] = [int]$row[1]}
    }

    return $op
}

function GetMaxDimensions {
    param (
        $op
    )
    
    $stepsum = @{
        U = 0
        D = 0
        R = 0
        L = 0
    }
    foreach ($step in $($stepsum.keys)){
        $stepsum[$step] = (($op | ?{$_.keys -eq $step}).values | Measure -Sum).Sum
    }

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

    GetMaxDimensions $op
}


$data = gc "$PSScriptRoot/data/input"
$testdata = gc "$PSScriptRoot/data/test"
$testResults = 13


Write-Output "`nAnwsers:"
main $testdata
#main $data


