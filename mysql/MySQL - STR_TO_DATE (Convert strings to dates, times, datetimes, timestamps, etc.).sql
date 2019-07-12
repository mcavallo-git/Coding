
/* MySQL - Converting Strings to DateTimes */

-- If using military-time you can use any of:
SELECT
	STR_TO_DATE('1/2/3 14:25:36', '%c/%e/%Y %H:%i:%S'),
	STR_TO_DATE(CONCAT(DATE('2003-02-01'),' ',TIME(CONCAT('14:25',':59'))), '%Y-%e-%c %H:%i:%S'),
	STR_TO_DATE('01/02/2003 14:25', '%c/%e/%Y %T'),
	STR_TO_DATE('01/02/2003 14:25:36', '%c/%e/%Y %T')
;



-- NOTE: If you want to convert strings containing 'AM'/'PM' to DateTimes/etc. in MySQL, you must do one of the following:
--       NOT use [ %H ] ... [ %p ], but rather use [ %I ]/[ %h ]/[ %l	] ... [ %p ]
--       NOT use [ %T ] ... [ %p ], but rather use [ %r ] ...[ %p ]
--       ^-- STR_TO_DATE seems to break when given both [ military 24-hour ] and [ AM/PM ] specifiers, simultaneously
SELECT
	STR_TO_DATE('1/2/3 1:2:3 PM', '%c/%e/%Y %h:%i:%S %p'),
	STR_TO_DATE('01/02/2003 01:02:03 PM', '%c/%e/%Y %r')
;




/* ------------------------------------------------------------
 * 
 * Citation(s)
 * 
 * dev.mysql.com  |  "12.7 Date and Time Functions"  |  https://dev.mysql.com/doc/refman/5.6/en/date-and-time-functions.html#function_str-to-date
 * 
 ------------------------------------------------------------ */