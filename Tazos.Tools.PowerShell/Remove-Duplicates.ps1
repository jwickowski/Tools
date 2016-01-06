 function Remove-Duplicates{
 param(
  [Parameter(Mandatory)]
        [string] 
        $Path)
    $files = Get-ChildItem -Path $Path

    $md5s = @{}
    foreach($fileName in $files){
        $fileName = Join-Path -Path $Path -ChildPath $fileName
        
        Write-Host $fileName
        $md5 = Get-MD5 -Path $fileName
        Write-Host $md5
        if($md5s.ContainsKey($md5)){
            Remove-Item $fileName
        }
        else{
            $md5s.Add($md5, $fileName)
        }
    }
}