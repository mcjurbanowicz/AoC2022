#functions
function CountScore {
    param (
        $ar,
        $height
    )
    $counter = 1

    foreach ($tree in $ar){
        if($tree -lt $height){
            $counter++
        }
        else{
            Break
        }
    }
    if($counter -gt $ar.count){
        return $ar.count
    }
    return $counter
}

function Check {
    param (
        $x,
        $y
    )
    $height = $grid[$y][$x]

    [Array]$vertical = @()
    foreach ($i in (0..($ymax))){
        $vertical += @($grid[$i][$x])
    }

    $score = @{
        left = 0
        right = 0
        up = 0
        bottom = 0
    }

    #left
    $score.left = CountScore $grid[$y][($x-1)..0] $height

    #right
    $score.right = CountScore $grid[$y][($x+1)..$xmax] $height

    #up
    $score.up = CountScore $vertical[($y-1)..0]  $height

    #bottom
    $score.bottom = CountScore $vertical[($y+1)..$xmax]  $height

    $scoreValue = $score.right * $score.up * $score.left * $score.bottom

    #$Write-Output "$x $y $r"


    #return $r

    return $scoreValue
}

#main
function main {
    param (
        $in
    )

    $grid = @{}

    for ($d = 0;  $d -lt $in.count; $d++){
        $row = ($in[$d] -split "")
        $grid[$d] = $row[1..($row.length-2)]
    }
    #$grid

    $xmax = $grid[0].Count -1
    $ymax = $grid.Count -1

    $resultPart2 = @()
    for ($x = 1; $x -lt $xmax; $x++){
        for ($y = 1; $y -lt $ymax; $y++){
            #Check 3 1
            Check 2 3
            $resultPart2 += @(Check $x $y)
        }
    }

    return $resultPart2
}


$data = gc "$PSScriptRoot/data/input"
$testdata = gc "$PSScriptRoot/data/test"
$testResults = 16 + 5

Write-Output "`nAnwsers:"
#$resultfinal = main $testdata
$resultfinal = main $data
($resultfinal | measure -Maximum).Maximum

