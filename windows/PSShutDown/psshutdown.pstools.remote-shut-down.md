<h3>Network PC Remote Shutdown</h3>
<h5><sub>To remotely shut down one-or-more network attached computer, perform the following steps</sub></h5>

1. Download PSTools.zip -> https://technet.microsoft.com/en-us/sysinternals/bb896649.aspx

2. On Source & Destination computers, drop any desired (or all) files from PSTools.zip into C:\Windows\System32

3. On Destination & Source computers, Allow File and Printer Sharing through Windows Firewall. To do this, run "firewall.cpl" via the start menu, then select "Allow a program through Windows Firewall" (left side), scroll down to "File and Printer Sharing" and check it under "Home/Work (Private)"

4. Restart computer(s) which which just had firewall settings changed

5. You may use a single PC's hostname or, alternatively, a @filepath containing a newline-delimited list of PC hostnames, as the last argument given to the [ psshutdown ] command - To demonstrate the latter (file w/ hostnames), type the names network PCs to remotely shut down WITHOUT the \\ UNC path infront of each name, into [ %USERPROFILE%\.psshutdown_hostnames.txt ]

6. On source computer, use cmd (or a batch file) to call [ psshutdown -s -f -t 0 @%USERPROFILE%\.psshutdown_hostnames.txt ]
<hr />

<h3>Combining psshutdown with APC PowerChute Software</h3>
<h5><sub>Psshutdown may be used with APC UPS's to shutdown multiple PCs attached to its battery backup, even though only one of the PCs is plugged into the UPS via USB, but all PCs stay on when the UPS kicks over to relying on battery power</sub></h5>

1. On the source computer, make sure that the [ APC Powerchute ] software application is installed, and that the source computer is tethered to the battery backup via connected via an RJ-45 to USB cable into the back/side of the battery backup

2. Unplug the UPS from the wall to trigger a 'blackout' event (source computer should be running on backup power, temporarily)

3. Make a note of the time on the source computer's clock, then plug the battery backup back into the wall (to take it off battery power and return it to a charging state)

4. On the source computer running APC PowerChute, run ```eventvwr.msc``` to open Event Viewer -> double-click "Windows Logs" (left) to drop it down -> left-click "Application" (left), and locate an event with a ```Level``` of ```Warning``` from the APC UPS Service stating something similar to ```Battery backup transferred to battery power due to a blackout```

5. Right-click this event & select ```Attach a Task to this Event```, then have it run a batch file containing the psshutdown call (above) to shut down all computers attached to the UPS's backup battery when the power goes out

6. Once you're done, test it!

<hr />
