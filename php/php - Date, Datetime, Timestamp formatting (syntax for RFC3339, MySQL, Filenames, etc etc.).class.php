<?php
// ------------------------------------------------------------
// Date  (PHP Class)
//    |
//    |-> Simplifies Timestamp exporting/importing while keeping full microsecond precision AND timezone accuracy
//    |
//    |-> Replaces DateTime::RFC3339_EXTENDED (requires PHP 7+) with Date::RFC3339_MICROSECONDS (see below)
//    |
//    |-> Note: In PHP 7, there exists a bug while using RFC3339_EXTENDED in conjunction with DateTime::createFromFormat regarding the milliseconds ('v'), which microseconds ('u') avoids
//
if (class_exists('Date')===false) {
	class Date extends DateTime {

		const FRONTEND_DATE = "m/d/Y";
		//    08/15/2005                            "m/d/Y"

		const FRONTEND_DATE_LONG = "m/d/Y (l)";
		//    08/15/2005 (Monday)                   "m/d/Y (l)"

		const FRONTEND_DATETIME = "m/d/Y H:i:s";
		//    08/15/2005 15:52:01                   "m/d/Y H:i:s"

		const FRONTEND_DATETIME_LONG = "m/d/Y h:i:s A";
		//    08/15/2005 03:52:01 PM                "m/d/Y h:i:s A"

		const RFC3339_MICROSECONDS = "Y-m-d\TH:i:s.uP";
		//    2005-08-15T15:52:01.457896+00:00      "Y-m-d\TH:i:s.uP"

		const RFC2822_MICROSECONDS = "D, d M Y H:i:s.u O";
		//    Mon, 15 Aug 2005 15:52:01.457896 +0000   "D, d M Y H:i:s.u O"

		const FILENAME_TIMESTAMP = "Y-m-d.H-i-s";
		//    2005-08-15.15-52-01                   "Y-m-d.H-i-s"

		const FILENAME_TIMESTAMP_MICROSECONDS = "Y-m-d.H-i-s.u";
		//    2005-08-15.15-52-01.457896            "Y-m-d.H-i-s.u"
		
		const MYSQL_DATE = "Y-m-d";
		//    2005-08-15                            "Y-m-d"

		const MYSQL_DATETIME  = "Y-m-d H:i:s";
		const MYSQL_TIMESTAMP = "Y-m-d H:i:s";
		//    2005-08-15 15:52:01                   "Y-m-d H:i:s"

		// const RFC3339
		// const ATOM
		// const DATE_ATOM 
		// const W3C
		//    2005-08-15T15:52:01+00:00             "Y-m-d\TH:i:sP"
		
		// const RFC3339_EXTENDED
		//    2005-08-15T15:52:01.000+00:00         "Y-m-d\TH:i:s.vP"

		// const RFC1123
		// const RFC2822
		// const RSS
		//    Mon, 15 Aug 2005 15:52:01 +0000       "D, d M Y H:i:s O"

		// const RFC822
		// const RFC1036
		//    Mon, 15 Aug 05 15:52:01 +0000         "D, d M y H:i:s O"

		// const COOKIE
		//    Monday, 15-Aug-2005 15:52:01 UTC      "l, d-M-Y H:i:s T"

		// const RFC850
		//    Monday, 15-Aug-05 15:52:01 UTC        "l, d-M-y H:i:s T"
		
		// WARNING - DateTimeInterface::ISO8601 is not compatible with ISO-8601 - it was left this way for backward compatibility reasons. Use DateTime::RFC3339 or DateTime::ATOM, instad
		// const ISO8601
		//    2005-08-15T15:52:01+0000              "Y-m-d\TH:i:sO"

		// public function __construct(...) {
		// ...
		// 	PULLED FROM PARENT CLASS 'DateTime' (PHP native class)
		// ...
		// }

		// function getTimezoneOffset() {
		// 	...
		// 		PULLED FROM PARENT CLASS 'DateTime' (PHP native class)
		// 	...
		// }

		function getJsTimezoneOffset() {
			// TODO: Add code to mirror Javascript logic
		}

		function getFullYear() {
			// TODO: Add code to mirror Javascript logic
		}

		function getMonth() {
			// TODO: Add code to mirror Javascript logic
		}

		function getDate() {
			// TODO: Add code to mirror Javascript logic
		}

		function getHours() {
			// TODO: Add code to mirror Javascript logic
		}

		function getMinutes() {
			// TODO: Add code to mirror Javascript logic
		}

		function getSeconds() {
			// TODO: Add code to mirror Javascript logic
		}

	}
}


