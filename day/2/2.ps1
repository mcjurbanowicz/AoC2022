$data = gc "$PSScriptRoot/data/input"

<#
"A X" = 1 + 3 = 4
"A Y" = 2 + 6 = 8
"A Z" = 3 + 0 = 3
"B X" = 1 + 0 = 1
"B Y" = 2 + 3 = 5
"B Z" = 3 + 6 = 9
"C X" = 1 + 6 = 7
"C Y" = 2 + 0 = 2
"C Z" = 3 + 3 = 6
#>

$scheme = @{
    "A X" = 4
    "A Y" = 8
    "A Z" = 3
    "B X" = 1
    "B Y" = 5
    "B Z" = 9
    "C X" = 7
    "C Y" = 2
    "C Z" = 6
}

$sum = 0
$data | %{$sum += $scheme[$_]}
$sum
