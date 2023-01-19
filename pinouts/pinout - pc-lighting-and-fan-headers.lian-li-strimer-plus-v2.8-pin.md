## Pinout - Lian Li Strimer Plus V2 (PV2) 8-Pin Connector/Header

* This document exists for myself and others' future reference on how to directly connect Lian Li's Strimer Plus V2 PSU extensions to a user selected `ARGB` source. This is done to avoid requiring the use of Lian Li's proprietary Strimer Plus V2 controller.

## Pinout Diagram

* The following diagram depicts a Lian Li Strimer Plus V2 8-pin male connector
  * The view is looking "down" on the male connector, which has its two tabs facing "up" towards the perspective of the viewer

                1     2     3     4     5     6     7     8        
                                                                   
             -------------------------------------------------     
             |  ?  |  ?  |  ?  |  ?  |  ?  |  ?  |  ?  |  ?  |     
             -------------------------------------------------     
             |       |                               |       |     
             |       |                               |       |     
             |       |                               |       |     
             |       |                               |       |     
             |       |-------------------------------|       |     
             |                                               |     
             -------------------------------------------------     
               |     |     |     |     |     |     |     |         
               |     |     |     |     |     |     |     |         
                |     |     |     |   |     |     |     |          
                    |    |    |    | |    |    |    |              
                       |    |   |  | |  |   |    |                 
                          |  |  |  | |  |  |  |                    
                          |  |  |  | |  |  |  |                    
                          |  |  |  | |  |  |  |                    
                          |  |  |  | |  |  |  |                    
                          |  |  |  | |  |  |  |                    
                          |  |  |  | |  |  |  |                    

  * In order from left to right, the pinout is:
    * `1` --> `_____` | `_____`
    * `2` --> `_____` | `_____`
    * `3` --> `_____` | `_____`
    * `4` --> `_____` | `_____`
    * `5` --> `_____` | `_____`
    * `6` --> `_____` | `_____`
    * `7` --> `_____` | `_____`
    * `8` --> `_____` | `_____` (\* white wire)

  * \* Note: A visual landmark on the Strimer Plus V2 cables is the white `_____` wire (#8)

## Splicing Instructions

* If no additional 8-pin cables are at-hand, the following crimp housings may be used to make new cables:
  * [`Molex 50-57-9408` *(8-pin PV2 male connector)*](https://www.molex.com/molex/products/part-detail/crimp_housings/0050579408)
  * [`Molex 70107-0007` *(8-pin PV2 female connector)*](https://www.molex.com/molex/products/part-detail/crimp_housings/0701070007

<!--
Controls:
- ~4.82 V on +5V ARGB wire
- ~0.285 V on Data ARGB wire
- ~0.000 V (assumed) on Ground ARGB wire
-->

<!-- https://github.com/mcavallo-git/Coding/blob/main/pinouts/pinout%20-%20pc-lighting-and-fan-headers.lian-li-strimer-plus-v2.8-pin.md -->
