***

# 3-/4-Pin PC Fan Voltage Step-Downs

***

- ## Voltage input/output across diodes in series
  | Test Case | Description          | Resistance | Input Voltage | Output Voltage |
  | --------: | -------------------- | ---------: | ------------: | -------------: |
  |     `001` | `5 * 1N4001 (Diode)` | `28.75 MΩ` |      `5.12 V` |       `4.11 V` |
  |     `001` | `5 * 1N4001 (Diode)` | `28.75 MΩ` |     `11.73 V` |      `10.63 V` |
  |           |                      |            |               |                |
  |     `002` | `5 * 1N4001 (Diode)` | `32.67 MΩ` |      `5.12 V` |       `3.85 V` |
  |     `002` | `5 * 1N4001 (Diode)` | `32.67 MΩ` |     `11.73 V` |      `10.17 V` |
  |           |                      |            |               |                |

***

- ## Resistance across diodes in series
  - | Component        | Count | Resistance (Avg) |
    | :--------------- | ----: | ---------------: |
    | `1N4001 (Diode)` |   `1` |        `2.53 MΩ` |
    | `1N4001 (Diode)` |   `2` |        `6.17 MΩ` |
    | `1N4001 (Diode)` |   `3` |       `11.71 MΩ` |
    | `1N4001 (Diode)` |   `4` |       `20.34 MΩ` |
    | `1N4001 (Diode)` |   `5` |       `30.71 MΩ` |
<!--
  - #### Resistance across similar step downs
    | Component        | Count | Resistance (Avg) |
    | :--------------- | ----: | ---------------: |
    | `Noctua NA-RC7`  |   `1` |        `49.40 Ω` |
    | `Noctua NA-RC7`  |   `2` |        `99.20 Ω` |
    | `Noctua NA-RC7`  |   `3` |       `149.20 Ω` |
    | `Noctua NA-RC12` |   `1` |       `147.90 Ω` |
-->

***

- ## Data Set: Resistance across diodes in series
```powershell

# 1 * 1N4001
@( 2.358 , 2.555 , 2.607 , 2.630, 2.481 , 2.676 , 2.329 , 2.634 ) | Measure-Object -Average | Select-Object -ExpandProperty "Average" | ForEach-Object  { [Math]::Round(${_}, 2, 1) };

# 1 * 1N4001 (Outliers)
# @( 1.910 ) | Measure-Object -Average | Select-Object -ExpandProperty "Average" | ForEach-Object  { [Math]::Round(${_}, 2, 1) };

# 2 * 1N4001
@( 6.28 , 6.16 , 6.32 , 6.01 , 6.09 , 6.15 ) | Measure-Object -Average | Select-Object -ExpandProperty "Average" | ForEach-Object  { [Math]::Round(${_}, 2, 1) };

# 3 * 1N4001
@( 11.25 , 11.71 , 11.87 , 12.00 ) | Measure-Object -Average | Select-Object -ExpandProperty "Average" | ForEach-Object  { [Math]::Round(${_}, 2, 1) };

# 4 * 1N4001
@( 20.45 , 19.45 , 21.12 ) | Measure-Object -Average | Select-Object -ExpandProperty "Average" | ForEach-Object  { [Math]::Round(${_}, 2, 1) };

# 5 * 1N4001
@( 28.75 , 32.67 ) | Measure-Object -Average | Select-Object -ExpandProperty "Average" | ForEach-Object  { [Math]::Round(${_}, 2, 1) };

```
  - > Note: Values obtained using a breadboard & multimeter, placing diodes in different ordered series
  - > Note: A sample size of `9` diodes was used for measurements
  - > Note: All diode measurements taken are in `MΩ` (Megaohms)

***

- ## Diodes act as resistors if the marking around the center of their body is closer to the Cathode side
  ![pinout - diode_anode-cathode](pinout%20-%20diode_anode-cathode.svg)

***

- ## Citation(s)
  - [en.wikipedia.org | Diode - Wikipedia](https://en.wikipedia.org/wiki/Diode)
  - [github.com | Coding/pinout - pc-fan-voltage-reducers-stepdowns-diodes](https://github.com/mcavallo-git/Coding/blob/main/pinouts/pinout%20-%20pc-fan-voltage-reducers-stepdowns-diodes.md)
  - [jeelabs.org | Easy Electrons – Diodes » JeeLabs](https://jeelabs.org/2011/01/09/easy-electrons-%E2%80%93-diodes/index.html)

***