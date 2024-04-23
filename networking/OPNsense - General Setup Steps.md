# OPNsense - General Setup Steps

***
<!-- ------------------------------------------------------------ -->

### Installation
- [Download OPNsense](https://opnsense.org/download/) (select "vga" image type)
  - Format the downloaded image onto a flash drive using a disk formatting tool such as [balenaEtcher](https://etcher.balena.io/) or [Rufus](https://rufus.ie/downloads/)

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
      - Recommended to set download pipe to 90% of ISP download rate to avoid [bufferbloat](https://www.waveform.com/tools/bufferbloat)
    - For each Pipe, create a respective Queue via  `Firewall` > `Shaper` > `Queues`
    - For each Queue, create a respective Rule via  `Firewall` > `Shaper` > `Rules`
    - [View documenation](https://docs.opnsense.org/manual/how-tos/shaper.html)

#### DDNS
  - Setup DDNS via `Services` > `Dynamic DNS` > `Settings`
    - Set `Username` as the `domain name (domain.tld)`
    - Set `Hostname(s)` as the `FQDN (subdomain.domain.tld)`
    - Set `Check ip method` to `Interface`, then select respective WAN interface to monitor

***
<!-- ------------------------------------------------------------ -->
