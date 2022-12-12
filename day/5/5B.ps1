#main
function main {
    param (
        $data
    )
    $splitter = $data.IndexOf("")
    $stacks = $data[0..($splitter-1)]
    $operations = $data[($splitter+1)..$data.count]

    $stacks2 = @{
        1 = "ZPMHR"
        2 = "PCJB"
        3 = "SNHGLCD"
        4 = "FTMDQSRL"
        5 = "FSPQBTZM"
        6 = "TFSZBG"
        7 = "NRV"
        8 = "PGLTDVCM"
        9 = "WQNJFML"
    }
<#
    $stacks2 = @{
        1 = "ZN"
        2 = "MCD"
        3 = "P"
    }
#>

    $stacks3 = @{}
    foreach ($key in $stacks2.keys){
        $stacks3 += @{$key = ($stacks2.$key).toCharArray()}
    }

    foreach ($op in $operations){
        $op = (($op -replace "move ") -split " from ") -split " to "
        $stackFrom = $stacks3[[int]($op[1])]
        $max = $stackFrom.Length
        # $stacks3.keys | %{Write-Output "$_ + $($stacks3[$_] -join '')"}
        #Write-Output $stacks3[$op[1] -join '']
        #Write-Output $stacks3[$op[2] -join '']
        #Write-Output $op -join ''
        switch ($op[0]) {
            ($max) {
                $stacks3[[int]($op[1])] = "".ToCharArray()
                
            }
            Default {
                $stacks3[[int]($op[1])] = $stacks3[[int]($op[1])][0..($max - $op[0]-1)]
            }
        }

        $stacks3[[int]($op[2])] += $stackFrom[($max-$op[0])..$max]
        # Write-Output $stacks3[$op[1] -join '']
        # Write-Output $stacks3[$op[2] -join '']

        #($stacks3.keys | %{Write-Output "$_ + $($stacks3[$_][-1])"})

    }
    $stacks3
    return $($stacks3.keys | %{Write-Output "$_ + $($stacks3[$_] -join '')"})
}


$data = gc "$PSScriptRoot/data/input"
$testdata = gc "$PSScriptRoot/data/test"


Write-Output "`nAnwsers:"
#main $testdata
main $data
