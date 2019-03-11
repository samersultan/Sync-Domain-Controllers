param([switch]$Elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}

exit
}

'running with full privileges'


  Start-ADSyncSyncCycle -PolicyType Delta -ErrorAction Stop
  #Wait 10 seconds for the sync connector to wake up.
  Start-Sleep -Seconds 10
  #Display a progress indicator and hold up the rest of the script while the sync completes.
  While(Get-ADSyncConnectorRunStatus){
    Write-Host "." -NoNewline
    Start-Sleep -Seconds 10
  }Sleep -Seconds 10   #Display a 
