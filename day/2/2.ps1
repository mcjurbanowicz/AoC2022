$data = gc "$PSScriptRoot/data/input"

<#
A rock 1
B paper 2
C scissors 3

lose  0
draw 3
win 6 

X1 rock
Y1 paper
Z1 scissors

X2 lose
Y2 draw
Z2 win
#>


<#
"A X" /X1 = 1 + 3 = 4
"A Y" /Y1 = 2 + 6 = 8
"A Z" /Z1 = 3 + 0 = 3
"B X" /X1 = 1 + 0 = 1
"B Y" /Y1 = 2 + 3 = 5
"B Z" /Z1 = 3 + 6 = 9
"C X" /X1 = 1 + 6 = 7
"C Y" /Y1 = 2 + 0 = 2
"C Z" /Z1 = 3 + 3 = 6
#>

$scheme1 = @{
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

<#
    "A X" = /C = 3 + 0 = 3
    "A Y" = /A = 1 + 3 = 4
    "A Z" = /B = 2 + 6 = 8
    "B X" = /A = 1 + 0 = 1
    "B Y" = /B = 2 + 3 = 5
    "B Z" = /C = 3 + 6 = 9
    "C X" = /B = 2 + 0 = 2
    "C Y" = /C = 3 + 3 = 6
    "C Z" = /A = 1 + 6 = 7
#>


$scheme2 = @{
    "A X" = 3
    "A Y" = 4
    "A Z" = 8
    "B X" = 1
    "B Y" = 5
    "B Z" = 9
    "C X" = 2
    "C Y" = 6
    "C Z" = 7
}

$sum1, $sum2 = 0
$data | %{
    $sum1 += $scheme1[$_]
    $sum2 += $scheme2[$_]
}
$sum1, $sum2