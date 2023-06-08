***

# 3-/4-Pin PC Fan Voltage Step-Downs

***

- ## Voltage input/output across diodes in series
  | Test Case | Component | Count | Connection Type               | Resistance | Input (`5V`) | ⚠️ Output (`5V`) | Input (`12V`) | ⚠️ Output (`12V`) |
  | --------: | --------- | ----: | ----------------------------- | ---------: | -----------: | ---------------: | ------------: | -----------------: |
  |     `001` | `1N4001`  |   `5` | `Solder` + <br />`Heatshrink` | `28.75 MΩ` |     `5.12 V` |         `4.11 V` |     `11.73 V` |          `10.63 V` |
  |   <br />  |           |       |                               |            |              |                  |               |                    |
  |     `002` | `1N4001`  |   `5` | `Breadboard`                  | `32.67 MΩ` |     `5.12 V` |         `3.85 V` |     `11.73 V` |          `10.17 V` |
  |     `003` | `1N4001`  |   `5` | `Breadboard`                  | `34.25 MΩ` |     `5.12 V` |         `3.79 V` |     `11.73 V` |          `10.15 V` |
  |     `004` | `1N4001`  |   `5` | `Breadboard`                  | `26.30 MΩ` |     `5.12 V` |         `3.81 V` |     `11.73 V` |          `10.18 V` |
  |     `005` | `1N4001`  |   `5` | `Breadboard`                  | `25.89 MΩ` |     `5.12 V` |         `3.81 V` |     `11.73 V` |          `10.18 V` |
  |   <br />  |           |       |                               |            |              |                  |               |                    |
  |     `006` | `1N4001`  |   `1` | `Breadboard`                  |  `2.57 MΩ` |     `5.12 V` |         `4.83 V` |     `11.73 V` |          `11.40 V` |
  |     `007` | `1N4001`  |   `2` | `Breadboard`                  |  `6.37 MΩ` |     `5.12 V` |         `4.54 V` |     `11.73 V` |          `11.08 V` |
  |     `008` | `1N4001`  |   `3` | `Breadboard`                  | `11.50 MΩ` |     `5.12 V` |         `4.28 V` |     `11.73 V` |          `10.77 V` |
  |     `009` | `1N4001`  |   `4` | `Breadboard`                  | `19.55 MΩ` |     `5.12 V` |         `4.04 V` |     `11.73 V` |          `10.46 V` |
  |     `010` | `1N4001`  |   `5` | `Breadboard`                  | `29.86 MΩ` |     `5.12 V` |         `3.79 V` |     `11.73 V` |          `10.15 V` |
  |   <br />  |           |       |                               |            |              |                  |               |                    |

  >&nbsp;
  >Notes:
  >&nbsp;&nbsp;&nbsp;&bull;&nbsp;Values obtained using a multimeter to take readings
  >&nbsp;&nbsp;&nbsp;&bull;&nbsp;Input (`5V`) was a `USB to PWM` cable connected to a `5V/2.1A` USB power supply
  >&nbsp;&nbsp;&nbsp;&bull;&nbsp;Input (`12V`) was a `Wall Wart to PWM` power supply
  >&nbsp;&nbsp;&nbsp;&bull;&nbsp;Rows which match on `Connection Type` & `Count` denote different diodes were used for each test case
  >&nbsp;&nbsp;&nbsp;&bull;&nbsp;A sample size of `9` diodes was used for averaged measurements
  >&nbsp;

***

- ## Resistance across diodes in series
  - | Component | Count | Resistance (Avg) |
    | :-------- | ----: | ---------------: |
    | `1N4001`  |   `1` |        `2.53 MΩ` |
    | `1N4001`  |   `2` |        `6.17 MΩ` |
    | `1N4001`  |   `3` |       `11.71 MΩ` |
    | `1N4001`  |   `4` |       `20.34 MΩ` |
    | `1N4001`  |   `5` |       `30.71 MΩ` |
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
  - > Note: All diode resistance measurements are in `MΩ` (Megaohms)

***

- ## Diodes act as resistors if the marking around the center of their body is closer to the Cathode side
  ![pinout - diode_anode-cathode](pinout%20-%20diode_anode-cathode.svg)

***

- ## Citation(s)
  - [en.wikipedia.org | Diode - Wikipedia](https://en.wikipedia.org/wiki/Diode)
  - [github.com | Coding/pinout - pc-fan-voltage-reducers-stepdowns-diodes](https://github.com/mcavallo-git/Coding/blob/main/pinouts/pinout%20-%20pc-fan-voltage-reducers-stepdowns-diodes.md)
  - [jeelabs.org | Easy Electrons – Diodes » JeeLabs](https://jeelabs.org/2011/01/09/easy-electrons-%E2%80%93-diodes/index.html)

***