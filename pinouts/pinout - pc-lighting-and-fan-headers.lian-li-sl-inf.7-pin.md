## Lian Li UNI Fan SL-INF (7-Pin Header)

* I created a [pinout diagram for my own future reference](https://raw.githubusercontent.com/mcavallo-git/Coding/main/pinouts/pinout%20-%20pc-lighting-and-fan-headers.lian-li-sl-inf.7-pin.jpg) \- feel free to use it as needed (see notes at bottom for more info)
   * Since I want this info to be accessible down the road, and to avoid the dependency on an external image hyperlink, I just created an ascii art diagram
      * The diagram below depicts the UNI Fan SL-INF 7-pin male plug with the clip facing "up" towards the perspective of the viewer

&#x200B;

## Pinout Diagram

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
           |     |     |  |  |     |     |           
           |     |     |  |  |     |     |           
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

1. ARGB | +5V
2. ARGB | DATA
3. ARGB | GROUND
4. PWM | GROUND
5. PWM | +12V
6. PWM | TACH*
7. PWM | CONTROL/PWM

  - \*Note that the TACH wire is missing on one of the two outputs of the 7-pin Y-splitter (included with the 3-pack of SL-INF fans). This is standard in any 4-pin PWM fan splitters, as it can only feed one fan's RPM sensor data back to the motherboard / 4-pin source.

&#x200B;

## Splicing [ 7-pin SL-INF ] into [ 3-pin ARGB ] + [ 4-pin PWM ]

* Use any additional 7-pin Uni Fan SL-INF cables you have (if you purchased a 3-pack), or puchase additional Lian Li 7-pin cables via model `SLV2-1`.
  - Cut the cable with plenty of excess on both sides (for later use, if so desired).
  - Using above pinout diagram:
    - Splice wires `1`, `2`, and `3` to a female `ARGB` (3-pin) cable
      - Use an `ARGB` to `ARGB` 3-pin male to male adapter if you need it to be male instead of female, for versatility's sake)
    - Splice wires `4`, `5`, `6` and `7` to a female `PWM` (4-pin) cable

&#x200B;

### Connector Housing

* I suspect that the following connector housings are used for Lian Li's UNI Fan SL-INF series of fans:
   * `Molex 50-57-9407` (male)
   * `Molex 70107-0006` (female)

&#x200B;

## Testing

* I manually tested & verified two custom spliced 7-pin cables for the Lian Li SL-INF (infinity) fans using a voltmeter on each of the pins against a control case of a UNI SL-INF controller plugged in as-intended to a PC (with both SATA & USB).
   * First iteration of a custom spliced 7-pin cable works great with PWM/ARGB directly from the motherboard, straight into the fans' 7-pin connector. No RGB puke on cold boots, anymore (which is why I took on this endeavor in the first place).
   * Second iteration of a custom spliced 7-pin cable uses only 6 wires (no TACH wire, and sits infront of a PWM splitter which doesn't use the TACH wire) and also works exactly as intended.

* Before beginning this endeavor, I contacted Lian Li's customer support regarding the cold boot RGB puke issue (RGB doesn't work as intended until you boot Windows > logon > run L-Connect3, and runs rainbow patterns over the fans until that point) and also requested a pinout of the 7-pin headers (which I didn't honestly expect them to provide).
   * They didn't offer a solution other than to not let the controller lose power on the USB input (which doesn't help my exact use case), otherwise it'll reset the device (to rainbow puke), or in their words, `discontinued power supply after cold boot that will back to default setting`.
   * They also politely declined to provide a pinout for the 7-pin connector, which is very understandable why they wouldn't give that info out (to avoid potentially accepting liability of users making custom cables, namely).

&#x200B;

Hope this helps others going into this endavor less blind than myself!

<!-- https://github.com/mcavallo-git/Coding/blob/main/pinouts/pinout%20-%20pc-lighting-and-fan-headers.lian-li-sl-inf.7-pin.md -->

<!-- https://www.reddit.com/r/lianli/comments/vg180s/sl_infinity_cables/ -->
<!-- https://www.reddit.com/r/lianli/comments/vspuvp/hi_im_trying_to_install_the_uni_fan_sl_inf_120/ -->
<!-- https://www.reddit.com/r/lianli/comments/y422u1/pinout_unifan_infinity/ -->
