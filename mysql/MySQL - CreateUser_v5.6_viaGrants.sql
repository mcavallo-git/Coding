
-- Creating a user in MySQL 5.6- (via Grants, as the CREATE USER method was introduced in MySQL 5.7)

GRANT USAGE
ON *.*
TO 'some_guy'@'%'
IDENTIFIED BY 'passwordFullaSwearWords'
REQUIRE SSL
;

-- ^^^ vvv Two Different Approaches, Same End-Result

SELECT PASSWORD('passwordFullaSwearWords');/*-->  *8B2EA8A287CA18E507886D08A1CC90DF70C942B7   */
                         /*   |   */
GRANT USAGE              /*   |   */
ON *.*                   /*   |   */
TO 'some_guy'@'%'        /*   V   */
IDENTIFIED BY PASSWORD '*8B2EA8A287CA18E507886D08A1CC90DF70C942B7'
REQUIRE SSL
;
