-- ---------------------------------------------------------
--
--	MySQL
--		Anonymize alphanumeric characters in data to allow
--		for simplified construction of REGEXP queries using
--		expressions such as [0-9], [a-z] and [A-Z]
--
-- ---------------------------------------------------------


SELECT 

	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(column_name,'0','9'),'1','9'),'2','9'),'3','9'),'4','9'),'5','9'),'6','9'),'7','9'),'8','9'),'9','9')
	AS 'numeric',


	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(column_name,'a','z'),'b','z'),'c','z'),'d','z'),'e','z'),'f','z'),'g','z'),'h','z'),'i','z'),'j','z'),'k','z'),'l','z'),'m','z'),'n','z'),'o','z'),'p','z'),'q','z'),'r','z'),'s','z'),'t','z'),'u','z'),'v','z'),'w','z'),'x','z'),'y','z'),'z','z')
	AS 'alpha_lower',


	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(column_name,'A','Z'),'B','Z'),'C','Z'),'D','Z'),'E','Z'),'F','Z'),'G','Z'),'H','Z'),'I','Z'),'J','Z'),'K','Z'),'L','Z'),'M','Z'),'N','Z'),'O','Z'),'P','Z'),'Q','Z'),'R','Z'),'S','Z'),'T','Z'),'U','Z'),'V','Z'),'W','Z'),'X','Z'),'Y','Z'),'Z','Z')
	AS 'alpha_upper',


	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(column_name,'A','Z'),'B','Z'),'C','Z'),'D','Z'),'E','Z'),'F','Z'),'G','Z'),'H','Z'),'I','Z'),'J','Z'),'K','Z'),'L','Z'),'M','Z'),'N','Z'),'O','Z'),'P','Z'),'Q','Z'),'R','Z'),'S','Z'),'T','Z'),'U','Z'),'V','Z'),'W','Z'),'X','Z'),'Y','Z'),'Z','Z'),'a','Z'),'b','Z'),'c','Z'),'d','Z'),'e','Z'),'f','Z'),'g','Z'),'h','Z'),'i','Z'),'j','Z'),'k','Z'),'l','Z'),'m','Z'),'n','Z'),'o','Z'),'p','Z'),'q','Z'),'r','Z'),'s','Z'),'t','Z'),'u','Z'),'v','Z'),'w','Z'),'x','Z'),'y','Z'),'z','Z')
	AS 'alpha_upperlower'

FROM

	table_name


GROUP BY

-- REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(column_name,'0','9'),'1','9'),'2','9'),'3','9'),'4','9'),'5','9'),'6','9'),'7','9'),'8','9'),'9','9')
-- 'numeric',

-- REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(column_name,'a','z'),'b','z'),'c','z'),'d','z'),'e','z'),'f','z'),'g','z'),'h','z'),'i','z'),'j','z'),'k','z'),'l','z'),'m','z'),'n','z'),'o','z'),'p','z'),'q','z'),'r','z'),'s','z'),'t','z'),'u','z'),'v','z'),'w','z'),'x','z'),'y','z'),'z','z')
-- 'alpha_lower',

-- REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(column_name,'A','Z'),'B','Z'),'C','Z'),'D','Z'),'E','Z'),'F','Z'),'G','Z'),'H','Z'),'I','Z'),'J','Z'),'K','Z'),'L','Z'),'M','Z'),'N','Z'),'O','Z'),'P','Z'),'Q','Z'),'R','Z'),'S','Z'),'T','Z'),'U','Z'),'V','Z'),'W','Z'),'X','Z'),'Y','Z'),'Z','Z')
-- 'alpha_upper',

REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(column_name,'A','Z'),'B','Z'),'C','Z'),'D','Z'),'E','Z'),'F','Z'),'G','Z'),'H','Z'),'I','Z'),'J','Z'),'K','Z'),'L','Z'),'M','Z'),'N','Z'),'O','Z'),'P','Z'),'Q','Z'),'R','Z'),'S','Z'),'T','Z'),'U','Z'),'V','Z'),'W','Z'),'X','Z'),'Y','Z'),'Z','Z'),'a','Z'),'b','Z'),'c','Z'),'d','Z'),'e','Z'),'f','Z'),'g','Z'),'h','Z'),'i','Z'),'j','Z'),'k','Z'),'l','Z'),'m','Z'),'n','Z'),'o','Z'),'p','Z'),'q','Z'),'r','Z'),'s','Z'),'t','Z'),'u','Z'),'v','Z'),'w','Z'),'x','Z'),'y','Z'),'z','Z')
-- 'alpha_upperlower'












/*


(Note: the following were used to construct the aforementioned mysql queries)


-- ---------------------------------------------------------
-- numeric

	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(

		column_name

	,'0','9')
	,'1','9')
	,'2','9')
	,'3','9')
	,'4','9')
	,'5','9')
	,'6','9')
	,'7','9')
	,'8','9')
	,'9','9')

-- ---------------------------------------------------------
-- alpha lower
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(

		column_name

	,'a','z')
	,'b','z')
	,'c','z')
	,'d','z')
	,'e','z')
	,'f','z')
	,'g','z')
	,'h','z')
	,'i','z')
	,'j','z')
	,'k','z')
	,'l','z')
	,'m','z')
	,'n','z')
	,'o','z')
	,'p','z')
	,'q','z')
	,'r','z')
	,'s','z')
	,'t','z')
	,'u','z')
	,'v','z')
	,'w','z')
	,'x','z')
	,'y','z')
	,'z','z')


-- ---------------------------------------------------------
-- alpha upper

	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(

		column_name

,'A','Z'),'B','Z'),'C','Z'),'D','Z'),'E','Z'),'F','Z'),'G','Z'),'H','Z'),'I','Z'),'J','Z'),'K','Z'),'L','Z'),'M','Z'),'N','Z'),'O','Z'),'P','Z'),'Q','Z'),'R','Z'),'S','Z'),'T','Z'),'U','Z'),'V','Z'),'W','Z'),'X','Z'),'Y','Z'),'Z','Z')

-- ---------------------------------------------------------
-- alpha upperlower

	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(

		column_name

	,'A','Z')
	,'B','Z')
	,'C','Z')
	,'D','Z')
	,'E','Z')
	,'F','Z')
	,'G','Z')
	,'H','Z')
	,'I','Z')
	,'J','Z')
	,'K','Z')
	,'L','Z')
	,'M','Z')
	,'N','Z')
	,'O','Z')
	,'P','Z')
	,'Q','Z')
	,'R','Z')
	,'S','Z')
	,'T','Z')
	,'U','Z')
	,'V','Z')
	,'W','Z')
	,'X','Z')
	,'Y','Z')
	,'Z','Z')
	,'a','Z')
	,'b','Z')
	,'c','Z')
	,'d','Z')
	,'e','Z')
	,'f','Z')
	,'g','Z')
	,'h','Z')
	,'i','Z')
	,'j','Z')
	,'k','Z')
	,'l','Z')
	,'m','Z')
	,'n','Z')
	,'o','Z')
	,'p','Z')
	,'q','Z')
	,'r','Z')
	,'s','Z')
	,'t','Z')
	,'u','Z')
	,'v','Z')
	,'w','Z')
	,'x','Z')
	,'y','Z')
	,'z','Z')


-- ---------------------------------------------------------

*/