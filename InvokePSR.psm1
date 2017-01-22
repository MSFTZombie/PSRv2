Function Invoke-PSR
	{
	<#    
	
    .SYNOPSIS
	Starts psr.exe

	.DESCRIPTION
	Starts psr.exe with specified parameters

	.PARAMETER Output
	Specify the output file and path of the psr.exe recorded session, the default value is C:\Temp\PSR_(2-digit month).(2-digit day).(4-digit year).Hour-Minute(AM/PM).zip

	.PARAMETER MaxScreenCapture
	Specify the maximum number of screen captures psr.exe will capture. Valid values are 1-999. Note that Windows 7 and earlier versions the max value is 100

	.PARAMETER Start
	Specify if you want to start psr.exe with the recording started

	.PARAMETER RunAsAdministrator
	Specify that you want to start psr.exe with elevated permissions

	.EXAMPLE
	Invoke-PSR -Start -RunAsAdministrator

	This will start and elevated psr.exe with the recording started, with a maximum of 999 screen captures and save the recording to C:\Temp\PSR_09.07.2016.10-37PM.zip

	.EXAMPLE
	Invoke-PSR -Output C:\Temp\PSRRecording.zip -MaxScreenCapture 100 -Start

	This will start psr.exe with the recording started, with a maximum of 100 screen captures and save the recording to C:\Temp\PSRRecording.zip

	.NOTES
	    Authors and Contributors:
            Jeramy Evers
            Lynne Taggart
        
        Import-Module "C:\Invoke-PSR\InvokePSR.psm1"
        Invoke-PSR -Start -RunAsAdministrator

    .LINK
        https://blogs.technet.microsoft.com/allthat/
        https://github.com/MSFTZombie/PSRv2
    
    
    Current Version: 1.0
        Date Created: 9/7/2016
	    Last Modified: 9/7/2016
	        - Version 4.0 created
                - Script edited and tested
	
	
	#>	

	[CmdletBinding()]
	Param
		(
		[parameter(Mandatory=$False)][System.IO.FileInfo]$Output="C:\Temp\$(Get-Date -UFormat "PSR_%m.%d.%Y.%I-%M%p.zip")",
		[parameter(Mandatory=$False)][Int][ValidateRange(1,999)]$MaxScreenCapture=999,
		[parameter(Mandatory=$False)][Switch]$Start,
		[parameter(Mandatory=$False)][Switch]$RunAsAdministrator
		)

	$OSVersion = [System.Environment]::OSVersion.Version

	If ($OSVersion.Major -eq 6 -and $OSVersion.Minor -le 1 -and $MaxScreenCapture -gt 100)
		{
		Write-Warning "PSR.exe on Windows version $($OSVersion.ToString()) has a limitation of a maximum of 100 screen captures and $MaxScreenCapture was specified, so setting maximum screen captures to 100`n"
		$MaxScreenCapture = 100
		}

	If ((Split-Path $Output -Parent | Test-Path) -eq $False)
		{
		Write-Warning "$(Split-Path $Output -Parent) doesn't exist. Do you want the directory created?"
		
		Do
			{
			$KeyPress = Read-Host -Prompt "Y/N"
			}
		Until ($KeyPress -eq "Y" -or $KeyPress -eq "N")
		
		If ($KeyPress -eq "Y")
			{
			New-Item $(Split-Path $Output -Parent) -Type Directory
			}

		If ($KeyPress -eq "N")
			{
			Break
			}
		}

	If ($Start)
		{
		Write-Host "Starting psr.exe with $MaxScreenCapture maximum screen caputures, recording started and saving to $Output" -ForeGroundColor Green
		If ($RunAsAdministrator)
			{
			Start-Process psr.exe -ArgumentList "/output $Output /maxsc $MaxScreenCapture /start" -Verb RunAs
			}
		Else
			{
			Start-Process psr.exe -ArgumentList "/output $Output /maxsc $MaxScreenCapture /start"
			}
		}
	Else
		{
		Write-Host "Starting psr.exe with $MaxScreenCapture maximum screen caputures and saving to $Output" -ForeGroundColor Green
		If ($RunAsAdministrator)
			{
			Start-Process psr.exe -ArgumentList "/output $Output /maxsc $MaxScreenCapture" -Verb RunAs
			}
		Else
			{
			Start-Process psr.exe -ArgumentList "/output $Output /maxsc $MaxScreenCapture"
			}
		}
	}

Export-ModuleMember -Function Invoke-PSR