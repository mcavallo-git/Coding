# -*- coding: utf-8 -*-

# pip install --upgrade pip
# pip install --upgrade psutil


import json
import psutil
import sys


from prtg.sensor.result import CustomSensorResult
from prtg.sensor.units import ValueUnit


if __name__ == "__main__":
	try:
		data = json.loads(sys.argv[1])
		csr = CustomSensorResult(text="This sensor runs on %s" % data["host"])
		csr.add_primary_channel(
			name="Percentage",
			value=87,
			unit=ValueUnit.PERCENT,
			is_float=False,
			is_limit_mode=True,
			limit_min_error=10,
			limit_max_error=90,
			limit_error_msg="Percentage too high"
		)
		csr.add_channel(
			name="Response Time",
			value=4711,
			unit=ValueUnit.TIMERESPONSE
		)
		print(csr.json_result)
	except Exception as e:
		csr = CustomSensorResult(text="Python Script execution error")
		csr.error = "Python Script execution error: %s" % str(e)
		print(csr.json_result)


# ------------------------------------------------------------
#
# Citation(s)
#
#   dev.to  |  "Python to .exe: How to convert .py to .exe? Step by step guide. - DEV"  |  https://dev.to/eshleron/how-to-convert-py-to-exe-step-by-step-guide-3cfi
#
#   psutil.readthedocs.io  |  "psutil documentation — psutil 5.7.1 documentation"  |  https://psutil.readthedocs.io/en/latest/
#
#   www.freecodecamp.org  |  "Check the temperature of your CPU using Python (and other cool tricks)"  |  https://www.freecodecamp.org/news/using-psutil-in-python-8623d9fac8dd/
#
# ------------------------------------------------------------