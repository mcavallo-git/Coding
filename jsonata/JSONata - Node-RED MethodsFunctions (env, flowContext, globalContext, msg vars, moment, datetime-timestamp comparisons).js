// ------------------------------------------------------------
// JSONata - Node-Red Methods/Functions (env, flowContext, globalContext, msg vars, moment, datetime-timestamp_last_active comparisons).js
// ------------------------------------------------------------

Note that this is really just a big scratch pad while practicing JSONata in Node-RED

// ------------------------------------------------------------

(payload)  // msg._____ variable syntax

// $$.payload

($env('timeout_minutes'))

($flowContext('timeout_minutes'))

($globalContext('inactivity_lights_off_after_minutes'))

// ------------------------------

// moment_now
($moment();)

// timestamp_last_active
($flowContext("timestamp_last_active");)

// moment_test
($moment().diff(($flowContext("timestamp_last_active")),'seconds');)

// timeout_after
($timeout_after :=$moment($flowContext("timestamp_last_active")).add(($flowContext("timeout_minutes")),'minutes');)


// datetime_inactive_after
($datetime_inactive_after := $moment($flowContext("timestamp_last_active")).add(($flowContext("timeout_minutes")),'minutes');)

// Set msg.seconds_until_inactive
(
  $datetime_now := $moment();
  $datetime_inactive_after := $moment($flowContext("timestamp_last_active")).add(($flowContext("timeout_minutes")),'minutes');
  $datetime_inactive_after.diff($datetime_now,'seconds');
)

// Set msg.seconds_until_inactive
($datetime_now:=$moment(); $datetime_inactive_after:=$moment($flowContext("timestamp_last_active")).add(($flowContext("timeout_minutes")),'minutes'); $datetime_inactive_after.diff($datetime_now,'seconds');)

// ------------------------------

// Set msg.seconds_until_inactive
($datetime_now:=$moment(); $datetime_inactive_after:=$moment($globalContext('timestamp_last_active')).add(($globalContext("timeout_minutes")),'minutes'); $datetime_inactive_after.diff($datetime_now,'seconds');)


// Set msg.seconds_until_inactive
($datetime_now:=$moment(); $datetime_inactive_after:=$moment($globalContext('timestamp_last_active')).add(($globalContext("timeout_minutes")),'minutes'); $datetime_inactive_after.diff($datetime_now,'seconds');)

// ------------------------------

(
  $datetime_now := $moment();
  $datetime_inactive_after := $moment($globalContext($env('global_var'))).add(($globalContext("timeout_minutes")),'minutes');
  $datetime_inactive_after.diff($datetime_now,'seconds');
)

// ------------------------------

// Set msg.seconds_until_inactive
(
  $datetime_now:=$moment();
  $datetime_inactive_after:=$moment(payload).add(($env('timeout_minutes')),'minutes');
  $datetime_inactive_after.diff($datetime_now,'seconds');
)


// Set msg.seconds_until_inactive
($datetime_now:=$moment();$datetime_inactive_after:=$moment(payload).add(($env('timeout_minutes')),'minutes');$datetime_inactive_after.diff($datetime_now,'seconds');)

// ------------------------------

// Set msg.seconds_until_inactive
($datetime_now:=$moment();$datetime_inactive_after:=$moment(payload).add(($env('timeout_minutes')),'minutes');$datetime_inactive_after.diff($datetime_now,'seconds');)


// ------------------------------------------------------------


// J: expression  (jsonata expression)

// Set [ msg.timeA ] to the value:
$moment(payload,['DD.MM.YYYY HH:mm:ss','x'],'de').format('DD.MM.YYYY HH:mm:ss')


// Set [ msg.timeB ] to the value:
// J: expression  (jsonata expression)
(	    $x := x;	    $moment(payload,['DD.MM.YYYY HH:mm:ss','x'],'de').add($x).format('DD.MM.YYYY HH:mm:ss');	    )


// Set [ msg.payload ] to the value:
// J: expression  (jsonata expression)
(	    $b := $moment(timeB,['DD.MM.YYYY HH:mm:ss','x'],'de');	    $a := $moment(timeA,['DD.MM.YYYY HH:mm:ss','x'],'de');	    	    /* $b.diff($a) */	    /* $moment.duration($b.diff($a)); */	    	        /* Kein Zugriff auf duration  - also manuell berechnen*/	        	    $days := $b.diff($a, 'days');	    $hours := $b.diff($a, 'hours') - 24 * $b.diff($a, 'days');	    $minutes := $b.diff($a, 'minutes') - 60 * $b.diff($a, 'hours');	    $seconds := $b.diff($a, 'seconds') - 60 * $b.diff($a, 'minutes');	    	    $sec := $b.diff($a)/1000;	    		    	    $difference := {	        "days": $days,	        "hours":$hours,	        "minutes": $minutes,	        "seconds": $seconds	    }; 	    		)



// (
//   $b := $moment(timeB,['DD.MM.YYYY HH:mm:ss','x'],'de');
//   $a := $moment(timeA,['DD.MM.YYYY HH:mm:ss','x'],'de');
//   /* $b.diff($a) */	    /* $moment.duration($b.diff($a)); */
//   /* Kein Zugriff auf duration  - also manuell berechnen*/
//   $days := $b.diff($a, 'days');
//   $hours := $b.diff($a, 'hours') - 24 * $b.diff($a, 'days');
//   $minutes := $b.diff($a, 'minutes') - 60 * $b.diff($a, 'hours');
//   $seconds := $b.diff($a, 'seconds') - 60 * $b.diff($a, 'minutes');
//   $sec := $b.diff($a)/1000;
//   $difference := { "days": $days, "hours":$hours, "minutes": $minutes, "seconds": $seconds };
// )



// $moment(msg.payload).subtract(1,"w").format("x")

// $days := $moment().diff((flow.get('timestamp_last_active')),'seconds');


// (
//   $b := $moment(timeB,['DD.MM.YYYY HH:mm:ss','x'],'de');
//   $a := $moment(timeA,['DD.MM.YYYY HH:mm:ss','x'],'de');
//   /* $b.diff($a) */	    /* $moment.duration($b.diff($a)); */
//   /* Kein Zugriff auf duration  - also manuell berechnen*/
//   $days := $b.diff($a, 'days');
//   $hours := $b.diff($a, 'hours') - 24 * $b.diff($a, 'days');
//   $minutes := $b.diff($a, 'minutes') - 60 * $b.diff($a, 'hours');
//   $seconds := $b.diff($a, 'seconds') - 60 * $b.diff($a, 'minutes');
//   $sec := $b.diff($a)/1000;
//   $difference := { "days": $days, "hours":$hours, "minutes": $minutes, "seconds": $seconds };
// )


// ------------------------------------------------------------
//
// Citation(s)
//
//   momentjs.com  |  "Moment.js | Docs"  |  https://momentjs.com/docs/#/displaying/format/
//
// ------------------------------------------------------------