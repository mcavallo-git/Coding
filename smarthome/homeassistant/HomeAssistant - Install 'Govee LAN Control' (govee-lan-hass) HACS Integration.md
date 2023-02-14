
# HomeAssistant - Install 'Govee LAN Control' (govee-lan-hass) HACS Integration

***

- ### Step 1) Install & Configure HACS (Home Assistant Community Store)
  - [View Docs (HACS Installation Guide)](https://hacs.xyz/docs/setup/download/)
  - [View Docs (HACS Configuration Guide)](https://hacs.xyz/docs/configuration/basic)
- ### Step 2) Install 'Govee LAN Control' (govee-lan-hass) from the HACS Store
  - [View Docs ('Govee LAN Control' (govee-lan-hass) Installation Guide)](https://github.com/wez/govee-lan-hass#installation)
  - Create a `Govee Home` account via the `Govee Home` mobile app
    - Link Govee light(s) to control to your `Govee Home` account
    - Request an API key for your `Govee Home` account via `Profile` > `Settings` > `Apply for API Key`
      -  Wait for API key to arrive in the inbox for the email address tied to your `Govee Home` account
  - Open `HACS` in HomeAssistant
    - Under HACS' `Integrations` page, select `+ Explore & Download Repositories`
      - In the `Search for repository` field, type/paste `Govee LAN Control`
        - Click the `Govee LAN Control` HACS integration, then select `↓ Download` (bottom right)
          - Visually confirm the local download path & click `Download`
            - Wait for the HACS `Integrations` page to display the new integration with red `Pending restart` header
              - Perform a `Restart [Home Assistant] Core` to complete the installation of the HACS integration
  - Open the default HomeAssistant `Integrations` page
    - Select `+ Add Integration` & type/paste `Philips Hue Play HDMI Sync Box`
      - Click the `Govee LAN Control` integration to install it
        - In the `API Key` field, paste your Govee Home account's API Key and select `Submit`

***


<!--
# ------------------------------------------------------------
#
# Citation(s)
#
#   github.com  |  "GitHub - wez/govee-lan-hass: Control Govee lights via the LAN API from Home Assistant"  |  https://github.com/wez/govee-lan-hass#installation
#
# ------------------------------------------------------------
-->