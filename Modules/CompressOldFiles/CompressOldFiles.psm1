function Compress-Older-Than {

    Param(
        [Parameter(Mandatory=$True,Position=1)]
            [string]$inputPath,
        [Parameter(Mandatory=$True,Position=2)]
            [int]$minimumAge,
        [Parameter(Mandatory=$True,Position=3)]
            [string]$outputPath,
        [Parameter(Mandatory=$True,Position=4)]
            [string]$outputFile
    )

    $outputName = "$outputPath\$outputFile$(get-date -f yyyy-MM-dd).7z"
        
    Import-Module CompressFiles

    $CutDay = [DateTime]::Now.AddDays(-$minimumAge)
    $files = Get-ChildItem -Path $inputPath -include $Extension -Recurse -Force | Where-Object {$_.LastWriteTime -lt $CutDay}

    #Check for 7zip
    #if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"}
    if (-not (test-path "C:\Program Files\7-Zip\7z.exe")) {throw "C:\Program Files\7-Zip\7z.exe needed"}

    #Poplulate filenames/paths for 7zip to ingest
    pushd $inputPath
    $FileNames = @($files | %{$_.FullName.Substring($inputPath.Length+1)} )

    CompressListedFiles -FileNames $FileNames -outputPath $outputName

    foreach ($file in $files) {
       $file | Remove-Item
    }
}
