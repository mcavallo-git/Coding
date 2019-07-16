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
// Variable (String):
timestamp_value

// Expression:
formatDateTime({$now}, ‘MM/dd @ hh:mm:ss a’)

// ------------------------------------------------------------
// Variable (boolean):
its_daytime

// Expression:
isBetween(time($now), addMinutes(time($sunrise), 15), addMinutes(time($sunset), -15))

// ------------------------------------------------------------
// Send SMS message w/ device (or piston, etc.) status

"{timestamp_value}
{$name}

🔋 Battery={battery_value}
📡 Status={status_value}

✔️ Error=NONE"

// ------------------------------------------------------------
// Last ran on ... -->  Set Piston State's Value to:
[b | 💻 Last ran on {timestamp_value}]

// ------------------------------------------------------------
// OFF since ... -->  Set Piston State's Value to:
[b | ◆ OFF since {timestamp_value}]

// ------------------------------------------------------------
// ON since ... -->  Set Piston State's Value to:
[b | 💡 ON since {timestamp_value}]

// ------------------------------------------------------------
// SHM - Armed/Away 
//
// Value:
[b | 🛡️ {$shmStatus} as-of {timestamp_value}]

// Expression:
"{timestamp_value}
{$name}

🛡️ Status='Armed/Away'
⚙️ Action=ALL_INTERIOR_LIGHTS_OFF"

// ------------------------------------------------------------
// SHM - Armed/Stay
//
// Value:
[b | 🏡 {$shmStatus} as-of {timestamp_value}]

// Expression:
"{timestamp_value}
{$name}

🏡 Status='Armed/Stay'
⚙️ Action=LIVING_ROOM_LIGHTS_ON"

// ------------------------------------------------------------
// SHM - Disarmed
//
// Value:
[b | 🛑 {$shmStatus} as-of {timestamp_value}]

// ------------------------------------------------------------
// Location Mode - Home  -->  Set Piston State's Value to:
[b | 🏡 {$locationMode} since {timestamp_value}]

// Location Mode - Night  -->  Set Piston State's Value to:
[b | 🌑 {$locationMode} since {timestamp_value}]

// Location Mode - Away  -->  Set Piston State's Value to:
[b | 🛡️ {$locationMode} since {timestamp_value}]

// ------------------------------------------------------------
// Disarmed Check
// Value - Disarmed:
[b | ❌ {$shmStatus} as-of {timestamp_value}]

// Value - Not Disarmed:
[b | ✔️ {$shmStatus} as-of {timestamp_value}]

// ------------------------------------------------------------