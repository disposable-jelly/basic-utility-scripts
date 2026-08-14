# the directories of cache to clear

$dir1 = "$env:HOMEPATH\AppData\LocalLow\Adobe\AcroCef\DC\Acrobat\Cache\Cache\Cache_Data\"
$dir2 = "$env:HOMEPATH\AppData\LocalLow\Adobe\AcroCef\DC\Acrobat\Cache\Code Cache\js\"
$dir3 = "$env:HOMEPATH\AppData\LocalLow\Adobe\AcroCef\DC\Acrobat\Cache\Code Cache\js\index-dir\"

# measure the size of the directories
# since it's summing recursively and one of the directories
# is a sub-directory of another, we only need two lines here

$size = (Get-ChildItem -Path $dir1 -Recurse | Measure-Object -Property Length -Sum).Sum
$size += (Get-ChildItem -Path $dir2 -Recurse | Measure-Object -Property Length -Sum).Sum

#convert from bytes to megabytes

$sizeMB = ($size * 0.000001)
$cleanSize = [Math]::Round($sizeMB, 2)

Write-Host "Acrobat cache size: $cleanSize MB"

choice /c YN /m "Would you like to proceed with clearing the cache?"

if ($LASTEXITCODE -eq 1)
{
	Get-ChildItem -path $dir1 -Include * -File -Recurse | Remove-Item
	Get-ChildItem -path $dir2 -Include * -File -Recurse | Remove-Item
	Get-ChildItem -path $dir3 -Include * -File -Recurse | Remove-Item
	Write-Host ""
	Write-Host "Cache cleared."
	Write-Host ""
	sleep 1
	Write-Host "Press any key to continue..."
	[Console]::ReadKey() | Out-Null
	exit
} else {
	Write-Host ""
	Write-Host "Job canceled."
	Write-Host ""
	sleep 1
	Write-Host "Press any key to continue..."
	[Console]::ReadKey() | Out-Null
	exit
}
pause