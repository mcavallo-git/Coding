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

<!-- ------------------------------------------------------------ -->

***
## Specifications - Philips Hue Play Devices
- Power
  - Voltage: `24V`
  - Connector Type: `6.5mm` x `3.0mm` `Barrel Connector`
  - Notes:
    - The Hue Play devices have a `male` barrel connector on the end of their cable (coming from the device)
    - The Hue Play power adapters have either `1` or `3` `female` barrel connector ports
      - The adapter with `1` female port outputs up to `0.83A` @ `24.0V` (`20.0W`)
      - The adapter with `3` female port outputs up to `0.875A` @ `24.0V` (`21.0W`)

<!-- ------------------------------------------------------------ -->

***
## Generalized Solution
  - Item #1: `24V` Power Supply outputting at least `2A` via a male `5.5mm` x `2.5mm` barrel connector
  - Item #2: Barrel connector splitter, 1 * male `5.5mm` x `2.5mm` to 4 * female `5.5mm` x `2.5mm`
  - Item #3: 4 * Barrel connector adapter, female `5.5mm` x `2.5mm` to female `6.5mm` x `3.0mm`
    - > ⚠️ Likely very difficult to find, if not non-existent

<!-- ------------------------------------------------------------ -->

***
### Citation(s)

- [`GitHub - Hypfer/huesful-power-adaptor: Use proper PSUs with Hue Signes, Playbars and more | github.com`](https://github.com/Hypfer/huesful-power-adaptor
)
- [`Power adapter for my Hue Sync box / play lights went out (overheats to the point it’s too hot to touch for more than 2 seconds) Contacted Philips to see about purchasing a replacement and was told to screw off basically. Any advice on where to purchase a decent replacement? : r/Hue | www.reddit.com`](https://www.reddit.com/r/Hue/comments/vaedcl/power_adapter_for_my_hue_sync_box_play_lights)

<!-- ------------------------------------------------------------ -->