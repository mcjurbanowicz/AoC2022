#functions
function CheckCycles ($x) {
    if($cycleCounter -in $testResults.keys){
        $($cycleCounter * $x) | Out-Host
        $global:sum += $($cycleCounter * $x)
    }
}

function DrawPixel {
    if($cycleCounter -in $sprite){
        $screen[$cycleCounter-1] = '#'
    }
    else{
        $screen[$cycleCounter-1] = '.'
    }
}

function Display {
    for($line=0; $line -lt 6; $line++){
        $screen[($line * 40)..(39 + $line *40 )] -join ''| Out-Host
    }
}

#main
function main {
    param (
        $in
    )
    #adding 0th value
    $in = @('fakenoop') + $in
    $x = 1
    $cycleCounter = 1
    $global:sum = 0
    $screen = ('`' * 300).ToCharArray()
    $vertical = 0
    $sprite = @(($x + $vertical * 40), ($x+1 + $vertical * 40), ($x+2 + $vertical * 40))

    for ($i=1; $i -le $in.count; $i++){
        DrawPixel; Display; $cycleCounter++; CheckCycles $x
        #$operation = $in[$i]
        $addition = [int]($in[$i] -split ' ')[1]
        if ($addition -ne 0){
            DrawPixel; Display; $cycleCounter++; CheckCycles $x

            $x += $addition
            $vertical = [Math]::Floor(($cycleCounter-1)/40)
            
            $sprite = @(($x + $vertical * 40), ($x+1 + $vertical * 40), ($x+2 + $vertical * 40))
        }
    }
    Write-Host "Sum $global:sum"
    #$screen = $screen[1..$screen.count]
    Display
}

$data = gc "$PSScriptRoot/data/input"
$testdata = gc "$PSScriptRoot/data/test"
$testResults = @{
    20 = 420
    60 = 1140
    100 = 1800
    140 = 2940
    180 = 2880
    220 = 3960
}

Write-Output "`nAnwsers:"
main $data
#main $testdata

