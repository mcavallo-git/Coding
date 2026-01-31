

------------------------------------------------------------

# Minecraft Java - JVM Arguments
  -  *Optimize Minecraft Java Edition via custom JVM Arguments*

------------------------------------------------------------

### Locate Minecraft's JVM Arguments (Java config)

- Run `Minecraft Launcher`

  - Select `Minecraft: Java Edition` > Click `Installations` tab

    - Hover over `Latest release` > Click the ellipsis `…` (on the right) > Click `Edit`

      - Click `More Options ⌄`

        - Set `JVM Arguments` to the following:
          - `-Xms8G -Xmx8G -XX:+UseG1GC -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M`

        - Default `JVM Arguments` (as-of 2026-01-15_09-10-21)
          - `-Xmx2G -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M`



------------------------------------------------------------
