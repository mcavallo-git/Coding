
### Network PC Remote Shutdown
##### MCavallo, 2016-08-29_04-00
<hr />

##### To remotely shut down one-or-more network attached computer, perform the following steps:

1. Download PSTools.zip -> https://technet.microsoft.com/en-us/sysinternals/bb896649.aspx

2. On Source & Destination computers, drop any desired (or all) files from PSTools.zip into C:\Windows\System32

3. On Destination & Source computers, Allow File and Printer Sharing through Windows Firewall. To do this, run "firewall.cpl" via the start menu, then select "Allow a program through Windows Firewall" (left side), scroll down to "File and Printer Sharing" and check it under "Home/Work (Private)"

4. Restart computer(s) which which just had firewall settings changed

5. You may use a single PC's hostname or, alternatively, a @filepath containing a newline-delimited list of PC hostnames, as the last argument given to the [ psshutdown ] command - To demonstrate the latter (file w/ hostnames), type the names network PCs to remotely shut down WITHOUT the \\ UNC path infront of each name, into [ %USERPROFILE%\.psshutdown_hostnames.txt ]

6. On source computer, use cmd (or a batch file) to call [ psshutdown -s -f -t 0 @%USERPROFILE%\.psshutdown_hostnames.txt ]
<hr />

##### Combining psshutdown with APC PowerChute Software

<h5><sub>Psshutdown may be used with APC UPS's to shutdown multiple PCs attached to its battery backup, even though only one of the PCs is plugged into the UPS via USB, but all PCs stay on when the UPS kicks over to relying on battery power</sub></h5>

1. Unplug the UPS from the wall to trigger a 'blackout' event

2. On the computer with Powerchute installed, go to "Event Viewer"

3. In Event Viewer, go to "Windows Logs > Application" and find the Warning Log from the APC UPS Service that says "Battery backup transferred to battery power due to a blackout"

4. Right click this event, click "Attach a Task to this Event", and attach a batch file which contains the aforementioned steps (above) to shut down all computers attached to the UPS's backup battery

<hr />
