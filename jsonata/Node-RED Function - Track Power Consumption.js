// ------------------------------------------------------------
//
// var var_name=context.get('var_name') || 0; // Function-Scoped Variable (Get)
// var var_name=flow.get('var_name') || 0;    // Flow-Scoped Variable (Get)
// var var_name=global.get('var_name') || 0;  // Global-Scoped Variable (Get)
//
// context.set('var_name',var_name); // Function-Scoped Variable (Set)
// flow.set('var_name',var_name);    // Flow-Scoped Variable (Set)
// global.set('var_name',var_name);  // Global-Scoped Variable (Set)
//
// ------------------------------------------------------------

var payload = parseFloat(msg.payload);

// ------------------------------------------------------------
//
// Max
//

if (context.get('payload_max') === undefined) {
	context.set('payload_max',payload);
} else {
	context.set('payload_max',Math.max(parseFloat(context.get('payload_max')), payload));
}


// ------------------------------------------------------------
//
// Min
//

if (context.get('payload_min') === undefined) {
	context.set('payload_min',payload);
} else {
	context.set('payload_min',Math.min(parseFloat(context.get('payload_min')), payload));
}

// ------------------------------------------------------------
//
// Avg
//

if ((context.get('payload_avg') === undefined) || (context.get('payload_avg_count') === undefined)) {
	context.set('payload_avg',payload);
	context.set('payload_avg_count',1);
} else {
	context.set('payload_avg',(((parseFloat(context.get('payload_avg'))*parseFloat(context.get('payload_avg_count')))+payload)/(parseFloat(context.get('payload_avg_count'))+1)));
	context.set('payload_avg_count',(parseFloat(context.get('payload_avg_count'))+1));
}

// ------------------------------------------------------------

msg.debug={
	payload:(payload.toFixed(1) + " " + msg.data.new_state.attributes.unit_of_measurement),
	payload_max:(context.get('payload_max').toFixed(1) + " " + msg.data.new_state.attributes.unit_of_measurement),
	payload_min:(context.get('payload_min').toFixed(1) + " " + msg.data.new_state.attributes.unit_of_measurement),
	payload_avg:(context.get('payload_avg').toFixed(4) + " " + msg.data.new_state.attributes.unit_of_measurement),
	payload_avg_count:context.get('payload_avg_count').toFixed(0)
};

return msg;

// ------------------------------------------------------------