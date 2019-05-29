
// ------------------------------------------------------------

define

	device Sensors_TempInterior_1stFloor = ...

	device Sensors_TempInterior_2ndFloor = ...

end define;

execute

	on events from

		Any of {Sensors_TempInterior_1stFloor} or {Sensors_TempInterior_1stFloor} temperature

	do

		// ------------------------------------------------------------

		Set variable {@TemperatureAvg_1stFloor} = {
			round(
				sum([Sensors_TempInterior_1stFloor:temperature]) / count([Sensors_TempInterior_1stFloor:temperature]),
				0
			)
		}

		// ------------------------------------------------------------

		Set variable {@TemperatureAvg_2ndFloor} = {
			round(
				sum([Sensors_TempInterior_2ndFloor:temperature]) / count([Sensors_TempInterior_2ndFloor:temperature]),
				0
			)
		}

		// ------------------------------------------------------------

		Set variable {@TemperatureAvg_AllFloors} = {
			round(
				sum(
					round(
						sum([Sensors_TempInterior_1stFloor:temperature]) / count([Sensors_TempInterior_1stFloor:temperature]),
						0
					),
					round(
						sum([Sensors_TempInterior_2ndFloor:temperature]) / count([Sensors_TempInterior_2ndFloor:temperature]),
						0
					)
				) / 2,
				0
			)
		}

	end on;

end execute;

// ------------------------------------------------------------
