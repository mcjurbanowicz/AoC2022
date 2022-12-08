#functions
function Check {
    param (
        $x,
        $y
    )
    $height = $grid[$y][$x]
    $r = 0
    [Array]$vertical = @()
    foreach ($i in (0..($ymax))){
        $vertical += @($grid[$i][$x])
    }
    <#
    if(
        (($grid[$y][0..($x-1)] | measure -Maximum).Maximum -lt $height) -or
        (($grid[$y][$xmax..($x+1)] | measure -Maximum).Maximum -lt $height) -or
        (($grid[$x][0..($y-1)] | measure -Maximum).Maximum -lt $height) -or
        (($grid[$x][$xmax..($y+1)] | measure -Maximum).Maximum -lt $height)
    ){
        return 1
    }
    #>
    if(($grid[$y][0..($x-1)] | measure -Maximum).Maximum -lt $height){
        $r = 1
    }
    if(($grid[$y][$xmax..($x+1)] | measure -Maximum).Maximum -lt $height){
        $r = 1}


    if(($vertical[0..($y-1)] | measure -Maximum).Maximum -lt $height){
        $r=1}
    if(($vertical[$xmax..($y+1)] | measure -Maximum).Maximum -lt $height){
        $r=1}

    #$Write-Output "$x $y $r"
        
    #$resultPart2 += $r
    return $r
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
    $grid
    $result = 2 * ($grid[0].count + $grid.keys.count - 2)

    $xmax = $grid[0].Count -1
    $ymax = $grid.Count -1

    $resultPart2 = 0
    for ($x = 1; $x -lt $xmax; $x++){
        for ($y = 1; $y -lt $ymax; $y++){
            #Check 3 1
            $resultPart2 += Check $x $y
        }
    }

    return ($result + $resultPart2)
}


$data = gc "$PSScriptRoot/data/input"
$testdata = gc "$PSScriptRoot/data/test"
$testResults = 16 + 5

Write-Output "`nAnwsers:"
#main $testdata
main $data


