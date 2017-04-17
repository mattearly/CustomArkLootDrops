$subfolders = get-childitem -dir -Exclude ".git"

foreach($folder in $subfolders) {
	$folderName = $folder.Name
	$formatFilePath = $folder.FullName +  "\OUTPUT_FORMAT_" + $folderName.ToUpper()

	if (test-path $formatFilePath) {
		$outputFilePath = ".\FULL_DEPLOY_CODE_" + $folderName.ToUpper() + ".ini"
		if(test-path $outputFilePath) { remove-item $outputFilePath }
		Write-Host "Folder $folderName is processing to $outputFilePath file."

		get-content $formatFilePath | foreach-object {
			$line = $_
			$matches = ([regex]'%(.*?)%').Matches($line)
			foreach($match in $matches) {
				$filename = $match.Groups[1];
				if ("$filename".Contains("/")) {
					$filename = $folder.parent.FullName + '\' + $filename
				} else {
					$filename = $folder.FullName + '\' + $filename
				}

				if(!(test-path $filename)) { Write-Host "Looking for file $filename which not exists." }

				$content = @()
				get-content $filename | foreach-object {
					$value = $_.Trim()
					if ($value -notmatch "^;") { $content += $value }
				}
				$line = $line -replace $match.Groups[0],("$content" -replace '\s')
			}
			add-content $outputFilePath "$line"
		}
		
	} else {
		Write-Host "Folder $folderName skipped, because missing $formatFilePath file."
	}
}

Read-Host "Press any key to exit..."
exit
