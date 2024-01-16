***

# How To Restrict Internet Access Using Group Policy (GPO)
  - Perform the following step(s) while logged into the user who you wish to blocker internet access for:

***

1. > The EnableProxy key will check the box to force the browser to use the proxy settings.
    - Key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings`
    - Property: `ProxyEnable`
    - Type: `REG_DWORD`
    - Value: `1`

***

2. > Repeat the same steps to create an additional registry item. The ProxyServer will point to the localhost, 127.0.0.1.
    - Key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings`
    - Property: `ProxyServer`
    - Type: `REG_SZ`
    - Value: `127.0.0.1:80`

***

3. > The next reg key will allow you to bypass the proxy server and let you view sites. Typically, you should allow your own domain name so the users can gain access to internal links and any sub-domains if applicable.
    - Key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings`
    - Property: `ProxyOverride`
    - Type: `REG_SZ`
    - Value: `(blank)`

***

4. > The last registry item will disable/uncheck the “Automatically Detect Settings” part.
    - Key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings`
    - Property: `AutoDetect`
    - Type: `REG_DWORD`
    - Value: `0`

***

## Citation(s)

- [thesysadminchannel.com  |  "How To Restrict Internet Access Using Group Policy (GPO) - the Sysadmin Channel"](https://thesysadminchannel.com/how-to-restrict-internet-access-using-group-policy-gpo/)

***