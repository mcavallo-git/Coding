# ------------------------------------------------------------
#
#	PowerShell
#		Select-XML --> "Finds text in an XML string or document"
#



# ------------------------------------------------------------
# Example using XML structure mocked from ESET Antivirus

$XmlContents = '
<ESET>
 <PRODUCT NAME="endpoint" VERSION="7.1.2045">
  <ITEM NAME="plugins">
   <ITEM NAME="01000101">
    <ITEM NAME="settings">
     <ITEM NAME="ExcludedProcesses" DELETE="1">
      <NODE NAME="1" TYPE="string" VALUE="FULLPATH_TO_AN_EXCLUDED_PROCESS_HERE" />
     </ITEM>
    </ITEM>
   </ITEM>
   <ITEM NAME="01000600">
    <ITEM NAME="settings">
     <ITEM NAME="ScannerExcludes" DELETE="1">
      <ITEM NAME="1">
       <NODE NAME="1" TYPE="string" VALUE="FULLPATH_TO_AN_EXCLUDED_FILEPATHS_HERE" />
      </ITEM>
     </ITEM>
    </ITEM>
   </ITEM>
  </ITEM>
 </PRODUCT>
</ESET>
';
$XmlContents `
| Select-Xml `
	-XPath "/ESET/PRODUCT[@NAME='endpoint']/ITEM[@NAME='plugins']/ITEM[@NAME='01000101']/ITEM[@NAME='settings']/ITEM[@NAME='ExcludedProcesses'][@DELETE='1']/NODE" `
| ForEach-Object {
	$_.Node | Format-List;
	# ($_.Node.InnerXML) <# Node/Element's Inner-HTML #>
};



# ------------------------------------------------------------
# Example
#   |--> View an ESET export's excluded processes

$XmlFullpath = "$(${Env:USERPROFILE})\Desktop\eset-export.xml";
Select-Xml `
	-Path "$($XmlFullpath)" `
	-XPath "/ESET/PRODUCT[@NAME='endpoint']/ITEM[@NAME='plugins']/ITEM[@NAME='01000101']/ITEM[@NAME='settings']/ITEM[@NAME='ExcludedProcesses'][@DELETE='1']/NODE" `
| ForEach-Object {
	$_.Node | Format-List;
	# ($_.Node.InnerXML) <# Node/Element's Inner-HTML #>
};



# ------------------------------------------------------------
# Example
#   |--> View an ESET export's excluded filepaths

$XmlFullpath = "$(${Env:USERPROFILE})\Desktop\eset-export.xml"; `
Select-Xml `
	-Path "$($XmlFullpath)" `
	-XPath "/ESET/PRODUCT[@NAME='endpoint']/ITEM[@NAME='plugins']/ITEM[@NAME='01000600']/ITEM[@NAME='settings']/ITEM[@NAME='ScannerExcludes'][@DELETE='1']/ITEM" `
| ForEach-Object {
	$_.Node | Format-List;
	# ($_.Node.InnerXML) <# Node/Element's Inner-HTML #>
};



# ------------------------------------------------------------


$XmlFullpath = "$(${Env:USERPROFILE})\Desktop\eset-export.xml"; `
$XmlDoc = (Get-Content $XmlFullpath) -as [Xml];
$XmlDoc.GetType();
#			IsPublic IsSerial Name                                     BaseType
#			-------- -------- ----                                     --------
#			True     False    XmlDocument                              System.Xml.XmlNode


# ------------------------------------------------------------
#
#	XPath Query Notes:
#
#				PREFIX     EXPLANATION
#
#				/          Child  (matches direct-descendants only)
#
#				//         Descendant  (matched to the Nth degree, e.g. matches a child, great-great-grandchild, etc.)
#
#
# ------------------------------------------------------------
#
#	Citation(s)
#
#		docs.microsoft.com  |  "Select-Xml - Finds text in an XML string or document"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-xml
#
#		docs.microsoft.com  |  "XmlDocument.CreateNode Method"  |  https://docs.microsoft.com/en-us/dotnet/api/system.xml.xmldocument.createnode
#
#		docs.microsoft.com  |  "XmlDocument.ImportNode(XmlNode, Boolean) Method"  |  https://docs.microsoft.com/en-us/dotnet/api/system.xml.xmldocument.importnode
#
#		devhints.io  |  "Xpath cheatsheet"  |  https://devhints.io/xpath
#
#	------------------------------------------------------------
