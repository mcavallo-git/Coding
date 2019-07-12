
/* MySQL - Leap year detection */

SELECT
	CONCAT(YEAR(NOW())-3,' was a ',IF(((SELECT MOD(YEAR(NOW())-3,4) = 0) AND (SELECT MOD(YEAR(NOW())-3,100) != 0)),'LEAP','COMMON'),' year') AS 'YearType_LastLastLastYear',
	CONCAT(YEAR(NOW())-2,' was a ',IF(((SELECT MOD(YEAR(NOW())-2,4) = 0) AND (SELECT MOD(YEAR(NOW())-2,100) != 0)),'LEAP','COMMON'),' year') AS 'YearType_LastLastYear',
	CONCAT(YEAR(NOW())-1,' was a ',IF(((SELECT MOD(YEAR(NOW())-1,4) = 0) AND (SELECT MOD(YEAR(NOW())-1,100) != 0)),'LEAP','COMMON'),' year') AS 'YearType_LastYear',

	CONCAT(YEAR(NOW()),' is a ',IF(((SELECT MOD(YEAR(NOW()),4) = 0) AND (SELECT MOD(YEAR(NOW()),100) != 0)),'LEAP','COMMON'),' year') AS 'YearType_ThisYear',

	CONCAT(YEAR(NOW())+1,' will be a ',IF(((SELECT MOD(YEAR(NOW())+1,4) = 0) AND (SELECT MOD(YEAR(NOW())+1,100) != 0)),'LEAP','COMMON'),' year') AS 'YearType_NextYear',
	CONCAT(YEAR(NOW())+2,' will be a ',IF(((SELECT MOD(YEAR(NOW())+2,4) = 0) AND (SELECT MOD(YEAR(NOW())+2,100) != 0)),'LEAP','COMMON'),' year') AS 'YearType_NextNextYear',
	CONCAT(YEAR(NOW())+3,' will be a ',IF(((SELECT MOD(YEAR(NOW())+3,4) = 0) AND (SELECT MOD(YEAR(NOW())+3,100) != 0)),'LEAP','COMMON'),' year') AS 'YearType_NextNextNextYear'
;



/* ------------------------------------------------------------
 * 
 * Citation(s)
 * 
 * temptin.wordpress.com  |  "mysql function to find if a year is leap year or not"  |  https://temptin.wordpress.com/2008/10/26/mysql-function-to-find-if-a-year-is-leap-year-or-not/
 * 
 ------------------------------------------------------------ */