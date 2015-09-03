function CompressListedFiles {
    Param(
        [Parameter(Mandatory=$True,Position=1)]
            [array]$FileNames,
        [Parameter(Mandatory=$True,Position=2)]
            [string]$outputPath
    )
    if($FileNames.Count -ne 0) {
        #[string]$Zip = "$env:ProgramFiles\7-Zip\7z.exe"
        [string]$Zip = "C:\Program Files\7-Zip\7z.exe"
        [array]$arguments = @("a", "-y", "-m0=lzma2", "-ms=on", "-mmt=on", "-md=64m", "-mfb=128", $outputPath) + $FileNames
        & $Zip $arguments ;
    }
}
