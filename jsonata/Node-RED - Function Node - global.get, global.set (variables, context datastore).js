// ------------------------------------------------------------
// Node-RED - Function Node - global.get, global.set (variables, context datastore)
// ------------------------------------------------------------
//
// var var_name=env.get('var_name') || 0;  // Environment-Scoped Variable (Get)
// var var_name=flow.get('var_name', 'storeName') || 0;  // Flow-Scoped Variable (Get)
// var var_name=global.get('var_name', 'storeName') || 0;  // Global-Scoped Variable (Get)
// var var_name=context.get('var_name', 'storeName') || 0;  // Node-Scoped Variable (Get)
//
// flow.set('var_name', value, 'storeName');  // Flow-Scoped Variable (Set)
// global.set('var_name', value, 'storeName');  // Global-Scoped Variable (Set)
// context.set('var_name', value, 'storeName');  // Node-Scoped Variable (Set)
//
//   ⚠️ Note: 'storeName' is an optional argument (specifies context store to use)
//
// ------------------------------------------------------------


// [Function Node] - Set global variable w/ default context datastore

msg.payload = $moment().format('YYYY-MM-DDTHH:mm:ss');
global.set('global_varname', msg.payload);  // return msg;


// ------------------------------------------------------------


// [Function Node] - Set global variable w/ targeted context datastore

msg.payload = $moment().format('YYYY-MM-DDTHH:mm:ss');
global.set('global_varname', msg.payload, 'file');  // return msg;


// ------------------------------------------------------------


// [Function Node] - Set global variable w/ targeted context datastore, with both values obtained by a reverse lookup from environment variable values (intended to be used by a generalized/templated Node-RED subflow, where the arguments are passed in as env vars)

msg.payload = $moment().format('YYYY-MM-DDTHH:mm:ss');

global.set(env.get('global_var_last_activity'), msg.payload, env.get('global_var_context_datastore'));  // return msg;


// ------------------------------------------------------------
//
// Citation(s)
//
//   nodered.org  |  "Writing Functions : Node-RED"  |  https://nodered.org/docs/user-guide/writing-functions#multiple-context-stores
//
// ------------------------------------------------------------