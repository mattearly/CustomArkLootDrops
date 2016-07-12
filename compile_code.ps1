$formatFilePath = ".\OUTPUT_FORMAT"
$outputFilePath = ".\FULL_DEPLOY_CODE"

$files = get-childitem .\ | where-object { $_.FullName -match "Beacon$" }

foreach($file in $files) {
	$fileName = $file.FullName + '_compile'
	get-content $file | foreach-object Trim($_) | where { $_ -notmatch "^;" } | set-content -path $fileName -nonewline
}

if(test-path $outputFilePath) {
	remove-item $outputFilePath
}

get-content $formatFilePath |
foreach-object {
  $line = $_
  $matches = ([regex]'%(.*?)%').Matches($line)
  foreach($match in $matches) {
    $path = get-location
    $filename = $path.Path + '\' + $match.Groups[1] + '_compile'
    $content = [Io.File]::ReadAllText($filename)
    $line = $line -replace $match.Groups[0],$content
  }
  add-content $outputFilePath "$line"
}

get-childitem .\ -filter "*_compile" | remove-item 