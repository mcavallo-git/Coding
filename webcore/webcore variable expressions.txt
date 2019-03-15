---------------------------------------------------------------------------------------------------------------------------------------

	WebCore Functions
			Refer to:  https://wiki.webcore.co/Functions#formatDateTime

---------------------------------------------------------------------------------------------------------------------------------------

time

	Syntax
		time time(datetime value)
	Returns
		Returns the time portion of value by stripping off date information.
	
	
	(expression) time($sunrise) »»» (time) 28260000
	(expression) time($now)     »»» (time) 7584323
	(expression) time($sunset)  »»» (time) 71040000
	
	
	time($sunrise) < time($now) && time($sunrise) < time($now)
	
---------------------------------------------------------------------------------------------------------------------------------------

isBetween

	Syntax
		isBetween(dynamic value, dynamic startValue, dynamic endValue)
	Returns
		Returns true if value is greater then or equal to startValue and less than or equal to endValue
	
	
	
	isBetween(time($now), time($sunrise), time($sunset))
	
---------------------------------------------------------------------------------------------------------------------------------------

addMinutes(dateTime, minutes)

	adds minutes to time, returns the value as a time type

	addMinutes(time($sunrise), 15)
	addMinutes(time($sunset), -15)
	
	isBetween(time($now), addMinutes(time($sunrise), 15), addMinutes(time($sunset), -15))



---------------------------------------------------------------------------------------------------------------------------------------

















---------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------