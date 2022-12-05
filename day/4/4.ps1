#functions
function Get-SectionList ($givenRange) {
    $sections = ($givenRange -split "-") 
    return ($sections[0]..$sections[1])
}

#main
function main {
    param (
        $inputData
    )
    $counter1 = 0
    $counter2 = 0

    foreach ($line in $inputData){
        $elfsRanges = $line -split ","
        $elf1 = Get-SectionList $elfsRanges[0]
        $elf2 = Get-SectionList $elfsRanges[1]
        if(((Compare-Object $elf2 $elf1 -IncludeEqual).SideIndicator | Select "==").count -in @($elf1.count, $elf2.count)){
            $counter1++
        }
        if("==" -in ((Compare-Object $elf2 $elf1 -IncludeEqual).SideIndicator )){
            $counter2++
        }
    }
    return $counter1, $counter2
}

# Tests
Describe "Tests" {
    It "Part1" {
        (main $testdata)[0] | Should -Be $testResults[0]
    }
    
    It "Part2" {
        (main $testdata)[1] | Should -Be $testResults[1]
    }
}

$data = gc "$PSScriptRoot/data/input"
$testdata = gc "$PSScriptRoot/data/test"
$testResults = @(2,4)

Write-Output "`nAnwsers:"
main $data
