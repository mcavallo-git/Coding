# ---------------------------------------------------------------------------------------------------------------
#	
#	Windows PowerShell - ValidateSet (& ValidatePattern)
#
#


#	---------------------------------------------------------------------------------------------------------------
#
#	Set a parameter requirement to enforce that the parameter's value is restricted to a given set of items:
#
#		ValidateSet('value_1','value_2', [...] ,'value_n-1','value_n')
#
#
# Example...
#
function Get-Foo {
	param (
		[ValidateSet('laptop','desktop')]
		[ValidatePattern('(?-i:^[a-z]+$)')]
		[string]$Type
	)
	$Type
}
#
#		^-- the function Get-Foo does the same high-level validation-routine (in-essence) as the function Get-Bar, below --v
#
#		Note:  ValidateSet's "IgnoreCase" option, by default, is set to $true, aka by-default, ValidateSet is case in-sensitive
#
function Get-Bar {
param (
	[ValidateSet('laptop','desktop',IgnoreCase = $false)]
	[string]$Type
)
	$Type
}



# ---------------------------------------------------------------------------------------------------------------
#
# Citation: https://becomelotr.wordpress.com/2012/01/31/case-sensitive-validateset/
#
# ---------------------------------------------------------------------------------------------------------------
