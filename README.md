# Get-Spokes3GSystem
PowerShell script to aid in the automation of local privilege escalation path with the SpokesUpdateService

Based on the original exploit found here: [https://www.exploit-db.com/exploits/47845](https://www.exploit-db.com/exploits/47845)

<br><br>

# Tested on:
Windows Server 2019

<br><br>

# Usage:
1. Download the script to the target
2. If using a custom payload file, place that in a writable directory on the target
3. Run the script
  - If using the script as-is, will spawn cmd.exe SYSTEM
  
```powershell
.\Get-Spokes3GSystem.ps1
```

```powershell
.\Get-Spokes3GSystem.ps1 -Payload "$($env:USERNAME)|advertise|C:\Windows\Temp\shell.exe"
```
