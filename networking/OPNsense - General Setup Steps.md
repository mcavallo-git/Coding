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
  - Setup failover WAN
    - > ⚠️ Todo: Add steps here ⚠️
    - [View documentation](https://docs.opnsense.org/manual/how-tos/multiwan.html)

#### QoS
  - Setup traffic shaping
    - For each WAN interface, create two Pipes (one for download & one for upload) via `Firewall` > `Shaper` > `Pipes`
    - For each Pipe, create a respective Queue via  `Firewall` > `Shaper` > `Queues`
    - For each Queue, create a respective Rule via  `Firewall` > `Shaper` > `Rules`
    - [View documenation](https://docs.opnsense.org/manual/how-tos/shaper.html)

***
<!-- ------------------------------------------------------------ -->
