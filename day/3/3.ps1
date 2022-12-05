$data = gc "$PSScriptRoot/data/input"

$points = "0abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
$global:pointsSum1 = 0
$global:pointsSum2 = 0

function Get-PointValue ($inputList){
    $sum = 0
    $inputList | %{$sum += $points.IndexOf($_)}
    return $sum
}

function Get-Badge ($obj){
    $refObj = $obj[0].ToCharArray()
    foreach ($difObj in $obj[1..$obj.length]){
        $refObj = (Compare-Object -ReferenceObject $refObj -DifferenceObject $difObj.ToCharArray() -ExcludeDifferent).InputObject | Select-Object -Unique
    }
    return $refObj
}

$data | ?{($_.length % 2) -ne 0} | %{Throw "Odd number of items in racksack"}

foreach ($racksack in $data){
    $racksackLenght = $racksack.Length
    $compartment1 = $racksack[0..$($racksackLenght/2 - 1)]
    $compartment2 = $racksack[$($racksackLenght/2)..$racksackLenght]
    $global:pointsSum1 += Get-PointValue $((Compare-Object $compartment1 $compartment2 -CaseSensitive -ExcludeDifferent).InputObject | Select-Object -Unique)
}


$groupSize = 3
if(-Not $data % $groupSize){Throw "Elfs cannot be divided into groups of $groupSize"}

for($i=0; $i+$groupSize -le $data.Count ;$i+=$groupSize){
    $group = $data[$i..($i+$groupSize-1)]
    $global:pointsSum2 += Get-PointValue (Get-Badge $group)
}

$global:pointsSum1
$global:pointsSum2