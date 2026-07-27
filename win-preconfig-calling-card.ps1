# 7/27/26
# please update list of $ccCodes when calling card channel is updated
# just copy a line and add the new code at the bottom of the list

$ccPath = "HKCU:\Software\LogMeInRescueCallingCards"

# this is a list of common calling card codes installed on customers' computers
$ccCodes = [System.Collections.Generic.List[string]]::new()
$ccCodes.Add('ypub4n')
$ccCodes.Add('1jww6o')
$ccCodes.Add('eost6i')
$ccCodes.Add('gekxnn')
$ccCodes.Add('58pq3u')
$ccCodes.Add('6gqmpb')
$ccCodes.Add('a2r0tk')
# this creates a list of installed calling card codes
# this list is how the script knows where to write the customer info
$ccInstalled = [System.Collections.Generic.List[string]]::new()

# this loop tests each of the pre-listed codes to see if they're installed
# and adds it to the empty list just above
foreach ( $code in $ccCodes )
{
	if ( Test-Path -Path "$ccPath\$code" )
	{
		$ccInstalled.Add($code)
	}
}

Write-Host "Script to pre-configure the calling card customer info."
Write-Host " "

# this checks if the intalled calling card codes list is empty
# to prevent the script from doing unpredictable things
# and wasting user time
if ( $ccInstalled.Count -eq 0 )
{
	Write-Host "Please install calling card first or update list of codes in the script."
	Write-Host " "
	cmd /k
}

Write-Host "Hint: right-click will paste copied text. Leave field empty to not change it."
Write-Host " "

# this creates a prompt in the command shell window for input
$fName = Read-Host "Customer first name"
$lName = Read-Host "Customer last name"
$pNum = Read-Host "Customer phone number"
$cMake = Read-Host "Computer make, model, and hostname"


# this loop takes the customer information and either creates or updates it
#   (by method of creating and overwriting old values)
# it does this for all installed codes

# if enter is pressed without typing anything, that field will not be changed


foreach ( $insCode in $ccInstalled )
{
	if ( $fName )
	{
		New-ItemProperty -Path "$ccPath\$insCode" -Name CField0 -Value $fName -Force | Out-Null
	}
	
	if ( $lName )
	{
		New-ItemProperty -Path "$ccPath\$insCode" -Name CField1 -Value $lName -Force | Out-Null
	}
	
	if ( $pNum )
	{
		New-ItemProperty -Path "$ccPath\$insCode" -Name CField3 -Value $pNum -Force | Out-Null
	}
	
	if ( $cMake )
	{
		New-ItemProperty -Path "$ccPath\$insCode" -Name CField4 -Value $cMake -Force | Out-Null
	}
}

Write-Host " "
Write-Host "Registry keys created."
Write-Host "Script finished. Press any key to exit..."
cmd /c pause | Out-Null