#functions
function InvestigateThing {
    param (
        $operation,
        [double]$thing
    )
    
    $oper = ((($operation -split " ") -replace 'old','$thing') -join '')
    $tt = Invoke-Expression $oper

    return Invoke-Expression ((($operation -split " ") -replace 'old','$thing') -join '')
}

function PassThing {
    param (
        [double]$thing,
        [double]$test
    )
    return (0 -eq $thing % $test)
}

#main
function main {
    param (
        $r
    )
    $monkeys = ($r | select-string "monkey \d:")
    $startingItems = ($($r | select-string "starting items:") -replace "  Starting items: ")
    $operation = $($r | select-string "Operation: ") -replace "  Operation: new = "
    $test = $($r | select-string "Test: divisible by") -replace "  Test: divisible by "
    $iftrue = $($r | select-string "    If true: throw to monkey ") -replace "    If true: throw to monkey "
    $iffalse = $($r | select-string "    If false: throw to monkey ") -replace "    If false: throw to monkey "

    $z = @()

    foreach($m in (0..($monkeys.count-1))){
        $z += ,@{
            things = $($startingItems[$m]) -split ", "
            op = $operation[$m]
            test = $test[$m]
            iftrue = $iftrue[$m]
            iffalse= $iffalse[$m]
            inspects = 0
        }
    }
    #$z | %{$_.things -join ', '}

    for($round = 1; $round -le 20; $round++){
        for($monkey = 0; $monkey -lt $z.count; $monkey++){
            foreach($t in $z[$monkey].things){
                $new = InvestigateThing $z[$monkey].op $t
                $new = [Math]::Floor($new/3)
                switch (PassThing $new $test[$monkey]) {
                    $true { $z[$iftrue[$monkey]].things += @($new)}
                    $false { $z[$iffalse[$monkey]].things += @($new)}
                }
                $z[$monkey].things = $z[$monkey].things | Select-Object -Skip 1  #$z[$monkey].things[1..(($z[$monkey].things).count)]
                $z[$monkey].inspects += 1
            }
        }
        #$z | %{$_.things -join ', '}
    }
    return $z
}


$data = gc "$PSScriptRoot/data/input"
$testdata = gc "$PSScriptRoot/data/test"
$testResults = 13140

Write-Output "`nAnwsers:"
$inspects = main $testdata
$max1, $max2 = ($inspects | %{$_.inspects} | Sort-Object -Descending)[0..1]
Write-Output ($max1 * $max2)

$inspects = main $data
$max1, $max2 = ($inspects | %{$_.inspects} | Sort-Object -Descending)[0..1]
Write-Output ($max1 * $max2)

