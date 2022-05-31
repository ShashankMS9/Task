md -Path $env:temp\edgeinstall -erroraction SilentlyContinue | Out-Null
$Download = join-path $env:temp\edgeinstall MicrosoftEdgeEnterpriseX64.msi
Invoke-WebRequest 'https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/a2662b5b-97d0-4312-8946-598355851b3b/MicrosoftEdgeEnterpriseX64.msi'  -OutFile $Download
Start-Process "$Download" -ArgumentList "/quiet" 

New-Item -ItemType directory -Path C:\labfiles -force

$input = 'https://shashankonboarding.blob.core.windows.net/powershell/edge1added.ps1'
$output = 'c:\labfiles\edge1added.ps1'
Invoke-WebRequest -Uri $input -OutFile $output

$extenction = 'C:\WindowsAzure\Logs\Plugins\Microsoft.Compute.CustomScriptExtension\1.10.12'

$Logfile = "c:\labfiles\log_$env:computername.log"
function WriteLog
{
Param ([string]$LogString)
$Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
$LogMessage = "$Stamp $LogString"
Add-content $LogFile -value $LogMessage
}

writeLog $extenction
WriteLog $input + " website"
WriteLog $output + " stored location"
Start-Sleep 20
WriteLog "The script is successfully executed"

New-AzStorageAccount -name demofrompoweshell -ResourceGroupName onboarding -SkuName Standard_LRS -location "East US" -kind Storagev2