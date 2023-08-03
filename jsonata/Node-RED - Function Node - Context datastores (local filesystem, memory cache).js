// ------------------------------------------------------------
// Node-RED - Function Node - Context datastores (local filesystem, memory cache)
// ------------------------------------------------------------
//
// Press [ CTRL + SHIFT + P ] in Node-RED & type "show system info" (ALL LOWERCASE)
//  |
//  |--> Select option "Show System Info" from the dropdown items, which will show a JSON response containing most of the ingested settings from "settings.js" (applied at Node-RED spinup time)
//
// ------------------------------------------------------------
//
// Get info regarding Node-RED's context stores
//

msg.variable_names = [];
for (var each_varname in this) {
  msg.variable_names.push(each_varname);
}

// RED.settings.get('userDir') returns undefined · Issue #1543 · node-red/node-red · GitHub

msg.context = context;
msg.env = env;
msg.global = global;
msg.flow = flow;
msg.node = node;
msg.parse_default = RED.util.parseContextStore("default");
msg.parse_file = RED.util.parseContextStore("file");
msg.parse_flow = RED.util.parseContextStore("flow");
msg.parse_global = RED.util.parseContextStore("global");
msg.this = this;

msg.keys = {};
msg.keys.node = context.keys();
msg.keys.flow = flow.keys();
msg.keys.global = global.keys();
msg.keys.global_default = global.keys("default");
msg.keys.global_file = global.keys("file");

// ------------------------------

msg.RED = RED;

// User settings are those provided by the settings file and are read-only.
// RED.settings.userDir;

// Runtime settings are ones that can change while node-red is running and need to be persisted.
// RED.settings.get()
// RED.settings.set()

// ------------------------------

return msg;


// ------------------------------------------------------------
//
// Citation(s)
//
//   github.com  |  "RED.settings.get('userDir') returns undefined · Issue #1543 · node-red/node-red · GitHub"  |  https://github.com/node-red/node-red/issues/1543
//
//   nodered.org  |  "Context Store API : Node-RED"  |  https://nodered.org/docs/api/context/methods
//
//   nodered.org  |  "Node context : Node-RED"  |  https://nodered.org/docs/creating-nodes/context
//
//   nodered.org  |  "Working with context : Node-RED"  |  https://nodered.org/docs/user-guide/context
//
//   nodered.org  |  "Writing Functions : Node-RED"  |  https://nodered.org/docs/user-guide/writing-functions#multiple-context-stores
//
// ------------------------------------------------------------