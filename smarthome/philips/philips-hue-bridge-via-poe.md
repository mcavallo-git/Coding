<!-- ------------------------------------------------------------ -->
# Philips Hue Bridge - Powering via PoE (to allow for remote restarts via PoE Power Cycling)
<!-- ------------------------------------------------------------ -->

***
## Specifications (Philips Hue Hub v2 - Square model)

- Power (input):  `5V` 1A DC
  - Form Factor:  `5.5mm` x `2.5mm` `Barrel Connector` (female power port on back Philips Hue Bridge v2)

<!-- ------------------------------------------------------------ -->

***
## Generalized Solution
  - Use a PoE Splitter with the following specs:
    - Input:
      - Connector Type: `RJ45` (`Ethernet`)
      - Voltage: `48V` `IEEE 802.3af` PoE (`IEEE 802.3at` works as well, so long as your PoE injector supports it)
    - Output 1 of 2:
      - Connector Type: `RJ45` (`Ethernet`)
      - Voltage: `Negligible` (Data Only)
    - Output 2 of 2:
      - Connector Type: `5.5mm` x `2.5mm` `Barrel Connector` (male)
      - Voltage: `5V`
      - Amperage: `>= 1A` (or Power: `>= 5W`)
        - Note(s):
        > - ⚠️Important ⚠️ The typical output for a `5.5mm` x `2.5mm` `Barrel Connector` is `12V`, not `5V`. Make sure to not plug a `12V` power adapter into your Philips Hue Hub
        > - As long as the PoE splitter outputs at least `1A` at `5V`, it can still be used via an adapter which converts its power output to a `5.5mm` x `2.5mm` `Barrel Connector`
    - View Amazon listings which match: [`PoE Splitter 5V 5.5mm x 2.5mm`](https://www.amazon.com/s?k=PoE+Splitter+5V+5.5mm+x+2.5mm)

<!-- ------------------------------------------------------------ -->

***
- ### Example Solution #1 (2 items):
  1. PoE Splitter - View Amazon item: [`AuviPal 802.3af/at Compliant PoE Splitter (2 Pack), PoE to Micro USB 5V Power and 100Mbps Ethernet Adapter`](https://amazon.com/dp/B07TYBQB3B)
  2. Cable Adapter - View Amazon item: [`MMNNE 8inch DC 5.5mm x 2.5mm Male to Micro USB 5pin Female DC Power Supply Extension Adapter Cable 22AWG 3A`](https://amazon.com/dp/B07YFTZ4Z2)

<!-- ------------------------------------------------------------ -->

***
- ### Example Solution #2 (2 items):
  1. PoE Adapter - View Amazon item: [`UCTRONICS PoE Splitter USB-C 5V - Active PoE to USB-C Adapter, IEEE 802.3af Compliant`](https://amazon.com/dp/B087F4QCTR)
  2. Cable Adapter - View Amazon item: [`CERRXIAN 100W PD USB Type C Female Input to DC 5.5mm x 2.5mm Power Charging Adapter(5525a-Black)`](https://amazon.com/dp/B08V11C6T8)

<!-- ------------------------------------------------------------ -->

***
### Citation(s)

- [`Powering the Phillips Hue Bridge with PoE (Power over Ethernet) | daltonflanagan.com`](https://daltonflanagan.com/hue-over-poe/)

<!-- ------------------------------------------------------------ -->