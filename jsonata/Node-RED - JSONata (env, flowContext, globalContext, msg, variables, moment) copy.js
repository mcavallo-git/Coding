// ------------------------------------------------------------
// Node-RED - JSONata (env, flowContext, globalContext, msg, variables, moment)
// ------------------------------------------------------------
//
//   ⚠️ JSONata Sandbox @ https://try.jsonata.org/  ⚠️
//
// ------------------------------------------------------------
//
//   Note: This script is really just a big scratch pad used while practicing JSONata in Node-RED
//
// ------------------------------------------------------------


// JSONata Expression - Message Variables
(payload)


// JSONata Expression - Message Payload
$$.payload


// JSONata Expression - Environment Variables
($env('timeout_minutes');)
//   equivalent to
"${timeout_minutes}"
//   equivalent to
"{{timeout_minutes}}"


// JSONata Expression - Flow Variables
($flowContext('timeout_minutes');)


// JSONata Expression - Global Variables
($globalContext('inactivity_lights_off_after_minutes');)


// ------------------------------

//
// moment (or moment.now)  -  Get current Datetime (equivalent to "new Date();" or "Date.now();")
//
($moment();)


//
// moment.add
//
($moment().add(30,'minutes');)


//
// moment.diff  -  Subtract from initial moment's datetime (e.g. "Get the difference between the two dates")
//
(($moment().add(30,'minutes')).diff($moment(),'seconds');)


//
// moment.format
//
($moment().format('YYYY-MM-DD HH:mm:ss');)


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
//
// J: expression  (jsonata expression)
//

//
// Example (jsonata): Output a concatenated string
//
"Z-WaveJS: " & msg.error_count & " of " & msg.node_count & " nodes are unavailable as of " & $moment().format('YYYY-MM-DDTHH:mm:ss') & " (restart threshold is " & $flowContext('error_threshold') & " or more unavailable nodes)"


// ------------------------------------------------------------
//
// J: expression  (jsonata expression)
//

//
// Example (jsonata): Output a JSON object (including concatenated strings & moment datetime/timestamp)
//
{
  "message": $moment().format('YYYY-MM-DDTHH:mm:ss') & " - Action: Restart Server", 
  "title": "Z-Wave JS detected as down"
}


// ------------------------------------------------------------
//
// J: expression  (jsonata expression)
//

//
// Example (jsonata): More in-depth/advanced usage of 'moment' (Moment.js)
//
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
//
//
// $moment(msg.payload).subtract(1,'w').format('x')
//
// $days := $moment().diff((flow.get('timestamp_last_active')),'seconds');
//
//
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
//
//
// ------------------------------------------------------------
//
// Citation(s)
//
//   docs.jsonata.org  |  "Comparison Operators · JSONata"  |  https://docs.jsonata.org/comparison-operators
//
//   momentjs.com  |  "Moment.js | Docs"  |  https://momentjs.com/docs/#/displaying/format/
//
//   nodered.org  |  "Context Store API : Node-RED"  |  https://nodered.org/docs/api/context/methods
//
//   nodered.org  |  "Node context : Node-RED"  |  https://nodered.org/docs/creating-nodes/context
//
//   nodered.org  |  "Working with context : Node-RED"  |  https://nodered.org/docs/user-guide/context
//
//   nodered.org  |  "Writing Functions : Node-RED"  |  https://nodered.org/docs/user-guide/writing-functions#multiple-context-stores
//
//   try.jsonata.org  |  "JSONata Exerciser (Sandbox)"  |  https://try.jsonata.org/
//
// ------------------------------------------------------------