
$Directory_ToSearch = 'C:';

$Filetype_ToDetect = "video";

$ActiveXDataObject_Connection = (New-Object -com ADODB.Connection);
$ActiveXDataObject_RecordSet = (New-Object -com ADODB.Recordset);
$objConnection.Open("Provider=Search.CollatorDSO;Extended Properties='Application=Windows';");
${ActiveXDataObject_RecordSet}.Open("SELECT System.ItemPathDisplay FROM SYSTEMINDEX WHERE System.Kind = '${Filetype_ToDetect}' AND System.ItemPathDisplay LIKE '${Directory_ToSearch}\%'", ${ActiveXDataObject_Connection});
If (${ActiveXDataObject_RecordSet}.EOF -Eq $False) {
	${ActiveXDataObject_RecordSet}.MoveFirst();
}
While (${ActiveXDataObject_RecordSet}.EOF -NE $True) {
	${ActiveXDataObject_RecordSet}.Fields.Item("System.ItemPathDisplay").Value;
	${ActiveXDataObject_RecordSet}.MoveNext();
}



# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "Is it possible to find all the video files using powershell? - Stack Overflow"  |  https://stackoverflow.com/a/16295322
#
# ------------------------------------------------------------