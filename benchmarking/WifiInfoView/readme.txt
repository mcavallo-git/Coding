


WifiInfoView v1.65
Copyright (c) 2012 - 2014 Nir Sofer
Web site: http://www.nirsoft.net



Description
===========

WifiInfoView scans the wireless networks in your area and displays
extensive information about them, including: Network Name (SSID), MAC
Address, PHY Type (802.11g or 802.11n), RSSI, Signal Quality, Frequency,
Channel Number, Maximum Speed, Company Name, Router Model and Router Name
(Only for routers that provides this information), and more...
When you select a wireless network in the upper pane of this tool, the
lower pane displays the Wi-Fi information elements received from this
device, in hexadecimal format.
WifiInfoView also has a summary mode, which displays a summary of all
detected wireless networks, grouped by channel number, company that
manufactured the router, PHY type, or the maximum speed.



System Requirements
===================


* Operating System: This utility works on Windows Vista, Windows 7,
  Windows 8, and Windows Server 2008. Both 32-bit and x64 systems are
  supported.
  Windows XP is not supported because this tool is based on new Wi-Fi API
  that doesn't exist on Windows XP. If you want to get wireless networks
  information on Windows XP, you can use the WirelessNetView utility.
* Wireless network adapter and wireless card driver that works with the
  built-in wireless support of Windows Vista/7/8/2008.



Versions History
================


* Version 1.65:
  o Added 'WPS Summary Mode'.

* Version 1.61:
  o Added secondary sorting support: You can now get a secondary
    sorting, by holding down the shift key while clicking the column
    header. Be aware that you only have to hold down the shift key when
    clicking the second/third/fourth column. To sort the first column you
    should not hold down the Shift key.

* Version 1.60:
  o Added 'Percent' column to the summary mode.

* Version 1.56:
  o Fixed the command-line scan (added on version 1.50) to wait until
    the scan is completed.
  o Added /NumberOfScans command-line option, which allows you to
    scan multiple times from command-line, in order to get a better
    result, for example:
    WifiInfoView.exe /NumberOfScans 5 /scomma c:\temp\wscan.csv

* Version 1.55:
  o Added 'Start Time' column, which displays the last time that
    access point was possibly started/restarted/rebooted. Be aware that
    some access points reset their timestamp periodically without
    restart/reboot action, and thus for these APs, the time value
    dislayed on this column doesn't represent the correct start time.
  o The 'WPS Support' column now displays the WPS status -
    Configured, Not Configured, or Locked.

* Version 1.50:
  o Added command-line options to export the wireless networks list
    into a file.

* Version 1.45:
  o The 'Security' column now displays the security mode of the
    network - WEP, WPA-PSK, WPA2-PSK, and so on.... (Instead of Yes/No)
  o Added Security Summary Mode.
  o The 'Cipher' column now displays more accurate information.
    (Added TKIP+CCMP value)
  o Updated the internal MAC addresses file.

* Version 1.40:
  o Added 'Copy MAC Addresses' option (Ctrl+M)
  o Added 'Show Lower Pane' option (Under the View menu). You can
    turn it off if you don't need the lower pane.

