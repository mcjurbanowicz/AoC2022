#functions
function CheckAreNumbers {
    param (
        $array
    )
    $sizeOfFiles = 0
    foreach ($i in $array){
        try {
            $sizeOfFiles += [int]$i
        }
        catch {
            return 0
        }
    }
    return $sizeOfFiles
}

function Get-Size {
    param (
        $path
    )
    if($path -like "znlgg"){
        echo 123131
    }
    $files = gci
    $folderSize = CheckAreNumbers ($files.Name)

    if ($folderSize -eq 0){
        $newPath = (gci -Directory | ?{
            ($_.name) -notmatch "^\d+$"
        })
        if ($newPath -eq $null) {continue}
        cd $newPath[0]
        Get-Size $newPath[0]
    } 
    else {
        if ($folderSize -le $count100000){
            Write-Output $folderSize
            $foldersUpTo100000 += $folderSize
        }

        #Emergancy exits
        if ((Get-Location).path -eq "C:\"){Exit}
        if ($path -eq "$PSScriptRoot\result"){Exit}

        cd ..
        Rename-Item $path $folderSize
        Get-Size (Get-Location).Path
    }
}


#main
function main {
    param (
        $in
    )

    $obj = @()
    $subfiles = @()
    $count100000 = 0
    $defaultPath = "$PSScriptRoot\result"
    #Remove-Item $defaultPath -Force
    mkdir "$PSScriptRoot\result"
    cd $defaultPath

    

    foreach ($line in $in){
        
        if ($line.StartsWith('$')){
            if ($line -eq "$ ls"){
                $obj += @{"ls" = @()}
            }
            else {
                $obj += @{$line = @(0)}
                $subfiles = @()
            }
        }
        else {$subfiles += $obj[-1].ls += $line}
    }

    $obj
    foreach ($l in $obj){
        switch ($l.keys) {
            "ls" {
                foreach ($f in $l.ls){
                    if ($f.StartsWith("dir")){
                        mkdir ($f -replace "dir ") | Out-Null
                }
                    else {
                        New-Item ($f -split " ")[0] | Out-Null
                    }
                }
            }
            '$ cd /' {
                cd $defaultPath
            }
            
            Default {
                cd ($($l.keys) -replace '\$ cd ')
            }
        }

    }
    
    $foldersUpTo100000 = @()
    $defaultPath = "C:\result"
    mkdir $defaultPath
    cd $defaultPath

    PAUSE
    copy $PSScriptRoot\result (gi $defaultPath).parent -Force -Recurse

    Get-Size (gi $defaultPath)

    return $foldersUpTo100000
}


$data = gc "$PSScriptRoot/data/input"
$testdata = gc "$PSScriptRoot/data/test"
$testResults = 95437

Write-Output "`nAnwsers:"
$part1 = main $data
Write-Output ($part1 | Measure -Sum)




$total = 70000000
$needspace = 30000000

$occupied = 0
gci $path -name | Sort-Object | %{$occupied += [int]$_}
$freespace = $total - $occupied
$needtoremove = $needspace - $freespace
if ($needtoremove -lt 0){Write-Host "no need to remove anything"}

$list = (gci -recurse -Directory $path -Name) -split "\\" | Sort-Object | Select-Object -Unique

$list | ?{[int]$_ -ge $needtoremove} | Measure-Object -Minimum
$list

