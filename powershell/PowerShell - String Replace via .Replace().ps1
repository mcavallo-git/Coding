# ------------------------------------------------------------
#
# PowerShell
# 	|
# 	|--> String replace via .Replace()   !!!  CASE SENSITIVE  !!!
# 	|
# 	|--> String replace via -Replace     !!!  CASE IN-SENSITIVE  !!!
#
# ------------------------------------------------------------

"Hello City!".Replace("City","World"); # Outputs: 'Hello World!'


"Hello City!" -Replace "city","World"); # Outputs: 'Hello World!'

