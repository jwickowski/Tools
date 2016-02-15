 function Add-DataTakenToFilesName{
 param(
	[Parameter(Mandatory)]
	[string] 
    $Path)
	
	$filesMetadata = Get-FileMetaData -folder $Path
	foreach($fileMetadata in $filesMetadata)
	{
		$dateTaken = $fileMetadata.'Date taken'
		if (-not $dateTaken)
		{
			continue;
		}
        $dateTaken = $dateTaken.Replace('-', '.').Replace(':', '-')
		$fileName = $fileMetadata.'Name'

		if($fileName.StartsWith($dateTaken) )
		{
			continue
		}

        $filePath = Join-Path -Path $Path -ChildPath $fileName
        $newName = $dateTaken + ' - ' + $fileName 
        $newPath = Join-Path -Path $Path -ChildPath $newName
        Copy-Item -Path  $filePath -Destination $newPath
		

	}
}