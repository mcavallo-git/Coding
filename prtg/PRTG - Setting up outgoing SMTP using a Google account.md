<!-- https://github.com/mcavallo-git/Coding/blob/main/prtg/PRTG%20-%20Setting%20up%20outgoing%20SMTP%20using%20a%20Google%20account.md -->

## PRTG - Setting up outgoing SMTP using a Google account

***

### 1. Setting up Google Account `App Password`
- Prereq: `2FA` (`Two-Factor Authentication`) must be enabled for Google Account before `App Passwords` may be created
- Create an `App Password` for Google Account to use for outgoing SMTP (use the `App Password` as the `SMTP Relay Password` in PRTG)

***

### 2. Updating PRTG SMTP Settings
- Open admin page `Notification Delivery`
  - Via the GUI:
    - → `Setup` <sub>*(top right tab)*</sub>
      - → `Notification Delivery` <sub>*(under `System Administration`)*</sub>
  - Via URL:
    - `<http(s)://your-prtg-fqdn>/systemsetup.htm?tabid=3`
      - *Note: Replace `<http(s)://your-prtg-fqdn>` with your PRTG server's scheme & FQDN)*
- #### SMTP Delivery
  - | Setting        | Value to set                                    |
    | :-------------------------- | :--------------------------------------- |
    | `Delivery Mechanism`        | `Use one SMTP relay server`              |
    | `Sender Email Address`      | `<smtp-account>@gmail.com`   |
    | `Sender Name`               | `<smtp-nickname>`            |
    | `HELO Ident`                | `<smtp-nickname>`            |
    | `SMTP Relay Server`         | `smtp.gmail.com`                         |
    | `SMTP Relay Port`           | `587`                                    |
    | `SMTP Relay Authentication` | `Use standard SMTP authentication`       |
    | `SMTP Relay User Name`      | `<smtp-account>@gmail.com`   |
    | `SMTP Relay Password`       | `<app-password>`             |
    | `Connection Security`       | `Use SSL/TLS if the server supports it`  |
    | `SSL/TLS Method`            | `TLS 1.3`                                |
    - Note: Replace `<smtp-account>`, `<smtp-nickname>` and `<app-password>` with your respective values from your Google account (`smtp-nickname` is arbitrary)
  - Once finished, press `Save` <sub>*(middle right)*</sub>
  - To test SMTP settings, press `Test SMTP Settings`, enter an email address which you can receive email at, then select `OK` to send yourself a test email

***

### 3. Debugging outgoing SMTP
- Check outgoing SMTP logs
  - Open debug page `Log Entries Related To Notifications`
    - Via the GUI:
      - → `Logs` <sub>*(hover, top right tab)*</sub>
        - → `System Events` <sub>*(hover, dropdown menu item)*</sub>
          - → `Notification Related` <sub>*(select, dropdown menu item)*</sub>
    - Via URL:
      - `<http(s)://your-prtg-fqdn>/log.htm?filter_status=13`
        - *Note: Replace `<http(s)://your-prtg-fqdn>` with your PRTG server's scheme & FQDN)*

***

- ### Citation(s)
  - [kb.paessler.com | Can Gmail / Google Apps / G-Suite be used for SMTP relay? - Paessler Knowledge Base](https://kb.paessler.com/en/topic/2823-can-gmail-google-apps-g-suite-be-used-for-smtp-relay)

***
