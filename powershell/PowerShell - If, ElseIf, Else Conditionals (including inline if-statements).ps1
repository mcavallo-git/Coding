
<# Example of an Inline If-Else Conditional #>
$GetLoopbackAddress = If ($PSBoundParameters.ContainsKey('GetLoopbackAddress') -Eq $True) { $True } ElseIf (0 -Eq 1) { 0 } Else { $GetLoopbackAddress };
