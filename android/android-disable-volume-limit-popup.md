<hr /> <!-- ------------------------------------------------------------ -->

# Android Quality of Life Improvements
##### Stop the high volume warning popup

<hr /> <!-- ------------------------------------------------------------ -->

### Description:

Popup Message:  "Listening at a high volume for a long time may damage your hearing. Tap OK to allow the volume to be increased above safe levels."

Response Options:  "Cancel"  /  "OK"

Occurs When:   Attempting to turn volume higher than 85 dB (~60% max volume on most phablets)

Occurs Because:  Noise levels of above 85 dB have been regarded as unsafe in global industries

The volume level of 85 dB(A) has been regarded as the critical intensity for volume levels in the workplace for decades before this ( https://ec.europa.eu/health/ph_risk/committees/04_scenihr/docs/scenihr_o_018.pdf ).

Due to a report by the Scientific Committee on Emerging and Newly Identified Health Risks (SCENIHR), a standardisation body in the EU called the European Committee for Electrotechnical Standardisation (CENELEC))


<hr /> <!-- ------------------------------------------------------------ -->

### Resolution:

##### Step 1/2 - Enable volume limit & set it to 100% (sound option)

open  "Settings"  (samsung native app)

 >  select  "Sounds and vibration"  (~3rd option from top)

  >  select  "Volume"  (~5th option from top)

   >  select  "..."  (top right)

    >  select  "Media volume limit"  (only option)

     >  set to "ON" (press top right slider)

      >  slide "Custom volume limit" all the way to the right, e.g. to 100%


##### Step 2/2 - Disable absolute volume (developer option)

 > enable android "Developer options" ("settings" > "about phone" > tap "build number" seven times in a row)

  > enable the developer option "Disable absolute volume"


<hr /> <!-- ------------------------------------------------------------ -->