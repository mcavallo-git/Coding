<!-- ------------------------------------------------------------ -->
# Philips Hue Play - Making a more reliable power connection than the stock barrel connector
<!-- ------------------------------------------------------------ -->

***
## Main Issue
- The barrel connectors that come with Philips Hue's "Play" line of devices disconnect easily when twisted in their port, even if touched gently.
- This includes (but is not limited to) the following device(s):
  - [`Philips Hue Play Gradient Lightstrip`](https://www.philips-hue.com/en-us/p/hue-white-and-color-ambiance-play-gradient-lightstrip-65-inch/046677560416) 
  - [`Philips Hue Play Light Bar`](https://www.philips-hue.com/en-us/p/hue-white-and-color-ambiance-play-light-bar-single-pack/7820131U7)
  - [`Philips Hue Play HDMI Sync Box`](https://www.philips-hue.com/en-us/p/hue-play-hdmi-sync-box-/046677555221)

- Note(s):
> - The `6.5mm` x `3.0mm` `barrel connector` is a rare type of termination, and finding cables/adapters to match it may be difficult
> - The Hue Play devices have a `male` barrel connector on the end of their cable (coming from the device)
>   - This is in opposition to traditional devices, which have a `male` barrel connector coming from the power supply, which plugs into a `female` port on the device
> - The Hue Play power supplies have either `1` or `3` `female` barrel connector ports

<!-- ------------------------------------------------------------ -->

***
## Specifications
- [`Philips Hue Play Light Bar`](https://www.philips-hue.com/en-us/p/hue-white-and-color-ambiance-play-light-bar-single-pack/7820131U7)
  - Input:
    - Connector Type: `6.5mm` x `3.0mm` `barrel connector` (`male`)
    - Voltage: `24V DC`
    - Amperage (Max): `0.275A` (each)
    - Power (Max): `6.6W` (each)
- [`Philips Hue Play HDMI Sync Box`](https://www.philips-hue.com/en-us/p/hue-play-hdmi-sync-box-/046677555221)
  - Input:
    - Connector Type: `6.5mm` x `3.0mm` `barrel connector` (`female` port on device)
    - Voltage: `24V DC`
    - Amperage (Max): `0.292A`
    - Power (Max): `7.0W`
- [`Philips Hue Play Gradient Lightstrip`](https://www.philips-hue.com/en-us/p/hue-white-and-color-ambiance-play-gradient-lightstrip-65-inch/046677560416) 
  - Input:
    - Connector Type: `6.5mm` x `3.0mm` `barrel connector` (`male`)
    - Voltage: `24V DC`
    - Amperage (Max): `0.833A`
    - Power (Max): `20.0W`
  - Dimensions:
    - Height: `0.63 inch`
    - Length: `85.2 inch` (55 inch version) / `100 inch` (65 inch version) / `119.7 inch` (75 inch version)
    - Width: `0.67 inch`
- Philips Hue Play Power Supply
  - Input:
    - Connector Type: `NEMA 1-15P` (two-pole, no ground pin) (`male`)
    - Voltage: `100-240V AC - 50/60Hz`
    - Amperage (Max): `0.6A` (`3`-/`1`-port)
    - Power (Max): `20.7W` (`3`-port), `24.0W` (`1`-port)
  - Output:
    - Connector Type: `6.5mm` x `3.0mm` `barrel connector` (`female`)
    - Voltage: `24V DC`
    - Amperage (Max): `0.875A` (`3`-port) / `0.83A` (`1`-port)
    - Power (Max): `21.0W` (`3`-port) / `20.0W` (`1`-port)

<!-- ------------------------------------------------------------ -->

***
## Generalized Solution #1 (no cutting cables 🚫✂️)
  - Item #1: `24V DC` Power Supply outputting at least `2A` via a `male` `5.5mm` x `2.5mm` barrel connector
  - Item #2: Barrel connector splitter, 1 * `male` `5.5mm` x `2.5mm` to 4 * `female` `5.5mm` x `2.5mm`
  - Item #3: 4 * Barrel connector adapter, `female` `5.5mm` x `2.5mm` to `female` `6.5mm` x `3.0mm`
  - Note(s):
    > - Finding aforementioned adapters may be difficult due to the `6.5mm` x `3.0mm` `barrel connector` being a rare type of termination

<!-- ------------------------------------------------------------ -->

***
## Generalized Solution #2 (w/ cutting cables ✂️)
  - Item #1: `24V DC` Power Supply outputting at least `2A` via a `male` `5.5mm` x `2.5mm` barrel connector
  - Item #2: Barrel connector splitter, 1 * `male` `5.5mm` x `2.5mm` to 4 * `female` `5.5mm` x `2.5mm`
  - Item #3: Barrel connectors, `female` `5.5mm` x `2.5mm`
    - View Amazon listings which match: [`5.5 x 2.5mm barrel connectors female`](https://www.amazon.com/s?k=5.5+x+2.5mm+barrel+connectors+female)

<!-- ------------------------------------------------------------ -->

***
### Citation(s)

- [`GitHub - Hypfer/huesful-power-adaptor: Use proper PSUs with Hue Signes, Playbars and more | github.com`](https://github.com/Hypfer/huesful-power-adaptor)

- [`Power adapter for my Hue Sync box / play lights went out (overheats to the point it’s too hot to touch for more than 2 seconds) Contacted Philips to see about purchasing a replacement and was told to screw off basically. Any advice on where to purchase a decent replacement? : r/Hue | www.reddit.com`](https://www.reddit.com/r/Hue/comments/vaedcl/power_adapter_for_my_hue_sync_box_play_lights)

<!-- ------------------------------------------------------------ -->