<!-- ------------------------------------------------------------ -->

# Android Quality of Life Improvements

<!-- ------------------------------------------------------------ -->

### Stop the high volume warning popup


##### Issue description:

Message:  "Listening at a high volume for a long time may damage your hearing. Tap OK to allow the volume to be increased above safe levels."

Prompts:  "Cancel"  /  "OK"

When:     Attempting to turn volume higher than ~60% max volume


##### To Resolve:

open  "Settings"  (samsung native app)

 >  select  "Sounds and vibration"  (~3rd option from top)

  >  select  "Volume"  (~5th option from top)

   >  select  "..."  (top right)

    >  select  "Media volume limit"  (only option)

     >  set to "ON" (press top right slider)

      >  slide "Custom volume limit" all the way to the right, e.g. to 100%

 > enable android "Developer options" ("settings" > "about phone" > tap "build number" seven times in a row)

  > enable the developer option "Disable absolute volume"


<!-- ------------------------------------------------------------ -->
