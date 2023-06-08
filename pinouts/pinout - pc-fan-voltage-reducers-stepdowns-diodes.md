***

- ## Resistance/Voltage values across component(s) <u>in series</u>
  | Component         |  Count | Resistance |
  | :---------------- | -----: | ---------: |
  | `1N4001 (Diode)`  |    `1` |  `2.53 MΩ` |
  | `1N4001 (Diode)`  |    `2` |  `6.21 MΩ` |
  | `1N4001 (Diode)`  |    `3` | `11.52 MΩ` |
  | `1N4001 (Diode)`  |    `4` | `19.19 MΩ` |
  | `1N4001 (Diode)`  |    `5` | `28.75 MΩ` |
  |                   |        |            |
  | `Noctua NA-RC7`   |    `1` |  `49.40 Ω` |
  | `Noctua NA-RC7`   |    `2` |  `99.20 Ω` |
  | `Noctua NA-RC7`   |    `3` | `149.20 Ω` |
  |                   |        |            |
  | `Noctua NA-RC12`  |    `1` | `147.90 Ω` |
  |                   |        |            |

***

- ## Measuring resistance across component(s) <u>in series</u>
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
@( 19.19 , 17.40 ) | Measure-Object -Average | Select-Object -ExpandProperty "Average" | ForEach-Object  { [Math]::Round(${_}, 2, 1) };

# 5 * 1N4001
@( 28.75 ) | Measure-Object -Average | Select-Object -ExpandProperty "Average" | ForEach-Object  { [Math]::Round(${_}, 2, 1) };

```

***

- ## Diodes act as resistors if the marking around the center of their body is closer to the Cathode side
  ![pinout - diode_anode-cathode](pinout%20-%20diode_anode-cathode.svg)

***

- ## Citation(s)
  - [en.wikipedia.org | Diode - Wikipedia](https://en.wikipedia.org/wiki/Diode)
  - [github.com | Coding/pinout - pc-fan-voltage-reducers-stepdowns-diodes](https://github.com/mcavallo-git/Coding/blob/main/pinouts/pinout%20-%20pc-fan-voltage-reducers-stepdowns-diodes.md)
  - [jeelabs.org | Easy Electrons – Diodes » JeeLabs](https://jeelabs.org/2011/01/09/easy-electrons-%E2%80%93-diodes/index.html)

***