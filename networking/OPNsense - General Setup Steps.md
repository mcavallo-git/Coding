# OPNsense - General Setup Steps

***
<!-- ------------------------------------------------------------ -->

### Installation

  - #### Create Boot Media
    - [Download OPNsense](https://opnsense.org/download/) (select "vga" image type)
      - If using a hardware router: Format the downloaded image onto a flash drive using a disk formatting tool such as [balenaEtcher](https://etcher.balena.io/) or [Rufus](https://rufus.ie/downloads/)
      - If using a software router: Mount the image as a bootable drive for target VM
  - #### Format the OS
    - Boot the device using the OPNsense bootable media, wait for OPNsense to install drivers as necessary
      - When prompted for login credentials, use the following:
        - Default username: `root`
        - Default password: `opnsense`
          - You will be required to change the password for the root user
  - #### Connect to OPNsense
    - Once installation is complete, on a separate device which is connected to the OPNsense router's LAN network, browse to the OPNsense dashboard at `192.168.1.1` (default IPv4 address for OPNsense)
      - Assign a static IPv4 address on the device accessing OPNsense from `192.168.1.2`-`192.168.1.254` (such as `192.168.1.100`)
      - Determining which ethernet port is used for the LAN network may require iteratively testing port-by-port on the OPNsense router
    - [View documentation](https://docs.opnsense.org/hardware/quickstart.html)

***
<!-- ------------------------------------------------------------ -->

### Configuration

  - #### Updates
    - Update firmware & plugins via `System` > `Firmware` > `Settings`
      - Select tab `Status`, then select `Check for updates`
        - Once updates have been pulled:
          - Select `✔️ Update` to update OPNsense firmware/plugins (or select `Close` if no updates were found)

  - #### Themes
    - Install dark mode theme via  `System` > `Firmware` > `Plugins`
      - Search for "theme" & install plugin named `os-theme-cicada`
      - Apply theme via  `System` > `Settings` > `General` > `Theme` > Select `cicadia`

  - #### Interfaces
    - Setup interfaces via `Interfaces` > `Assignments`
    - Setup failover WAN
      - > ⚠️ Todo: Add steps here ⚠️
      - [View documentation](https://docs.opnsense.org/manual/how-tos/multiwan.html)

  - #### Gateways
    - Setup WAN gateways via `System` > `Gateways` > `Configuration`
    - Add IPv4/IPv6 gateways for any WAN interfaces which are missing gateways
    - For each WAN gateway:
      - Select `Upsream Gateway`
      - Set a **unique** `Monitor IP`
      - Set the `Priority` to:
        -  `1` for your primary WAN gateway (primary ISP)
        -  `2` for your secondary WAN gateway (secondary/redundant/failover ISP)
        -  `3 or higher` for any additional fallback WAN gateways
      - [View documentation](https://docs.opnsense.org/manual/gateways.html)
    - Disable IPv6
      - Optionally, for each IPv6 gateway, select `Disabled` (if IPv6 is not desired)

  - #### QoS
    - Setup traffic shaping
      - For each WAN interface, create two Pipes (one for download & one for upload) via `Firewall` > `Shaper` > `Pipes`
        - Recommended to set download pipe to 90% of ISP download rate to avoid [bufferbloat](https://www.waveform.com/tools/bufferbloat)
      - For each Pipe, create a respective Queue via  `Firewall` > `Shaper` > `Queues`
      - For each Queue, create a respective Rule via  `Firewall` > `Shaper` > `Rules`
      - [View documenation](https://docs.opnsense.org/manual/how-tos/shaper.html)

  - #### DDNS
    - Setup DDNS via `Services` > `Dynamic DNS` > `Settings`
      - Set `Username` as the `domain name (domain.tld)`
      - Set `Hostname(s)` as the `FQDN (subdomain.domain.tld)`
      - Set `Check ip method` to `Interface`, then select respective WAN interface to monitor

***
<!-- ------------------------------------------------------------ -->