* Version 1.36:
  o WifiInfoView now detects 802.11ac networks (according to the 'VHT
    Capabilities' and 'VHT Operation' information elements)

* Version 1.35:
  o Added 'Cipher' column.
  o Added 'WPS Support' column.

* Version 1.30:
  o Added 'Average Signal Quality' column.
  o Added 'Advanced Options' window (F9), which allows you to choose
    the wireless network adapter that will be used to scan the wireless
    networks. This option is useful if you have multiple wireless network
    adapters.
  o Added 'Clear Networks List' option.

* Version 1.26:
  o Added /cfg command-line option, which instructs WifiInfoView to
    use a config file in another location instead if the default config
    file, for example:
    WifiInfoView.exe /cfg "%AppData%\WifiInfoView.cfg"

* Version 1.25:
  o Added BSS Type Summary Mode.

* Version 1.20:
  o Added 'Automatically Scroll Down On New Item' option.

* Version 1.18:
  o Added 'BSS Type' column - Infrastructure or Ad-Hoc.
  o Fixed the flickering while scrolling the wireless networks list.

* Version 1.17:
  o Added 'Select Another Font' option, which allows you to choose a
    font (name and size) to use on the main window.

* Version 1.16:
  o Added 'Sort On Every Update' option.

* Version 1.15:
  o Updated the internal MAC addresses file.
  o Added 'Mark Odd/Even Rows' option, under the View menu. When it's
    turned on, the odd and even rows are displayed in different color, to
    make it easier to read a single line.

* Version 1.10:
  o Added new summary mode: Signal Quality.

* Version 1.05:
  o Added 2 new summary modes - Router Name and Router Model.

* Version 1.00 - First release.



Start Using WifiInfoView
========================

WifiInfoView doesn't require any installation process or additional dll
files. In order to start using it, simply run the executable file -
WifiInfoView.exe

After you run WifiInfoView, the list of detected wireless networks in
your area is displayed on the upper pane and it's updated at very high
rate. You can change update rate from Options->Update Rate menu.
When you select one or more wireless networks in the upper pane, the
lower pane displays the Wi-Fi information elements of the selected items,
in hexadecimal format.



Columns In the Upper Pane
=========================


* SSID: The name of the network.
* MAC Address: MAC address of the router.
* PHY Type: The PHY type for this network - 802.11a, 802.11g, 802.11n,
  or High-Rate DSSS
* RSSI: The received signal strength indicator value, in units of
  decibels referenced to 1.0 milliwatts (dBm), as detected by the
  wireless LAN interface driver for the AP or peer station.
* Signal Quality: A number between 0 and 100 that represents the
  quality of the signal.
* Frequency: The channel center frequency of the band on which the
  802.11 Beacon or Probe Response frame was received. The value of this
  column is in units of Gigahertz (GHz).
* Channel: Channel number used by this wireless network.
* Information Size:The total size (in bytes) of all Wi-Fi information
  elements received from this wireless network.
* Elements Count: The total number of Wi-Fi information elements
  received from this wireless network.
* Company: The company that manufactured the router, according to the 3
  first bytes of the MAC address.
* Router Model: The model of the router. This value is displayed only
  for routers that provide this information inside the Wi-Fi information
  elements.
* Router Name: The name of the router. This value is displayed only for
  routers that provide this information inside the Wi-Fi information
  elements.
* Security: Specifies whether the network is secured (Yes/No).
* Maximum Speed: The maximum speed (in Mbps) that you can get when
  connecting to this wireless network.
* First Detection: The first date/time that this network was detected.
* Last Detection: The last date/time that this network was detected.
* Detection Count: The number of times that this network was detected.



Summary Modes
=============

When you switch to one of the summary modes, instead of showing the list
of all networks, WifiInfoView only shows the number of networks and the
average/minimum/maximum of the signal quality for every group.


For example, in the above screenshot, you can see that there are 25
wireless networks that use channel 6, 10 wireless networks that use
channel 10, and so on....

In the example below, you can see the there are 9 wireless routers of
NETGEAR, 8 wireless routers of Sagemcom, and so on... (Be aware that some
companies may appear more than once, with a little different name)


The following summary modes are available under the Options menu:
Channels Summary Mode, Companies Summary Mode, PHY Types Summary Mode,
and Max Speed Summary Mode



Command-Line Options
====================



/cfg <Filename>
Start WifiInfoView with the specified configuration file. For example:
WifiInfoView.exe /cfg "c:\config\csv.cfg"
WifiInfoView.exe /cfg "%AppData%\WifiInfoView.cfg"

/NumberOfScans <Number>
Specifies the number of scans to perform when using the save command-line
options (/scomma, /shtml, and so on...)

/stext <Filename>
Save the list of wireless networks into a regular text file.

/stab <Filename>
Save the list of wireless networks into a tab-delimited text file.

/scomma <Filename>
Save the list of wireless networks into a comma-delimited text file (csv).

/stabular <Filename>
Save the list of wireless networks into a tabular text file.

/shtml <Filename>
Save the list of wireless networks into HTML file (Horizontal).

/sverhtml <Filename>
Save the list of wireless networks into HTML file (Vertical).

/sxml <Filename>
Save the list of wireless networks into XML file.

/sort <column>
This command-line option can be used with other save options for sorting
by the desired column. If you don't specify this option, the list is
sorted according to the last sort that you made from the user interface.
The <column> parameter can specify the column index (0 for the first
column, 1 for the second column, and so on) or the name of the column,
like "SSID" and "RSSI". You can specify the '~' prefix character (e.g:
"~SSID") if you want to sort in descending order. You can put multiple
/sort in the command-line if you want to sort by multiple columns.

Examples:
WifiInfoView.exe /shtml "d:\temp\wifi.html" /sort 2 /sort ~1
WifiInfoView.exe /scomma "d:\temp\wifi.html" /sort "~Security" /sort
"SSID"

/nosort
When you specify this command-line option, the list will be saved without
any sorting.



Translating WifiInfoView to other languages
===========================================

In order to translate WifiInfoView to other language, follow the
instructions below:
1. Run WifiInfoView with /savelangfile parameter:
   WifiInfoView.exe /savelangfile
   A file named WifiInfoView_lng.ini will be created in the folder of
   WifiInfoView utility.
2. Open the created language file in Notepad or in any other text
   editor.
3. Translate all string entries to the desired language. Optionally,
   you can also add your name and/or a link to your Web site.
   (TranslatorName and TranslatorURL values) If you add this information,
   it'll be used in the 'About' window.
4. After you finish the translation, Run WifiInfoView, and all
   translated strings will be loaded from the language file.
   If you want to run WifiInfoView without the translation, simply rename
   the language file, or move it to another folder.



License
=======

This utility is released as freeware. You are allowed to freely
distribute this utility via floppy disk, CD-ROM, Internet, or in any
other way, as long as you don't charge anything for this and you don't
sell it or distribute it as a part of commercial product. If you
distribute this utility, you must include all files in the distribution
package, without any modification !



Disclaimer
==========

The software is provided "AS IS" without any warranty, either expressed
or implied, including, but not limited to, the implied warranties of
merchantability and fitness for a particular purpose. The author will not
be liable for any special, incidental, consequential or indirect damages
due to loss of data or any other reason.



Feedback
========

If you have any problem, suggestion, comment, or you found a bug in my
utility, you can send a message to nirsofer@yahoo.com
