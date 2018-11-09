
let timeout_var = null;
let default_ms = 3000;
function KeepaliveTimeout() {
	let wait_ms;
	if (arguments.length===0) {
		wait_ms = default_ms;
	} else {
		// Optional: argument#1 - wait_ms
		wait_ms = parseInt(arguments[0]);
	}
	if (timeout_var !== null) {
		clearTimeout(timeout_var);
		timeout_var = null;
	}
	setTimeout(
		function() {
			// Place Autosave API Call Here
		},
		wait_ms
	);
}
