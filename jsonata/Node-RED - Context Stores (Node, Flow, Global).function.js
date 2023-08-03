// ------------------------------------------------------------
//
// Get info regarding Node-RED's context stores
//

msg.contexts = {};
msg.contexts.node = context;
msg.contexts.flow = flow;
msg.contexts.global = global;

msg.keys = {};
msg.keys.node = context.keys();
msg.keys.flow = flow.keys();
msg.keys.global = global.keys();

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