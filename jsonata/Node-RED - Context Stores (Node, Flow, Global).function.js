// ------------------------------------------------------------
//
// Get info regarding Node-RED's context stores
//

msg.contexts = {};
msg.contexts.context = context;
msg.contexts.node = node;
msg.contexts.flow = flow;
msg.contexts.global = global;

// msg.homeassistant = homeassistant.homeAssistant.isConnected   // https://community.home-assistant.io/t/how-do-i-watch-for-ha-start-shutdown-events-in-node-red/96421/6

msg.RED = RED;

msg.keys = {};
msg.keys.node = context.keys();
msg.keys.flow = flow.keys();
msg.keys.global = global.keys();
msg.keys.global_file = global.keys("file");
msg.keys.global_memoryOnly = global.keys("memoryOnly");


return msg;


// ------------------------------------------------------------
//
// Citation(s)
//
//   nodered.org  |  "Context Store API : Node-RED"  |  https://nodered.org/docs/api/context/methods
//
//   nodered.org  |  "Node context : Node-RED"  |  https://nodered.org/docs/creating-nodes/context
//
//   nodered.org  |  "Working with context : Node-RED"  |  https://nodered.org/docs/user-guide/context
//
// ------------------------------------------------------------