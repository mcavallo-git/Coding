## Pinout - Lian Li UNI Fan SL-INF (7-Pin Header)

- Just finished manually testing/verifying a custom 7-pin cable for the Lian Li infinity fans using a voltmeter and more time than it should've taken.
  - The cable works great with PWM/ARGB in directly from the motherboard, straight into the fans 7-pin connector. No RGB puke on cold boots, anymore (which is why I took on this endeavor in the first place).

- The following ascii art depicts the 7-pin male plug, with the clip facing "up" towards the perspective of the viewer:
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
