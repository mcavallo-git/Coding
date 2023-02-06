# Windows - printing over port 9100 (setup printer using IP Address & port number)

- Open `Devices and Printers` (or run `control.exe printers`)
  - Right click the device to configure for port `9100` and select `Printer properties`
    - Under the `ports` tab, select `Add Port...`
      - Under `Available port types:` select `Standard TCP/IP Port` and click `New Port...`
        - Next to `Printer Name or IP Address:` enter said printer's hostname/FQDN or static IP address
        - Next to `Port Name` enter `9100`
        - Click `Next >`, let the Wizard attempt to resolve the port, and, assuming all goes well, click `Finish`
          - On the `Printer Ports` window, click `Close`
          - On the `[PrinterName] Properties` window, ensure that Port `9100` is checked, click `Apply` then click `OK`
            - To test the port configuration, reopen `Printer properties` and click `Print Test Page` (under `General` tab)

<!--
# ------------------------------------------------------------
#
# Citation(s)
#
#   en.wikipedia.org  |  "Page description language - Wikipedia"  |  https://en.wikipedia.org/wiki/Page_description_language
#
#   manuals.konicaminolta.eu  |  "For Network Connection (LPR/Port 9100/SMB)"  |  https://manuals.konicaminolta.eu/bizhub-PRO-1100/EN/contents/id06-_102140939.html
#
# ------------------------------------------------------------
-->