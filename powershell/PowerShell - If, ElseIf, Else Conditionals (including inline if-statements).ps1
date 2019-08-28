
<# Example of an Inline If-Else Conditional #>
$GetLoopbackAddress = If ($PSBoundParameters.ContainsKey('GetLoopbackAddress') -Eq $True) { $True } Else ( $GetLoopbackAddress );
