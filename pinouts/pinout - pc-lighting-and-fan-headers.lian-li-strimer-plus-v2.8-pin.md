## Pinout - Lian Li Strimer Plus V2 (PV2) 8-Pin Connector/Header

* This document exists for myself and others' future reference on how to directly connect Lian Li's Strimer Plus V2 PSU extensions to a user selected `ARGB` source. This is done to avoid requiring the use of Lian Li's proprietary Strimer Plus V2 controller.

## Pinout Diagram

* The following diagram depicts a Lian Li Strimer Plus V2 8-pin male connector
  * The view is looking "down" on the male connector, which has its two tabs facing "up" towards the perspective of the viewer

           1     2     3     4     5     6     7     8   
                                                         
        -------------------------------------------------
        |  G  |  D  |  D  |  D  |  D  |  D  |  D  | 5V  |
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
             |     |     |    |   |    |     |     |     
               |     |    |   |   |   |    |     |       
                 |    |   |   |   |   |   |    |         
                  |   |   |   |   |   |   |   |          
                  |   |   |   |   |   |   |   |          
                  |   |   |   |   |   |   |   |          
                  |   |   |   |   |   |   |   |          
                  |   |   |   |   |   |   |   |          
                  |   |   |   |   |   |   |   |          
                  |   |   |   |   |   |   |   |          

  * In order from left to right, the pinout is:
    * `1` --> `ARGB` | `GROUND`
    * `2` --> `ARGB` | `DATA`
    * `3` --> `ARGB` | `DATA`
    * `4` --> `ARGB` | `DATA`
    * `5` --> `ARGB` | `DATA`
    * `6` --> `ARGB` | `DATA`
    * `7` --> `ARGB` | `DATA`
    * `8` --> `ARGB` | `+5V`* (white wire)

  * \* Note: A visual landmark on the Strimer Plus V2 cables is the white `+5V` wire (#8)

## Splicing Instructions

* If no additional 8-pin cables are at-hand, the following crimp housings may be used to make new cables:
  * [`Molex 50-57-9408` *(8-pin PV2 male connector)*](https://www.molex.com/molex/products/part-detail/crimp_housings/0050579408)
  * [`Molex 70107-0007` *(8-pin PV2 female connector)*](https://www.molex.com/molex/products/part-detail/crimp_housings/0701070007)

## Testing & Verification

* Pinout determined by manually checking the voltages (via multimeter) running across each lane of a Lian Li Strimer Plus V2 8-pin connector (while hot) & comparing its voltages against a control case of a standard ARGB connection's voltages

<!-- https://github.com/mcavallo-git/Coding/blob/main/pinouts/pinout%20-%20pc-lighting-and-fan-headers.lian-li-strimer-plus-v2.8-pin.md -->
