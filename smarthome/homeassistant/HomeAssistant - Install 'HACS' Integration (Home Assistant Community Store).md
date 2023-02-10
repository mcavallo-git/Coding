
# HomeAssistant - Install Add-on 'HACS' (Home Assistant Community Store)

***

- ### Step 1) Download & Install HACS
  - Follow the installation steps @ https://hacs.xyz/docs/setup/download/
    - Open an SSH terminal as root into your Home Assistant instance
      - Run the HACS installation convenience script:
        ```wget -O - https://get.hacs.xyz | bash -```
- ### Step 2) Enable & Configure HACS
  - Follow the initial configuration guide @ https://hacs.xyz/docs/configuration/basic
    - In your Home Assistant instance, go to "+ ADD INTEGRATION" > enter "HACS" and install the integration
      - Follow the steps to link HACS to a GitHub Account under your ownership/control  -  "HACS uses the GitHub API to gather information about all available and downloaded repositories. This API is rate limited to 60 requsets every hour for unauthenticated requests, which is not enough. So HACS needs to make authenticated requests to that API." - https://hacs.xyz/docs/faq/github_account
        - [ TO DO - ENTER REMAINING CONFIGURATION STEPS HERE ]

***


<!--
# ------------------------------------------------------------
#
# Citation(s)
#
#   hacs.xyz  |  "Download | HACS"  |  https://hacs.xyz/docs/setup/download/
#
#   hacs.xyz  |  "Initial Configuration | HACS"  |  https://hacs.xyz/docs/configuration/basic
#
# ------------------------------------------------------------
-->