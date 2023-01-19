## Pinout - Lian Li UNI Fan SL-Infinity (SL-INF) 7-Pin Connector/Header

* This document exists for myself and others' future reference on how to directly connect Lian Li's SL-INF (infinity mirror) fans to separate, user selected `ARGB` & `PWM` sources. This is done to avoid requiring the use of Lian Li's proprietary SL-INF controller, which resets every time the PC is restarted, and only works as-configured again once the connected PC is booted up, logged in, and has the Lian Li L-Connect software running (for more on this, see section `Testing & Verification` at the bottom of this document)

## Pinout Diagram

* The following diagram depicts a Lian Li UNI Fan SL-INF 7-pin male connector
  * The view is looking "down" on the male connector, which has its clip facing "up" towards the perspective of the viewer

                1     2     3     4     5     6     7        
                                                             
             -------------------------------------------     
             | 5V  |  D  |  G  |  G  | 12V |  T  |  C  |     
             -------------------------------------------     
             |     |     |       |-|       |     |     |     
             |     |     |     --|-|--     |     |     |     
             |     |     |     | | | |     |     |     |     
             |     |     |     | | | |     |     |     |     
             |     |     |     |-| |-|     |     |     |     
             |     |     |       |||       |     |     |     
             |     |     |-----------------|     |     |     
             |     |     |     |     |     |     |     |     
             |     |     |     |     |     |     |     |     
             |     |     |     |     |     |     |     |     
             |     |     |     |     |     |     |     |     
             -------------------------------------------     
               |     |     |     |     |     |     |         
               |     |     |     |     |     |     |         
                   |     |    |  |  |     |     |            
                   |     |    |  |  |     |     |            
                       |    |   |||   |    |                 
                       |    |   |||   |    |                 
                           |   |||||   |                     
                           |   |||||   |                     
                              |||||||                        
                              |||||||                        
                              |||||||                        
                              |||||||                        
                              |||||||                        
                              |||||||                        

  * In order from left to right, the pinout is:
    * `1` --> `ARGB` | `+5V`
    * `2` --> `ARGB` | `DATA`
    * `3` --> `ARGB` | `GROUND`
    * `4` --> `PWM` | `GROUND`
    * `5` --> `PWM` | `+12V`
    * `6` --> `PWM` | `TACH`*
    * `7` --> `PWM` | `CONTROL`/`PWM`

  * \* Note: A visual landmark on the SL-INF 7-pin Y-splitter cables is the `TACH` wire, as it is missing on one of the two Y-splitter female outputs *(since only one fan's `TACH` (RPM sensor) data may be handed back to the upstream 4-pin PWM source, such as a motherboard).*

  * \* Note: The ascii art pinout diagram exists to avoid depending on the image URL for my [visual pinout diagram](https://raw.githubusercontent.com/mcavallo-git/Coding/main/pinouts/pinout%20-%20pc-lighting-and-fan-headers.lian-li-sl-inf.7-pin.jpg) going missing, getting renamed, etc. (and ending up as a dead link)

## Splicing Instructions

* The 3-pack version of the SL-INF UNI Fans comes with a 7-pin Y-splitter cable (1\*male to 2\*female)
  * Using the numerical identifiers on the pinout diagram (above):
    * Splice wires `1`, `2`, and `3` to a female `ARGB` (3-pin) cable
      * Note: A female ARGB termination can act as a male termination via an `ARGB` 3-pin male to male adapter
    * Splice wires `4`, `5`, `6` and `7` to a female `PWM` (4-pin) cable
* If you cut an existing 7-pin cable, make sure to leave plenty of excess on either side of the cut (for later use, if so desired)
* If no additional 7-pin cables are at-hand, the following crimp housings may be used to make new cables:
  * [`Molex 50-57-9407` *(7-pin SL-INF male connector)*](https://www.molex.com/molex/products/part-detail/crimp_housings/0050579407)
  * [`Molex 70107-0006` *(7-pin SL-INF female connector)*](https://www.molex.com/molex/products/part-detail/crimp_housings/0701070006)

## Testing & Verification

* I manually tested & verified two custom spliced 7-pin cables for the Lian Li SL-INF (infinity) fans using a voltmeter on each of the pins against a control case of a UNI SL-INF controller plugged in as-intended to a PC (with both SATA & USB).
   * First iteration of a custom spliced 7-pin cable works great with PWM/ARGB directly from the motherboard, straight into the fans' 7-pin connector. No RGB puke on cold boots, anymore (which is why I took on this endeavor in the first place).
   * Second iteration of a custom spliced 7-pin cable uses only 6 wires (no TACH wire, and sits infront of a PWM splitter which doesn't use the TACH wire) and also works exactly as intended.

* Before beginning this endeavor, I contacted Lian Li's customer support regarding the cold boot RGB puke issue (RGB doesn't work as intended until you boot Windows > logon > run L-Connect3, and runs rainbow patterns over the fans until that point) and also requested a pinout of the 7-pin headers (which I didn't honestly expect them to provide).
   * They didn't offer a solution other than to not let the controller lose power on the USB input (which doesn't help my exact use case), otherwise it'll reset the device (to rainbow puke), or in their words, `discontinued power supply after cold boot that will back to default setting`.
   * They also politely declined to provide a pinout for the 7-pin connector, which is very understandable why they wouldn't give that info out (to avoid potentially accepting liability of users making custom cables, namely).

<!-- https://github.com/mcavallo-git/Coding/blob/main/pinouts/pinout%20-%20pc-lighting-and-fan-headers.lian-li-sl-inf.7-pin.md -->

<!-- https://www.reddit.com/r/lianli/comments/vg180s/sl_infinity_cables/ -->
<!-- https://www.reddit.com/r/lianli/comments/vspuvp/hi_im_trying_to_install_the_uni_fan_sl_inf_120/ -->
<!-- https://www.reddit.com/r/lianli/comments/y422u1/pinout_unifan_infinity/ -->