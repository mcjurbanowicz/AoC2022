#functions
function Get-SectionList ($givenRange) {
    $sections = ($givenRange -split "-") 
    return ($sections[0]..$sections[1])
}

#main
function main {
    param (
        $in,
        [int]$step
    )

    for ($i=$step; $i -lt $in.Length; $i++){
        $chars = $in[($i-$step)..($i-1)] | Select -Unique
        if($chars.Length -eq $step){
            return $i
        }
    }
}

# Tests
Describe "Tests" {
    It "A0" {
        (main $testdataA0 $step1) | Should -Be $testresults["A"][0]
    }

    It "A1" {
        (main $testdataA1 $step1) | Should -Be $testresults["A"][1]
    }

    It "A2" {
        (main $testdataA2 $step1) | Should -Be $testresults["A"][2]
    }

    It "A3" {
        (main $testdataA3 $step1) | Should -Be $testresults["A"][3]
    }

    It "A4" {
        (main $testdataA4 $step1) | Should -Be $testresults["A"][4]
    }

    It "B0" {
        (main $testdataB0 $step2) | Should -Be $testresults["B"][0]
    }

    It "B1" {
        (main $testdataB1 $step2) | Should -Be $testresults["B"][1]
    }

    It "B2" {
        (main $testdataB2 $step2) | Should -Be $testresults["B"][2]
    }

    It "B3" {
        (main $testdataB3 $step2) | Should -Be $testresults["B"][3]
    }

    It "B4" {
        (main $testdataB4 $step2) | Should -Be $testresults["B"][4]
    }
}

$data = gc "$PSScriptRoot/data/input"
$testdataA0 = gc "$PSScriptRoot/data/testA0"
$testdataA1 = gc "$PSScriptRoot/data/testA1"
$testdataA2 = gc "$PSScriptRoot/data/testA2"
$testdataA3 = gc "$PSScriptRoot/data/testA3"
$testdataA4 = gc "$PSScriptRoot/data/testA4"
$testdataB0 = gc "$PSScriptRoot/data/testB0"
$testdataB1 = gc "$PSScriptRoot/data/testB1"
$testdataB2 = gc "$PSScriptRoot/data/testB2"
$testdataB3 = gc "$PSScriptRoot/data/testB3"
$testdataB4 = gc "$PSScriptRoot/data/testB4"

$testresults = @{
    A = @(7,5,6,10,11)
    B = @(19,23,23,29,26)
}

Write-Output "`nAnwsers:"
$step1 = 4
$step2 = 14
main $data $step1
main $data $step2
