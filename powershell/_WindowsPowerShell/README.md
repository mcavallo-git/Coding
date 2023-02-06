<!-- ------------------------------------------------------------ ---

This file (on GitHub):

  https://github.com/mcavallo-git/Coding/tree/main/powershell/_WindowsPowerShell

--- ------------------------------------------------------------- -->

<h1>PowerShell Modules</h1>

<hr />

<!-- ------------------------------------------------------------ -->

<h2>Sync PowerShell Module(s) from GitHub Repo [ <a href="https://github.com/mcavallo-git/Coding/tree/main/powershell/_WindowsPowerShell/Modules">mcavallo-git/Coding</a> ]</h2>
<ul>
  <li>
    <h3>Prerequisite(s)</h3>
    <ul>
      <li><a href="https://git-scm.com/download/win">Git SCM</a> has been installed
        <ul>
          <li>Git CLI has been added to the PATH (environment variable)
            <ul>
              <li>
                <details>
                  <summary><span>View Screenshot (Add Git CLI to PATH)</span></summary>
                  <div style="text-align:center;">
                    <img src="https://github.com/mcavallo-git/Coding/raw/main/images/archive/git-install.allow-cli.png" height="250" />
                  </div>
                </details>
              </li>
            </ul>
          </li>
        </ul>
      </li>
    </ul>
  </li>
  <li>
    <h3>Sync PowerShell Module(s)</h3>
    <ul>
      <li>Run the following command in an <b><u>admin</u></b> PowerShell terminal:
        <ul>
          <li>
            <pre lang="powershell">$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/main/sync.ps1?t=$((Date).Ticks)")); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;</pre>
          </li>
          <li>
            <details>
              <summary><span>View fallback method (run if above command returns error(s))</span></summary>
              <ul>
                <li>Run the following command in an <b><u>admin</u></b> PowerShell terminal:
                  <ul>
                    <li>
                      <pre lang="powershell">$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; $SyncTemp="${Env:TEMP}\sync.$($(Date).Ticks).ps1"; New-Item -Force -ItemType "File" -Path ("${SyncTemp}") -Value (($(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/main/sync.ps1?t=$((Date).Ticks)"))) | Out-Null; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; . "${SyncTemp}"; Remove-Item "${SyncTemp}";</pre>
                    </li>
                  </ul>
                </li>
              </ul>
            </details>
          </li>
        </ul>
      </li>
    </ul>
  </li>
</ul>

<hr />

<!-- ------------------------------------------------------------ -->