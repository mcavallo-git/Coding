
-- NOTE: If you want to convert strings containing 'AM'/'PM' to DateTimes/etc. in MySQL, you must do one of the following:
--       NOT use [ %H ] ... [ %p ], but rather use [ %I ]/[ %h ]/[ %l	] ... [ %p ]
--       NOT use [ %T ] ... [ %p ], but rather use [ %r ] ...[ %p ]
--       ^-- STR_TO_DATE seems to break when given both [ military 24-hour ] and [ AM/PM ] specifiers, simultaneously
SELECT
	STR_TO_DATE('11/22/33 01:02:03 PM', '%c/%e/%Y %h:%i:%S %p'),
	STR_TO_DATE('11/22/33 01:02:03 PM', '%c/%e/%Y %r')
;

SELECT
	STR_TO_DATE('11/22/33 13:02:03 PM', '%c/%e/%Y %h:%i:%S %p'),
	STR_TO_DATE('11/22/33 13:02:03 PM', '%c/%e/%Y %T')
;




/* ------------------------------------------------------------
 * 
 * Citation(s)
 * 
 * dev.mysql.com  |  "12.7 Date and Time Functions"  |  https://dev.mysql.com/doc/refman/5.6/en/date-and-time-functions.html#function_str-to-date
 * 
 ------------------------------------------------------------ */