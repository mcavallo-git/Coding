# ------------------------------------------------------------
#
# PowerShell - FTYPE (CMD Command) (displays or modifies file types used in file extension associations)
#
# ------------------------------------------------------------

# General Syntax
#      <FileType>            Specifies the file type to display or change.
#      <OpenCommandString>   Specifies the open command string to use when opening files of the specified file type.
#      /?                    Displays help at the command prompt.

FTYPE [<FileType>[=[<OpenCommandString>]]]


# ------------------------------------------------------------

# List file name extension associations active for current session
CMD /C FTYPE

# Walk through the list of filetypes
$Assocs_Obj=@{};
$FTypes_Obj=@{};
CMD /C ASSOC | Sort-Object | ForEach-Object { $Components=("${_}".Split("=")); $Assocs_Obj.("$(${Components}[0])")=("$(${Components}[1..$(${Components}.Count)]);"); };
CMD /C FTYPE | Sort-Object | ForEach-Object { $Components=("${_}".Split("=")); $FTypes_Obj.("$(${Components}[0])")=("$(${Components}[1..$(${Components}.Count)]);"); };
# $Assocs_Sorted_Obj = ($Assocs_Obj.Keys | Sort-Object | ForEach-Object { @{"${_}"="$($Assocs_Obj.("${_}"))";}; });
# $FTypes_Sorted_Obj = ($FTypes_Obj.Keys | Sort-Object | ForEach-Object { @{"${_}"="$($FTypes_Obj.("${_}"))";}; });
# $Assocs_Sorted_Obj | Format-Table -AutoSize;
# $FTypes_Sorted_Obj | Format-Table -AutoSize;

PS C:\Windows\system32> $aaa="abcdef;"

"abcdef;" -replace "^((?:(?!;).)+)(;)?$",'$1';
# abcdef

"abcdef:" -replace "^((?:(?!;).)+)(;)?$",'$1';
# abcdef:


$Assocs_Resolved_Obj=($Assocs_Obj.Keys | Sort-Object | ForEach-Object {
	$Assoc_to_FType_Key=(${Assocs_Obj}.("${_}"));
	@{"${_}"="$(${FTypes_Obj}.("${Assoc_to_FType_Key}"))";};
});

# ------------------------------------------------------------

# List file name extension associations active for current session
CMD /C FTYPE


# Store list of current session's [ filetype associations with filename extensions ] on a file on the desktop
CMD /C FTYPE FTYPE 1>"${HOME}\Desktop\cmd.ftype.log"
notepad.exe "${HOME}\Desktop\cmd.ftype.log"


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "ftype - Displays or modifies file types that are used in file name extension associations"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/ftype
#
# ------------------------------------------------------------