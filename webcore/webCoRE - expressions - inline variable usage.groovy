// ------------------------------------------------------------
// Related Emojis
//
// 🔓 unlocked     🔒 locked     🔐 locked w/ key
//
// 🏠 house     🏡 house w/ garden     🛡️ Shield
//
// ✔️ heavy check     ❌ cross mark
//
// 💻 laptop computer     ⚙️ gear
//
// 🌑 new moon     ☀️ sun
//
// ------------------------------------------------------------
// Variable Name:
timestamp_value

// EXPRESSION:
formatDateTime({$now}, ‘MM/dd @ hh:mm:ss a’)

// ------------------------------------------------------------
// Send SMS message regarding device/piston status

"{timestamp_value}
{$name}

🔋 Battery={battery_value}
📡 Status={status_value}

✔️ Error=NONE"



// ------------------------------------------------------------
// Set Piston State to [ Last ran on ... ]

// VALUE:
[b | 💻 Last ran on {timestamp_value}]


// ------------------------------------------------------------
// Set Piston State to [ OFF since ]

// VALUE:
[b | ◆ OFF since {timestamp_value}]

// EXPRESSION:
concat(
	"[b | ◆ OFF since ",
	formatDateTime({$now}, ‘MM/dd @ hh:mm:ss a’),
	"]"
)



// ------------------------------------------------------------

// VALUE:
[b | 💡 ON since {timestamp_value}]

// EXPRESSION:
concat(
	"[b | 💡 ON since ",
	formatDateTime({$now}, ‘MM/dd @ hh:mm:ss a’),
	"]"
)



// ------------------------------------------------------------
// SHM - Armed/Away
//
// VALUE:
[b | 🛡️ {$shmStatus} as-of {timestamp_value}]

// EXPRESSION:
"{timestamp_value}
{$name}

🛡️ Status='Armed/Away'
⚙️ Action=ALL_INTERIOR_LIGHTS_OFF"

// ------------------------------------------------------------
// SHM - Armed/Stay
//
// VALUE:
[b | 🏡 {$shmStatus} as-of {timestamp_value}]

// EXPRESSION:
"{timestamp_value}
{$name}

🏡 Status='Armed/Stay'
⚙️ Action=LIVING_ROOM_LIGHTS_ON"

// ------------------------------------------------------------
// SHM - Disarmed
//
// VALUE:
[b | 🛑 {$shmStatus} as-of {timestamp_value}]

// ------------------------------------------------------------
// Location Mode - Home  -->  Set Piston State's Value to:
[b | 🏡 {$locationMode} since {timestamp_value}]

// Location Mode - Night  -->  Set Piston State's Value to:
[b | 🌑 {$locationMode} since {timestamp_value}]

// Location Mode - Away  -->  Set Piston State's Value to:
[b | 🛡️ {$locationMode} since {timestamp_value}]

// ------------------------------------------------------------