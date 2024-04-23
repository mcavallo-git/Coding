# OPNsense - General Setup Steps

***
<!-- ------------------------------------------------------------ -->

### Installation
- [Download OPNsense (select "vga" image type)](https://opnsense.org/download/)
  - Format image onto flash drive using a tool such as [balenaEtcher](https://etcher.balena.io/) or [Rufus](https://rufus.ie/downloads/)

***
<!-- ------------------------------------------------------------ -->

### Setup

#### Update
  - Update firmware & plugins via `System` > `Firmware` > `Settings` > `Check for updates` > `✔️ Update`

#### Dark Mode
  - Install dark mode theme via  `System` > `Firmware` > `Plugins` > Search for `theme` > Install `os-theme-cicada`
    - Apply theme via  `System` > `Settings` > `General` > `Theme` > Select `cicadia`

#### Interfaces
  - Setup interfaces via `Interfaces` > `Assignments`
  - Setup failover WAN ([View documentation](https://docs.opnsense.org/manual/how-tos/multiwan.html))


#### QoS
  - Setup traffic shaping ([View documenation](https://docs.opnsense.org/manual/how-tos/shaper.html))

***
<!-- ------------------------------------------------------------ -->
