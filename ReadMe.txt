
Please find attached an updated version of the script that will now detect if Windows 7 or less and if more than 100 screen captures have specified it will then output a warning to the user that more than 100 was specified and it will set it a max value of 100 and launch PSR with that setting.
 


Here is what I have so far. Play around with it and let me if this is what you’re looking for. Then let me know when you have time and we can go over this in its entirety to explain each line and use this to mentor you on Windows PowerShell.
 
To use rename the attachment to InvokePSR.psm1 and copy to someplace on your computer. This is a Windows PowerShell module so it will create a new function named Invoke-PSR that acts just like a cmdlet in Windows PowerShell.
 
From Windows PowerShell type the following changing the path to where the file is located to import the module:
 
Import-Module C:\temp\InvokePSR.psm1
 
Now you will have a new function in the Windows PowerShell session named Invoke-PSR. To see what it can do and example see its help by typing:
 
Help Invoke-PSR -Full
 
Which the help topic will show the following (Note we change the related links section at the bottom to point to your specific blog on psr.exe):
 
 
NAME
    Invoke-PSR
    
SYNOPSIS
    Starts psr.exe
    
    
SYNTAX
    Invoke-PSR [[-Output] <FileInfo>] [[-MaxScreenCapture] <Int32>] [-Start] [-RunAsAdministrator] [<CommonParameters>]
    
    
DESCRIPTION
    Starts psr.exe with specified parameters
    
 
PARAMETERS
    -Output <FileInfo>
        Specify the output file and path of the psr.exe recorded session, the default value is C:\Temp\PSR_(2-digit 
        month).(2-digit day).(4-digit year).Hour-Minute(AM/PM).zip
        
        Required?                    false
        Position?                    1
        Default value                "C:\Temp\$(Get-Date -UFormat "PSR_%m.%d.%Y.%I-%M%p.zip")"
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -MaxScreenCapture <Int32>
        Specify the maximum number of screen captures psr.exe will capture. Valid values are 1-999. Note that Windows 
        7 and earlier versions the max value is 100
        
        Required?                    false
        Position?                    2
        Default value                999
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -Start [<SwitchParameter>]
        Specify if you want to start psr.exe with the recording started
        
        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -RunAsAdministrator [<SwitchParameter>]
        Specify that you want to start psr.exe with elevated permissions
        
        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
OUTPUTS
    
NOTES
    
    
        Date Created: 9/7/2016
        Last Modified: 9/7/2016
        Version: 1.0
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Invoke-PSR -Start -RunAsAdministrator
    
    This will start and elevated psr.exe with the recording started, with a maximum of 999 screen captures and save 
    the recording to C:\Temp\PSR_09.07.2016.10-37PM.zip
    
    
    
    
    -------------------------- EXAMPLE 2 --------------------------
    
    PS C:\>Invoke-PSR -Output C:\Temp\PSRRecording.zip -MaxScreenCapture 100 -Start
    
    This will start psr.exe with the recording started, with a maximum of 100 screen captures and save the recording 
    to C:\Temp\PSRRecording.zip
    
    
    
    
    
RELATED LINKS
    https://blogs.technet.microsoft.com/allthat/




Here is the full cmd line for PSR which looks to have other stuff you might be interested in as well (taken from http://ctrlf5.net/?p=176) :
 
psr.exe [/start |/stop][/output <fullfilepath>] [/sc (0|1)] [/maxsc <value>]
    [/sketch (0|1)] [/slides (0|1)] [/gui (o|1)]
    [/arcetl (0|1)] [/arcxml (0|1)] [/arcmht (0|1)]
    [/stopevent <eventname>] [/maxlogsize <value>] [/recordpid <pid>]
 
/start            :Start Recording. (Outputpath flag SHOULD be specified)
/stop            :Stop Recording.
/sc            :Capture screenshots for recorded steps.
/maxsc            :Maximum number of recent screen captures.
/maxlogsize        :Maximum log file size (in MB) before wrapping occurs.
/gui            :Display control GUI.
/arcetl            :Include raw ETW file in archive output.
/arcxml            :Include MHT file in archive output.
/recordpid        :Record all actions associated with given PID.
/sketch            :Sketch UI if no screenshot was saved.
/slides            :Create slide show HTML pages.
/output            :Store output of record session in given path.
/stopevent        :Event to signal after output files are generated.
 
PSR Usage Examples:
 
psr.exe
psr.exe /start /output fullfilepath.zip /sc1 /gui 0 /record <PID>
    /stopevent <eventname> /arcetl 1
 
psr.exe /start /output fullfilepath.xml /gui 0 /recordpid <PID>
    /stopevent <eventname>
 
psr.exe /start /output fullfilepath.xml /gui 0 /sc 1 /maxsc <number>
    /maxlogsize <value> /stopevent <eventname>
 
psr.exe /stop
 