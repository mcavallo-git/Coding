// ------------------------------------------------------------
// JSONata - Node-Red Methods/Functions (env, flowContext, globalContext, msg vars, moment, datetime-timestamp_last_active comparisons).js
// ------------------------------------------------------------
//
// ⚠️ Note that this is really just a big scratch pad used while practicing JSONata in Node-RED
//
// ------------------------------------------------------------


// JSONata Expression - Message Variables
(payload)


// JSONata Expression - Message Payload
$$.payload


// JSONata Expression - Environment Variables
($env('timeout_minutes');)


// JSONata Expression - Flow Variables
($flowContext('timeout_minutes');)


// JSONata Expression - Global Variables
($globalContext('inactivity_lights_off_after_minutes');)


// ------------------------------


// moment.now - Get current Datetime (equivalent to "new Date();" or "Date.now();")
($moment();)


// moment.diff($val) - Subtract $val from the moment's datetime (e.g. "Get the difference between the two dates")
($moment().diff(($flowContext('timestamp_last_active')),'seconds');)


// ------------------------------------------------------------


// Ex)  message variable(s)
(
  $datetime_now := $moment();
  $datetime_inactive_after := $moment(payload).add(timeout_minutes,'minutes');
  $difference := $datetime_inactive_after.diff($datetime_now,'seconds');
)

// Ex)  environment variable(s)
(
  $datetime_now := $moment();
  $datetime_inactive_after := $moment(payload).add(($env('timeout_minutes')),'minutes');
  $difference := $datetime_inactive_after.diff($datetime_now,'seconds');
)


// Ex)  flow variable(s)
(
  $datetime_now := $moment();
  $datetime_inactive_after := $moment($flowContext('timestamp_last_active')).add(($flowContext('timeout_minutes')),'minutes');
  $difference := $datetime_inactive_after.diff($datetime_now,'seconds');
)


// Ex)  global variable(s)
(
  $datetime_now := $moment();
  $datetime_inactive_after := $moment(payload).add(($globalContext('timeout_minutes')),'minutes');
  $difference := $datetime_inactive_after.diff($datetime_now,'seconds');
)


// Ex)  global variable(s) whose variable name is defined by an environment variable(s)
(
  $datetime_now := $moment();
  $datetime_inactive_after := $moment(payload).add(($globalContext($env('global_var'))),'minutes');
  $difference := $datetime_inactive_after.diff($datetime_now,'seconds');
)


// ------------------------------------------------------------


// J: expression  (jsonata expression)

// Set [ msg.timeA ] to the value:
$moment(payload,['DD.MM.YYYY HH:mm:ss','x'],'de').format('DD.MM.YYYY HH:mm:ss')


// Set [ msg.timeB ] to the value:
// J: expression  (jsonata expression)
(	    $x := x;	    $moment(payload,['DD.MM.YYYY HH:mm:ss','x'],'de').add($x).format('DD.MM.YYYY HH:mm:ss');	    )


// Set [ msg.payload ] to the value:
// J: expression  (jsonata expression)
(	    $b := $moment(timeB,['DD.MM.YYYY HH:mm:ss','x'],'de');	    $a := $moment(timeA,['DD.MM.YYYY HH:mm:ss','x'],'de');	    	    /* $b.diff($a) */	    /* $moment.duration($b.diff($a)); */	    	        /* Kein Zugriff auf duration  - also manuell berechnen*/	        	    $days := $b.diff($a, 'days');	    $hours := $b.diff($a, 'hours') - 24 * $b.diff($a, 'days');	    $minutes := $b.diff($a, 'minutes') - 60 * $b.diff($a, 'hours');	    $seconds := $b.diff($a, 'seconds') - 60 * $b.diff($a, 'minutes');	    	    $sec := $b.diff($a)/1000;	    		    	    $difference := {	        'days': $days,	        'hours':$hours,	        'minutes': $minutes,	        'seconds': $seconds	    }; 	    		)



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
//   $difference := { 'days': $days, 'hours':$hours, 'minutes': $minutes, 'seconds': $seconds };
// )



// $moment(msg.payload).subtract(1,'w').format('x')

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
//   $difference := { 'days': $days, 'hours':$hours, 'minutes': $minutes, 'seconds': $seconds };
// )


// ------------------------------------------------------------
//
// Citation(s)
//
//   momentjs.com  |  "Moment.js | Docs"  |  https://momentjs.com/docs/#/displaying/format/
//
// ------------------------------------------------------------