$XymonPSPath = 'C:\Program Files\xymonPS'

$ErrorActionPreference = "Stop"
Write-Output "Checking if $($XymonPSPath) exists."

if(!(Test-Path -Path $XymonPSPath ))
{
     Write-Output "Creating folder $($XymonPSPath).."
    try {
         New-Item -ItemType directory -Path $XymonPSPath
        }
    catch [System.UnauthorizedAccessException]
        { 
         Write-Output "Unable to create folder $($XymonPSPath), user is not authorized. Please run this script with admin rghts."
         Break
        }
    catch 
        {
        Write-Output "Unable to create folder $($XymonPSPath), error message: $($error[0].Exception.GetType().FullName)"
        Break
        }
}
else
{
    Write-Output "Folder $($XymonPSPath) exists."
}

Write-Output "Continuing.."

Write-Output "Downloading XymonPS files from internet."

#(New-Object System.Net.WebClient).DownloadFile('','')

#(New-Object System.Net.WebClient).DownloadFile('https://sourceforge.net/p/xymon/code/HEAD/tree/sandbox/WinPSClient/xymonclient.ps1?format=raw', "C:\Program Files\xymonPS\xymonclient.ps1")
#(New-Object System.Net.WebClient).DownloadFile('https://sourceforge.net/p/xymon/code/HEAD/tree/sandbox/WinPSClient/xymonclient.ps1?format=raw', 'C:\Program Files\xymonPS\xymonclient.ps1')

try {
        (New-Object System.Net.WebClient).DownloadFile('https://sourceforge.net/p/xymon/code/HEAD/tree/sandbox/WinPSClient/xymonclient.ps1?format=raw', "$($XymonPSPath)\xymonclient.ps1")
        (New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/poorleno1/xymonPS/master/xymonclient_config.xml', "$($XymonPSPath)\xymonclient_config.xml")
        (New-Object System.Net.WebClient).DownloadFile('https://sourceforge.net/p/xymon/code/HEAD/tree/sandbox/WinPSClient/nssm.exe?format=raw', "$($XymonPSPath)\nssm.exe")
        Write-Output "Done."
    }
    catch
    {
    Write-Output "Unable to download, error message:  $($error[0].Exception.GetType().FullName). Tip: always check access."
    }

Write-Output "Installing xymon client as service."
Invoke-Expression "$($XymonPSPath)\xymonclient.ps1 install"

Write-Output "Starting xymon client."
Invoke-Expression "$($XymonPSPath)\xymonclient.ps1 start"