# Pinout - Lian Li UNI Fan SL-INF (7-Pin Header)

&#x200B;

- I created a [pinout diagram for my own future reference](https://raw.githubusercontent.com/mcavallo-git/Coding/main/pinouts/pinout%20-%20pc-lighting-and-fan-headers.lian-li-sl-inf.7-pin.jpg) \- feel free to use it as needed (see notes at bottom for more info)
   - Since I want this info to be accessible down the road, and to avoid the dependency on an external image hyperlink, I just created an ascii art diagram:
      - The diagram below depicts the UNI Fan SL-INF 7-pin male plug with the clip facing "up" towards the perspective of the viewer:

&#x200B;

```
                                    
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
```

In order from left to right, the pinout is:
1. ARGB | +5V 
2. ARGB | DATA 
3. ARGB | GROUND
4. PWM | GROUND
5. PWM | +12V
6. PWM | TACH
7. PWM | CONTROL/PWM

&#x200B;

- I just finished manually testing/verifying a custom 7-pin cable for the Lian Li infinity fans using a voltmeter and more time than it should've taken.

  - The cable works great with PWM/ARGB in directly from the motherboard, straight into the fans 7-pin connector. No RGB puke on cold boots, anymore (which is why I took on this endeavor in the first place).

  - I also contacted Lian Li's customer support regarding this issue, and they didn't offer a solution other than to not let the controller lose 12V power (which doesn't help my exact use case). They also politely declined to provide a pinout for the 7-pin connector, which is fine and I understand why they wouldn't give that info out (to avoid liability of users making custom cables, namely).

&#x200B;