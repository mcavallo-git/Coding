<!-- https://github.com/mcavallo-git/Coding/blob/main/windows/HWiNFO64/HWiNFO64%20-%20Good%20Settings.md -->

***

### HWiNFO64 - Temperature Testing Guide (High Level)

***

- Starting off, always use Celsius for computer temps, as no one uses Fahrenheit for PC components (and finding comparative values will require conversion to Celsius anyway).

- Install HWiNFO ( https://www.hwinfo.com/download/ ) to monitor component temps. When running it, do “Sensors Only”, then on the sensor view, locate CPU Load % and average CPU temp, as well as GPU Load % and average GPU temp.

- The goal is to get temps when both Load %s are near 0% (“At Idle”) as well as near 100% (“Under Load”). Two different values, showing the approximate min and max temperature range for your system’s CPU and GPU. Under load is more important, as that can show if components are thermal throttling.

- To put your system under load, you can run synthetic benchmarks made by Unigine for the GPU ( https://benchmark.unigine.com/ ) or use a simple computational benchmarking tool for the CPU, like Prime95 ( https://www.mersenne.org/download/ ).

- Once you have your values, compare them to others using either the same CPU, GPU, or both, and their respective temperatures.

- Under load, here’s a quick general summary for all components (very high level/vague/hand-wavy):
  - ~90-95+ degrees Celsius may indicate thermal throttling (very bad)
  - ~70-89 degrees Celsius isn’t great but likely means not thermal throttling and is typical (especially under load) for mid-to-high end components
  - ~50-69 degrees Celsius is typical for components running idle
  - ~20-49 degrees Celsius usually requires custom water cooling or other stronger cooling methods to achieve, and helps the parts to live longer and waste less power due to heat loss
  - ~20 and lower (all the way down to about -140) degrees Celsius is only achievable by constantly pouring small amounts of liquid nitrogen in a “pot” as a heatsink on the CPU/CPU, and is called extreme overclocking

***
