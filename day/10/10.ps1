#functions
function CheckCycles ($x) {
    if($cycleCounter -in $testResults.keys){
        $($cycleCounter * $x) | Out-Host
        $global:sum += $($cycleCounter * $x)
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

    for ($i=1; $i -le $in.count; $i++){
        $cycleCounter++; CheckCycles $x
        #$operation = $in[$i]
        $addition = [int]($in[$i] -split ' ')[1]
        if ($addition -ne 0){
            $x += $addition
            $cycleCounter++; CheckCycles $x
        }
    }
    Write-Host "Sum $global:sum"
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

