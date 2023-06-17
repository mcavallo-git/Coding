
<!-- ------------------------------ -->
<!-- https://github.com/mcavallo-git/Coding/blob/main/networking/t-mobile-5g-internet-gateway_mimo-antenna-upgrade.md -->
<!-- ------------------------------ -->

***
# Upgrading the Antenna(s) on `T-Mobile`'s `5G Gateway`

<!-- ------------------------------ -->

***
## Step 0. Preface
- > As of `August 2022`, `T-Mobile`'s `Home Internet` service primarily uses the `Sagemcom Fast 5688W` as the client-side `5G Gateway` (modem-router) hardware.&nbsp;<sup>[`Citation`](https://www.rvmobileinternet.com/t-mobile-home-internet-adds-another-5g-cellular-gateway-the-sagecom-fast-5688w)</sup>
- > The `Sagemcom Fast 5688W` has `four` internal `U.FL` ports, which allow for `two` `2x2 MIMO antennas` or `one` `4x4 MIMO antenna` to be connected to the device.&nbsp;<sup>[`Citation`](https://www.waveform.com/a/b/guides/hotspots/t-mobile-5g-gateway-sagemcom)</sup>
- > A `4x4 MIMO antenna` offers superior performance and would allow more of the internal cellular antenna ports to be used than a `2x2 MIMO antenna`.&nbsp;<sup>[`Citation`](https://www.waveform.com/a/b/guides/hotspots/t-mobile-5g-gateway-sagemcom)</sup>

<!-- ------------------------------ -->

***
## Step 1. Hardware Selection
  > Select the configuration (below) which is best suited to the needs of your deployment scenario (based on the performance/reliability needs, budget constraints, etc.)
  ***
  ### Configuration #1 - `One` `4x4 MIMO Antenna`
  - Pros 👍
    - > More effective than using `One` `2x2 MIMO Antenna`
    - > More effective than using `Two` `2x2 MIMO Antennas`
  - Cons 👎
    - > Most expensive cost totalling ~ `💲286.00` (before tax)
  - Required hardware
    - Antenna(s): `One (1)` * [`4x4 MIMO Panel Antenna by Waveform @ ~ 💲200.00 ea.`](https://amazon.com/dp/B09VVV2TQQ)
    - Cable(s): `Four (4)` * [`SMA-Male to SMA-Male Cable @ ~ 💲15.00 ea.`](https://amazon.com/s?k=SMA+Male+to+SMA+Male+Cable)
    - Adapter(s): `Four (4)` * [`SMA-Female to N-Male Connector @ ~ 💲5.00 ea.`](https://www.amazon.com/s?k=SMA-Female+to+N-Male+Connector)
    - Adapter(s): `Four (4)` * [`U.FL to SMA-Female Pigtail Connector @ ~ 💲1.50 ea.`](https://amazon.com/s?k=SMA-Female+to+U.FL+pigtail+connectors)
  ***
  ### Configuration #2 - `Two` `2x2 MIMO Antennas`
  - Pros 👍
    - > More effective than using `One` `2x2 MIMO Antenna`
  - Cons 👎
    - > Less effective than using `One` `4x4 MIMO Antenna`
    - > Most expensive cost totalling ~ `💲286.00` (before tax)
  - Required hardware
    - Antenna(s): `Two (2)` * [`2x2 MIMO Panel Antenna by Waveform @ ~ 💲100.00 ea.`](https://amazon.com/dp/B09CLV3BHJ)
    - Cable(s): `Four (4)` * [`SMA-Male to SMA-Male Cable @ ~ 💲15.00 ea.`](https://amazon.com/s?k=SMA+Male+to+SMA+Male+Cable)
    - Adapter(s): `Four (4)` * [`SMA-Female to N-Male Connector @ ~ 💲5.00 ea.`](https://www.amazon.com/s?k=SMA-Female+to+N-Male+Connector)
    - Adapter(s): `Four (4)` * [`U.FL to SMA-Female Pigtail Connector @ ~ 💲1.50 ea.`](https://amazon.com/s?k=SMA-Female+to+U.FL+pigtail+connectors)
  ***
  ### Configuration #3 - `One` `2x2 MIMO Antenna`
  - Pros 👍
    - > Least expensive cost totalling ~ `💲143.00` (before tax)
  - Cons 👎
    - > Less effective than using `One` `4x4 MIMO Antenna`
    - > Less effective than using `Two` `2x2 MIMO Antennas`
  - Required hardware
    - Antenna(s): `One (1)` * [`2x2 MIMO Panel Antenna by Waveform @ ~ 💲100.00 ea.`](https://amazon.com/dp/B09CLV3BHJ)
    - Cable(s): `Two (2)` * [`SMA-Male to SMA-Male Cable @ ~ 💲15.00 ea.`](https://amazon.com/s?k=SMA+Male+to+SMA+Male+Cable)
    - Adapter(s): `Two (2)` * [`SMA-Female to N-Male Connector @ ~ 💲5.00 ea.`](https://www.amazon.com/s?k=SMA-Female+to+N-Male+Connector)
    - Adapter(s): `Two (2)` * [`U.FL to SMA-Female Pigtail Connector @ ~ 💲1.50 ea.`](https://amazon.com/s?k=SMA-Female+to+U.FL+pigtail+connectors)
  ***

<!-- ------------------------------ -->

***
## Step 2. Hardware Purchasing/Acquisition
- Once you have made your selection, purchase or acquire (by other means) the `required hardware` for your selected configuration
  - Once all the `required hardware` is acquired and ready to install, continue on to the next step of this guide

<!-- ------------------------------ -->

***
## Step 3. Convert the `5G Gateway`'s internal `U.FL` ports to external `SMA` ports
- For the following items, refer to section [`"Installing External Antennas to the T-Mobile 5G Internet Gateway" of the Waveform guide`](https://www.waveform.com/a/b/guides/hotspots/t-mobile-5g-gateway-sagemcom#installing-external-antennas-to-the-t-mobile-5g-internet-gateway) for detailed instructions on:
  1. Teardown the `5G Gateway` enclosure
  2. Disconnect the `5G Gateway`'s internal `U.FL` cables
      - Internal `U.FL` cable's color/position designations:
        - `5GNR P`: `Red` cable / `Leftmost` `U.FL` port
        - `LTE D`: `Green` cable / `Second from the left` `U.FL` port
        - `MIMO 1`: `Orange` cable / `Second from the right` `U.FL` port
        - `LTE M`: `Blue` cable / `Rightmost` `U.FL` port
      - Internal `U.FL` ports to disconnect:
        - If you have a `4x4 MIMO antenna`:
          - Disconnect the `Red`, `Green`, `Orange` & `Blue` cables.
        - If you have a `2x2 MIMO antenna`:
          - If `5G cell service` IS available at your location:
            - Disconnect the `Red` & `Orange` cables.
          - If `5G cell service` is NOT available ❌️ at your location:
            - Disconnect the `Green` & `Blue` cables.
      - ⚠️ Make sure to wrap disconnected/unused internal `U.FL` cables with electrical tape & move them to the side of the inner enclosure
        - <sub>*These disconnected/unused `U.FL` cables run to the internal `MIMO antennas` and should be taken care of, as they will help to avoid additional ISP charges down the road (so long as they aren't damaged and the `5G Gateway`'s antennas work as intended) if the `5G Gateway` ever needs to be returned to the `5G Gateway`'s respective ISP (such as `T-Mobile`)*</sub>
  3. Attach & route `U.FL` to `SMA` adapters to the `5G Gateway`
    - ⚠️ Make sure to route the cables from internal to external using the proper holes/gaps in the encloure
    - ⚠️ Make sure to label each external `SMA` port with the exact same label of it's associated (internal) `U.FL` port
  4. Reassemble the `5G Gateway` enclosure
    - Upon closing the `5G Gateway` back up, it should look the same as before you opened it, albeit for the handful of well-labelled `SMA` female ports which are now coming out of it

***
## Step 4. Connect the `5G Gateway` to the `MIMO antenna(s)`
  > Once all desired `SMA` adapters are ran to the outside of the `5G Gateway` enclosure and the enclosure is reassembled and closed up, the next step is to connect your `MIMO antenna(s)` to the now-external `SMA` ports on the `5G Gateway`
  - Attach the `SMA-Female` to `N-Male` adapters to each of the `N` pigtails/ports on the antenna
    - `Two` to `Four` * [`SMA-Female to N-Male Connectors`](https://www.amazon.com/s?k=SMA-Female+to+N-Male+Connector) *(one for each `N` pigtail coming from the `MIMO antenna(s)`)*
  - Run/Attach the `SMA-Male` to `SMA-Male` cables from the `5G Gateway` to the `MIMO Antenna`
    - `Two` to `Four` * [`SMA-Male to SMA-Male Cables`](https://amazon.com/s?k=SMA+Male+to+SMA+Male+Cable) *(one for each `SMA` pigtail coming from `5G Gateway`)*
  - **`Gateway`-to-`Antenna` `SMA` ordering/pairing**
    - Determining which `SMA` ports on the `5G Gateway` should be connected to which `SMA` ports on the `MIMO Antenna` may require some trial and error for your exact use case scenario:
      - For `Nader Tater`'s ordering suggestions, refer to the [YouTube video `External Waveform Antenna Test`](https://www.youtube.com/watch?v=lA0W1XRU4J8&t=1210s)
      - For `Waveform`'s ordering suggestions, refer to [their `External Antenna` guide](https://www.waveform.com/a/b/guides/hotspots/t-mobile-5g-gateway-sagemcom)
        - Search for "`in the order`" to skip to the `Gateway`-to-`Antenna` ordering section of the guide

***
## Step 5. Position, Aim & Mount the `MIMO antenna(s)`
  > The goal is to find the best location and direction for the antenna(s), to maximize data rates to the T-Mobile Gateway.
  >
  > Once you've found the position which gets you the highest data rates to the T-Mobile Gateway, that's where you'll want to install the MIMO antenna.
  - For general positioning & aiming tips, refer to section [`"Positioning and Aiming MIMO Antennas" of the Waveform guide`](https://www.waveform.com/a/b/guides/hotspots/t-mobile-5g-gateway-sagemcom#positioning-and-aiming-mimo-antennas):
  - For hardware-specific positioning/aiming/mounting guides:
    - [`Waveform` `4x4 MIMO Antenna(s)`](https://cdn.shopify.com/s/files/1/0358/5537/files/4x4_MIMO_External_Antennas_Instruction_Manual_WF_v2.3.pdf?v=1643918988)
    - [`Waveform` `2x2 MIMO Antenna(s)`](https://cdn.shopify.com/s/files/1/0358/5537/files/MIMO_External_Antennas_Instruction_Manual_WF_v6.1.1.pdf?v=1642198404)

<!-- ------------------------------ -->

***
# Citation(s)

- [`T-Mobile 5G Internet Gateway (Sagemcom Fast 5688W) External Antenna Guide - Waveform | www.waveform.com`](https://www.waveform.com/a/b/guides/hotspots/t-mobile-5g-gateway-sagemcom)

- [`✅ BIG IMPROVEMENT - Sagemcom Fast 5688W - T-Mobile 5G Home Internet - External Waveform Antenna Test - YouTube | www.youtube.com`](https://www.youtube.com/watch?v=lA0W1XRU4J8&t=1221s)

<!-- ------------------------------ -->

***