// ------------------------------------------------------------
// format_datetime  (PHP Function)
//   |
//   |--> Format a date coming from [ PHP-Class-Object ] format, and format is to [ MySQL Database (YYYY-mm-dd) ] format
//
if (!function_exists('format_datetime')) {
	function format_datetime($datetime_str="", $format_str=DATE_RFC3339, $set_timezone="UTC", $input_format="") {
		//	Numeric DateTime strings crash/error-out during PHP's default DateTime constructor 
		//	 |--> If we're given a numeric string without an associated input-format, then handle it as "EpochSeconds.DecimalSeconds" formatted-input
		if ((empty($input_format)===true) && (is_numeric($datetime_str)===true)) {
			if (is_decimal($datetime_str)===true) {
				// WITH decimal seconds, e.g. "1565893386.629922"
				$datetime_str = number_format(floatval($datetime_str), 6, '.', '');
				$input_format = "U.u";
			} else {
				// NO decimal seconds, e.g. "1565893386"
				$datetime_str = number_format(intval($datetime_str), 0, '', '');
				$input_format = "U";
			}
		}

		if ((empty($input_format)===false) && (is_string($input_format)===true)) {
			// Instantiate the DateTime object with a given date-string format ( see: https://www.php.net/manual/en/function.date.php )
			$timestamp_obj = Date::createFromFormat($input_format, $datetime_str);

		} elseif (in_array(strtolower($datetime_str),array("","now"))) {
			$timestamp_obj = new Date("now");

		} else {
			// is_decimal
			$timestamp_obj = new Date($datetime_str);

		}
		
		// Set the Input Timezone (if-empty)
		if (empty($set_timezone)===true) {
			$set_timezone = date_default_timezone_get();
		} elseif ((is_string($set_timezone)===true) && (in_array(strtolower($set_timezone),array("edt","est","server")))) {
			$set_timezone = date_default_timezone_get();
		}
		$timestamp_obj->setTimezone(new DateTimeZone($set_timezone));

		// Set the Output Formatting (if-empty)
		if (empty($format_str)===true) {
			$format_str=DATE_RFC3339;
		}

		// Return the final, formatted datetime string
		return ($timestamp_obj->format($format_str));
	}
}


// ------------------------------------------------------------
// format_date_to_mysql  (PHP Function)
//   |
//   |--> Formats a date coming from [ End-User Readable (mm/dd/YYYY) ] format, and format is to [ MySQL Database (YYYY-mm-dd) ] format
//
if (!function_exists('format_date_to_mysql')) {
	function format_date_to_mysql($orig_date, $format="Y-m-d") {
		// If formatted like 2007-02-04, then just return it.
		if (preg_match('/\A\d{4}-\d{2}-\d{2}\z/', $orig_date)) {
			$formatted_date = $orig_date;
		// If 3 Mar 2008 type, convert it -- Note: This format (dd mmm yyyy) is commonly used by the US Military
		} elseif (preg_match('%\b(0?[1-9]|[12][0-9]|3[01])[- /][A-Za-z]{3}[- /](19|20)?[0-9]{2}\b%m', $orig_date)) {
			$date_stamp = strtotime(str_replace(array("/","-"), " ", $orig_date));
			$formatted_date = date("Y-m-d", $date_stamp);
		} else {
			// Check for invalid date
			list($mm,$dd,$yy)=explode("/",str_replace("-", "/", $orig_date));
			if (not_null($orig_date) && checkdate(intval($mm),intval($dd),intval($yy))) {
				$formatted_date = str_pad($yy, 4, '200', STR_PAD_LEFT).'-'.str_pad($mm, 2, '0', STR_PAD_LEFT).'-'.str_pad($dd, 2, '0', STR_PAD_LEFT);
			} else {
				$formatted_date = "0000-00-00";
			}
		}
		return $formatted_date;
	}
}


// ------------------------------------------------------------
// format_date_from_mysql  (PHP Function)
//   |
//   |--> Format a date coming from [ MySQL Database (YYYY-mm-dd) ] format, and format is to [ End-User Readable (mm/dd/YYYY) ] format
//
if (!function_exists('format_date_from_mysql')) {
	function format_date_from_mysql($orig_date, $format="m/d/Y") {
		if (not_null($orig_date)) {
			$date_stamp = strtotime($orig_date);
			$formatted_date = date($format, $date_stamp);
		} else {
			$formatted_date = '';
		}
		return $formatted_date;
	}
}


// ------------------------------------------------------------
// Citation(s)
//
//   php.net  |  "date (format chars)"  |  https://www.php.net/manual/en/function.date.php
//
//   php.net  |  "DateTime (class)"  |  https://php.net/manual/en/class.datetime.php
//
//   php.net  |  "DateTime::createFromFormat"  |  https://php.net/manual/en/datetime.createfromformat.php
//
// ------------------------------------------------------------

?>