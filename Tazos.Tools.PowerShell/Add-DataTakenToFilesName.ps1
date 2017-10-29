function Get-DataTaken{
param ($fileMetadata)
$rawDate = $fileMetadata.'Data wykonania'
$rawDate = $rawDate -replace '[^a-zA-Z0-9 :.]', '' #remove non date format characters
$datePattern = [System.Threading.Thread]::CurrentThread.CurrentUICulture.DateTimeFormat.ShortDatePattern;
$timePattern = [System.Threading.Thread]::CurrentThread.CurrentUICulture.DateTimeFormat.ShortTimePattern;
$pattern = "$datePattern $timePattern"
$culture = [System.Globalization.CultureInfo]::InvariantCulture 

$parsedDate = [DateTime]::ParseExact($rawDate, $pattern, $culture)

$formatedDate = $parsedDate.ToString('yyyy.mm.dd HH-mm');
$formatedDate 
}

function Get-Extension{
param ($fileMetadata)
$rawExtension= $fileMetadata.'Rozszerzenie Pliku'
$rawExtension
}
function Get-FileName{
param ($fileMetadata)
$name = $fileMetadata.'Nazwa'
$extenstion = Get-Extension -fileMetadata $fileMetadata
if($name.EndsWith($extenstion) )
		{
			$name
		}
$name = $name + $extenstion
$name
}
 
function Add-DataTakenToFilesName{
 param(
	[Parameter(Mandatory)]
	[string] 
    $Path)
	
	$filesMetadata = Get-FileMetaData -folder $Path
	foreach($fileMetadata in $filesMetadata)
	{
		$dateTaken = Get-DataTaken -fileMetadata $fileMetadata
		if (-not $dateTaken)
		{
			continue;
		}
       
		$fileName = Get-FileName -fileMetadata $fileMetadata

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

