<!-- https://github.com/mcavallo-git/Coding/blob/main/windows/Steam/Steam%20-%20Valheim%20Optimizations.md -->

## Valheim Optimizations (+20 free fps)

- Open `Steam` → Right-click `Valheim` → Select `Properties`
  <br />
  - Under the `General` tab, paste the following under `Launch Options`:
    <br />
    - `%command% -gfx-enable-gfx-jobs 0 -gfx-enable-native-gfx-jobs 0 -scripting-runtime-version latest -vr-enabled 0 -gc-max-time-slice 8`
      <br />
      - Replace the rightmost `8` with the number of threads on your CPU
        <br />
        - Enjoy the free frames in Valheim :thumbsup:


## Rambling about `boot.config`
  - Editing the Steam game's `Properties` is superior to the common practice of editing Valheim's `boot.config` file for one primary reason:
    <br />
    - The Steam `Properties` functionality does not get overwritten when Valheim is updated, whereas changes to `boot.config` can (and will likely again) be overwritten whenever a new Valheim release decides to update it, which will wipe any custom `boot.config` settings you have defined.


## Citation(s)
  - [github.com  |  GitHub - ZeroOneZero/Performance-Mod-Guide-For-Valheim: Boost Valheim's FPS to forge a smoother Viking journey!](https://github.com/ZeroOneZero/Performance-Mod-Guide-For-Valheim)
  - [reddit.com  |  Better Valheim FPS with newer BootConfig, +25 FPS instantly on a heavily modded game (credit: Krumpac) : r/valheim](https://www.reddit.com/r/valheim/comments/1ccum0s/comment/l19dwox/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)