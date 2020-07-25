<?php
$microsec_begin = microtime(true); echo '--- Initiate program ---'."\n";
// ------------------------------------------------------------
// PHP - Sandbox  -->  https://3v4l.org/P8Jd6
// ------------------------------------------------------------



$_dat_array = array(

	'var__a'

		=>	1,


	'var__b'

		=>	2,


	'var__c'

		=>	3,


	'var__d'

		=>	4

);




echo "\n_dat_array (".gettype($_dat_array).") = \n".print_r($_dat_array,true)."";

echo "\n_dat_array ? ".($_dat_array ? 'true' : 'false');





// ------------------------------------------------------------
$microsec_net = number_format((microtime(true)-$microsec_begin),6).'s'; echo "\n"."\n".'--- End of Line after ['.$microsec_net.'] ---';
?>