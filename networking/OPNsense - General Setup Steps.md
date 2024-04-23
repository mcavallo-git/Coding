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
    - [View documentation (Quickstart / getting started)](https://docs.opnsense.org/hardware/quickstart.html)

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
    - Add new interfaces via `Interfaces` > `Assignments`
    - For each **LAN** interface:
      - Set `IPv4 Configuration Type` to `Static IPv4`
        - Set `IPv4 address` to the router's desired address (default is `192.168.1.1`)
          - Note: Changing this value will require reconnecting to the OPNsense router
      - Set `IPv6 Configuration Type` to `None` (unless IPv6 is desired)
    - For each **WAN** interface:
      - Enable `Block private networks`
      - Enable `Block bogon networks`
      - Set `IPv4 Configuration Type` to `DHCP` (unless IPv4 address from ISP is static)
      - Set `IPv6 Configuration Type` to `None` (unless IPv6 is desired)
    - Note: You can rename the `Identifier` for a given interface by downloading a backup of OPNsense, then carefully replacing instances of the given identifier everywhere it is used with a different, unique identifier (followed by a reupload of the modified backup back to OPNsense)
    - [View documentation (Interface configuration)](https://docs.opnsense.org/manual/interfaces.html)

  - #### DHCP & Static IPs
    - Browse to `Services` > `ISC DHCPv4` > `[LAN]`
      - Set `Range` `from` and `to` values to the desired start/end ranges of your DHCP server
      - Set `DNS servers` to desired DHCP DNS servers
      - Set `Domain name` to desired DHCP domain name
        - Also set value under `System` > `Settings` > `General` > `Domain`
      - Set `Static ARP` to `✔️ Enable Static ARP entries`
      - Set Static IPs under `DHCP Static Mappings for this interface`
        - For bulk adding of static IPv4 addresses, download a backup configuration from OPNsense, and manually add the JSON values in bulk (followed by a reupload of the modified backup back to OPNsense)
    - [View documentation (DHCP)](https://docs.opnsense.org/manual/dhcp.html)

  - #### Gateways
    - Setup WAN gateways via `System` > `Gateways` > `Configuration`
    - Add IPv4/IPv6 gateways for any WAN interfaces which are missing gateways
    - For each WAN gateway:
      - Select `Upstream Gateway`
      - Set a **unique** `Monitor IP`
      - Set the `Priority` to:
        -  `1` for your primary WAN gateway (primary ISP)
        -  `2` for your secondary WAN gateway (secondary/redundant/failover ISP)
        -  `3 or higher` for any additional fallback WAN gateways
      - [View documentation (Multi WAN)](https://docs.opnsense.org/manual/how-tos/multiwan.html)
    - Disable IPv6
      - Optionally, for each IPv6 gateway, select `Disabled` (if IPv6 is not desired)
    - Enable automatic WAN failover
      - Browse to `System` > `Settings` > `General`
        - Set `Gateway switching` to `✔️ Allow default gateway switching`
    - [View documentation (Gateways)](https://docs.opnsense.org/manual/gateways.html)

  - #### QoS
    - Setup traffic shaping
      - For each WAN interface, create two Pipes (one for download & one for upload) via `Firewall` > `Shaper` > `Pipes`
        - Recommended to set download pipe to 90% of ISP download rate to avoid [bufferbloat](https://www.waveform.com/tools/bufferbloat)
      - For each Pipe, create a respective Queue via  `Firewall` > `Shaper` > `Queues`
      - For each Queue, create a respective Rule via  `Firewall` > `Shaper` > `Rules`
    - [View documenation (Setup Traffic Shaping)](https://docs.opnsense.org/manual/how-tos/shaper.html)

  - #### DDNS
    - Install plugin `os-ddclient`
    - Browse to `Services` > `Dynamic DNS` > `Settings`
      - Add/edit a DDNS entry with the following:
        - Set `Service` to the DDNS `service provider's name`
        - Set `Username` to the DDNS `domain name (domain.tld)`
        - Set `Hostname(s)` to the DDNS `FQDN (subdomain.domain.tld)`
        - Set `Check ip method` to `Interface`
          - Set `Interface to monitor` to the desired WAN interface whose WAN IPv4 should be used
        - Enable `Force SSL`
    - [View documenation (Dynamic DNS)](https://docs.opnsense.org/manual/dynamic_dns.html)

  - #### Backup/Restore
    - Browse to `System` > `Configuration` > `Backup`
      - Download a backup of the current OPNsense configuration
        - Under `Download`, select `Download configuration`
      - Upload an OPNsense configuration
        - Under `Restore`, select `Choose File` and select the backup file to restore from, then select `Restore configuration`
    - [View documenation (Backup)](https://docs.opnsense.org/manual/backups.html)

***
<!-- ------------------------------------------------------------ -->
