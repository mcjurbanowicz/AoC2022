#functions
function DisplayRope {
    param (
        $r
    )
    
    $j = @()
    foreach ($l in 0..50){
        $j += ,@(("_" * 50) -split '')
    }

    for($segment=0; $segment -lt $r.count; $segment++){
        $j[$($r[$segment][1])][$($r[$segment][0])] = $segment
        if ($segment -eq ($r.count-1)) {
            $t[$($r[$segment][1])][$($r[$segment][0])] = "x"
        }
    }
    
    foreach ($line in (($m.count-1)..0)){
        "$($j[$line] -join '') $line" | Out-Host
    }
    "012345678901234567890123456789 $movement" | Out-Host
    Sleep 0.0
}

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
        $rope,
        $move
    )

    #horizontal
    if($move[1] -eq 0){
        switch ($move[0] -gt 0) {
            $true { $multiplier = 1}
            $false { $multiplier = -1 }
        }

        for ($x = 0; $x -ne $move[0]; $x+=$multiplier){
            #Move head
            $rope[0][0] = $rope[0][0] + $multiplier
            #DisplayRope $rope

            #Move other segments
            for($i=1; $i -ne $rope.count; $i++){
                if (-not (CheckIsTailAround $rope[$i-1] $rope[$i])){
                    #rope[$i-1] - head (previous segment)
                    #rope[$i] - tail (the segment behind head)

                    switch ($rope[$i-1][1] - $rope[$i][1]) {
                        1 { $rope[$i][1]++}
                        2 { $rope[$i][1]++}
                        -1 { $rope[$i][1]-- }
                        -2 { $rope[$i][1]-- }
                        Default {}
                    }

                    switch ($rope[$i-1][0] - $rope[$i][0]) {
                        1 { $rope[$i][0]++}
                        2 { $rope[$i][0]++}
                        -1 { $rope[$i][0]-- }
                        -2 { $rope[$i][0]-- }
                        Default {}
                    }

                    #DisplayRope $rope
                }
                #Note position of last element of rope
                $matrix[$rope[$rope.count-1][0], $rope[$rope.count-1][1]] = 1
            }
        }
    
    }

    #vertical
    if($move[0] -eq 0){
        switch ($move[1] -gt 0) {
            $true { $multiplier = 1}
            $false { $multiplier = -1 }
        }

        for ($y = 0; $y -ne $move[1]; $y+=$multiplier){
            #Move head
            $rope[0][1] = $rope[0][1] + $multiplier
            #DisplayRope $rope

            #Move other segments
            for($i=1; $i -ne $rope.count; $i++){
                if (-not (CheckIsTailAround $rope[$i-1] $rope[$i])){
                    #rope[$i-1] - head (previous segment)
                    #rope[$i] - tail (the segment behind head)

                    switch ($rope[$i-1][1] - $rope[$i][1]) {
                        1 { $rope[$i][1]++}
                        2 { $rope[$i][1]++}
                        -1 { $rope[$i][1]-- }
                        -2 { $rope[$i][1]-- }
                        Default {}
                    }
                    switch ($rope[$i-1][0] - $rope[$i][0]) {
                        1 { $rope[$i][0]++}
                        2 { $rope[$i][0]++}
                        -1 { $rope[$i][0]-- }
                        -2 { $rope[$i][0]-- }
                        Default {}
                    }

                    #DisplayRope $rope
                }
                #Note position of last element of rope
                $matrix[$rope[$rope.count-1][0], $rope[$rope.count-1][1]] = 1
            }
        }
    }
    #DisplayRope $rope
    return $rope
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
        $in,
        $rope
    )
    $op = ReadOperations $in

    #$matrix = New-Object 'object[,]' $(GetMaxDimensions $op) #bug
    $matrix = New-Object 'object[,]' 500,500
    $matrix[$rope[0][0],$rope[0][1]] = 1

    $m, $t = @()
    foreach ($l in 0..50){
        $m += ,@(("_" * 51) -split '')
        $t += ,@(("_" * 51) -split '')
    }
    

    #$aa2 = @(); ($g -split "") | %{$aa2 += ,@($_)}

    #$m = $m.ToCharArray()
    #$t = $t.ToCharArray()

    foreach ($movement in $op){
        $rope = MakeMove $rope $(ConvertToVector @(0,0) $movement)
    }

    return $matrix 
}


$data = gc "$PSScriptRoot/data/input"
$rope = @(
    @(1,1),
    @(1,1),
    @(1,1),
    @(1,1),
    @(1,1),
    @(1,1),
    @(1,1),
    @(1,1),
    @(1,1),
    @(1,1)
)

$testdata = gc "$PSScriptRoot/data/test"
$testdata2 = gc "$PSScriptRoot/data/test2"
$testResults = 13
$testResults2 = 36

$testRope = @(
    @(1,1),
    @(1,1)
)

$testrope2 = @(
    @(11,5),
    @(11,5),
    @(11,5),
    @(11,5),
    @(11,5),
    @(11,5),
    @(11,5),
    @(11,5),
    @(11,5),
    @(11,5)
)


Write-Output "`nAnwsers:"
#Write-Output (main $testdata $testrope | Measure -Sum).Sum
#Write-Output (main $testdata $rope | Measure -Sum).Sum
#Write-Output (main $testdata2 $testrope | Measure -Sum).Sum

#Write-Output (main $testdata2 $testrope2 | Measure -Sum).Sum
Write-Output (main $data $rope | Measure -Sum).Sum


