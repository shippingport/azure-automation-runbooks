Param (
	[Parameter(Mandatory=$true)]
	[string] $UPN
)

$Credential = Get-AutomationPSCredential -Name 'ExchangeRights'
$userName = $Credential.UserName
$securePassword = $Credential.Password

$o365cred = New-Object System.Management.Automation.PSCredential ($userName, $securePassword)


Connect-ExchangeOnline -Credential $o365cred

Function CheckIfMailboxExists($UPN) {
    $mailboxExistsReturnValue = (Get-Mailbox -Identity $UPN -ErrorAction SilentlyContinue | Select-Object Guid)
    if($mailboxExistsReturnValue)
    {
        return $true
    } else {
        return $false
    }
}

while($result -eq $false)
{
    Start-Sleep -Seconds 5
    $result = CheckIfMailboxExists($UPN)
}

exit
