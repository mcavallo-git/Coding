/* ----------------------------------------------------------------------------------------------------------------------------------------------------------------- */

/* METHOD - Obfuscated Sub-Select */

/* Inserting data from a table back into itself via an obfuscated sub-select query */

INSERT INTO `test_database`.`test_table`
(
	test_uid_key
	, test_col_1_key
	, test_col_2_key
	, test_col_3_key
	, test_col_4_key
)
(
	SELECT * FROM (
		SELECT
			'test_uid_val'
			, 'test_col_1_val'
			, 'test_col_2_val'
			, 'test_col_3_val'
			, 'test_col_4_val'
		) AS tmp
	WHERE NOT EXISTS (
		SELECT test_uid_key
		FROM `test_database`.`test_table`
		WHERE test_uid_key = 'test_uid_val'
	) LIMIT 1
);

/* ----------------------------------------------------------------------------------------------------------------------------------------------------------------- */
