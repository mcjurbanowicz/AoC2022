$data = gc "$PSScriptRoot/data/input"

$elfs = @{}
$currentInv = @()
$count = 1

foreach ($line in $data) {
    if($line -ne ""){
        $currentInv += $line
    }
    else{
        $elfs += @{$count = $currentInv}
        $currentInv = @()
        $count += 1
    }
}

$elfsSummed = @{}

foreach ($elf in $elfs.keys){
    $sum = 0
    $elfs[$elf] | %{$sum += $_}
    $elfsSummed += @{$elf = $sum}
}

$elfsSummed.values | Measure-Object -Maximum