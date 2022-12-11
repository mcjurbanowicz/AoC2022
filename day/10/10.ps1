#functions

#main
function main {
    param (
        $in
    )
    #adding 0th value
    $in = @('fakenoop') + $in
    #operation time in cycles
    $step = 2

    for ($i=1; $i -le 220; $i++){

        $addition = [int]($in[$i] -split ' ')[1]
        if ($addition -ne 0){
            $book[$i + $step] += $addition
        }
        
        #if("Int32" -eq $addition.gettype().Name){
        
        $x += $book[$i]
        if($i -in $testResults.keys){
            Write-Output ($i * $x)
        }
    }
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

$testdata 
$x = 1
$book = @{}


Write-Output "`nAnwsers:"
#main $data
main $testdata
