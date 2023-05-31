Param (
	[Parameter(Mandatory=$true)]
	[string] $UPN,

    [Parameter(Mandatory=$true)]
	[string] $FirstName,

    [Parameter(Mandatory=$true)]
	[string] $Surname,

    [Parameter(Mandatory=$true)]
	[string] $PhoneNumber,

    [Parameter(Mandatory=$true)]
	[string] $JobTitle
)

$credential = Get-AutomationPSCredential -Name 'ExchangeRights'
$userName = $credential.UserName
$securePassword = $credential.Password

$o365cred = New-Object System.Management.Automation.PSCredential ($userName, $securePassword)


Connect-ExchangeOnline -Credential $o365cred


$HTML = '<html><head><meta http-equiv="Content-Type" content="text/html charset=UTF-8" />
         <!-- Insert your HTML-based signature here. User single qoutes to escape PowerShell variables, eg: -->
         <p class="JobTitle">'$JobTitle'</p>
         
         <!-- Displays UPN as clickable link with mailto URI -->
         <a href="mailto:"' + $UPN + '>' + $UPN + '</a>
         </head>
         </html>'

Set-MailboxMessageConfiguration -Identity $UPN -AutoAddSignature $True -AutoAddSignatureOnReply $True -AutoAddSignatureOnMobile $true -SignatureHTML $HTML
