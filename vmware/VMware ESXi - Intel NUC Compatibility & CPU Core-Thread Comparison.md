<!-- ------------------------------------------------------------
https://github.com/mcavallo-git/Coding/blob/main/vmware/VMware%20ESXi%20-%20Intel%20NUC%20Compatibility%20&%20CPU%20Core-Thread%20Comparison.md
------------------------------------------------------------- -->

# Intel NUC ESXi Compatibility & CPU Comparisons

<hr />

## NUC Model/CPU Comparisons
| <h4>NUC Generation</h4> | <h4>NUC Family</h4> | <h4>NUC Model</h4> | <h4>CPU Model</h4>           | <h4>CPU Cores<br /> & Threads (T)</h4> | <h4>CPU Frequency<br />(Base/Max)</h4>   | <h4>CPU Capacity<br />(ESXi)</h4> | <h4>Price (USD)</h4>      | <h4>GHz per $100</h4> |
| :---------------------- | :------------------ | :----------------- | :--------------------------- | :------------------------------------- | :--------------------------------------- | :-------------------------------- | :------------------------ | :-------------------- |
| <hr />                  | <hr />              | <hr />             | <hr />                       | <hr />                                 | <hr />                                   | <hr />                            | <hr />                    | <hr />                |
| `13th Gen`              | `Extreme`           | `NUC13RNGi9`       | `i9-13900K`                  | `8 (16T) (P)`<br />`16 (16T) (E)`      | `3.0/5.4 GHz (P)`<br />`2.2/4.3 GHz (E)` | `59.2 GHz`                        | `$1597` <sub>(Intc)</sub> | `3.71`                |
| `13th Gen`              | `Extreme`           | `NUC13RNGi7`       | `i7-13700K`                  | `8 (16T) (P)`<br />`8 (8T) (E)`        | `3.4/5.3 GHz (P)`<br />`2.5/4.2 GHz (E)` | `47.2 GHz`                        | `$1351` <sub>(Intc)</sub> | `3.49`                |
| `13th Gen`              | `Extreme`           | `NUC13RNGi5`       | `i5-13600K`                  | `6 (12T) (P)`<br />`8 (8T) (E)`        | `3.5/5.1 GHz (P)`<br />`2.6/3.9 GHz (E)` | `41.8 GHz`                        | `$1228` <sub>(Intc)</sub> | `3.40`                |
| <hr />                  | <hr />              | <hr />             | <hr />                       | <hr />                                 | <hr />                                   | <hr />                            | <hr />                    | <hr />                |
| `12th Gen`              | `Extreme`           | `NUC12DCMi9`       | `i9-12900`                   | `8 (16T) (P)`<br />`8 (8T) (E)`        | `2.4/5.0 GHz (P)`<br />`1.8/3.8 GHz (E)` | `33.6 GHz`                        | `$1536` <sub>(Intc)</sub> | `2.19`                |
| `12th Gen`              | `Pro`               | `NUC12WSHv7`       | `i7-1270P`                   | `4 (8T) (P)`<br />`8 (8T) (E)`         | `2.2/4.8 GHz (P)`<br />`1.6/3.5 GHz (E)` | `21.6 GHz`                        | `$758` <sub>(Intc)</sub>  | `2.85`&nbsp;&starf;   |
| `12th Gen`              | `Pro`               | `NUC12WSHi7`       | `i7-1260P`                   | `4 (8T) (P)`<br />`8 (8T) (E)`         | `2.1/4.7 GHz (P)`<br />`1.5/3.4 GHz (E)` | `20.4 GHz`                        | `$657` <sub>(Intc)</sub>  | `3.11`&nbsp;&starf;   |
| `12th Gen`              | `Pro`               | `NUC12WSHv5`       | `i5-1250P`                   | `4 (8T) (P)`<br />`8 (8T) (E)`         | `1.7/4.4 GHz (P)`<br />`1.2/3.3 GHz (E)` | `16.4 GHz`                        | `$567` <sub>(Intc)</sub>  | `2.89`&nbsp;&starf;   |
| `12th Gen`              | `Pro`               | `NUC12WSHi5`       | `i5-1240P`                   | `4 (8T) (P)`<br />`8 (8T) (E)`         | `1.7/4.4 GHz (P)`<br />`1.2/3.3 GHz (E)` | `16.4 GHz`                        | `$498` <sub>(Intc)</sub>  | `3.29`&nbsp;&starf;   |
| `12th Gen`              | `Pro`               | `NUC12WSHi3`       | `i5-1220P`                   | `2 (4T) (P)`<br />`8 (8T) (E)`         | `1.5/4.4 GHz (P)`<br />`1.1/3.3 GHz (E)` | `11.8 GHz`                        | `$365` <sub>(Intc)</sub>  | `3.23`&nbsp;&starf;   |
| <hr />                  | <hr />              | <hr />             | <hr />                       | <hr />                                 | <hr />                                   | <hr />                            | <hr />                    | <hr />                |
| `11th Gen`              | `Extreme`           | `NUC11BTMi9`       | `i9-11900KB`                 | `8 (16T)`                              | `3.3/4.9 GHz`                            | `26.4 GHz`                        | `$1191` <sub>(Intc)</sub> | `2.22`                |
| `11th Gen`              | `Extreme`           | `NUC11BTMi7`       | `i7-11700B`                  | `8 (16T)`                              | `3.2/4.8 GHz`                            | `25.6 GHz`                        | `$1014` <sub>(Intc)</sub> | `2.52`                |
| `11th Gen`              | `Pro`               | `NUC11TNHv7`       | `i7-1185G7`                  | `4 (8T)`                               | `3.0/4.8 GHz`                            | `12.0 GHz`                        | `$693` <sub>(Intc)</sub>  | `1.73`                |
| `11th Gen`              | `Enthusiast`        | `NUC11PHKi7C`      | `i7-1165G7`                  | `4 (8T)`                               | `2.8/4.7 GHz`                            | `11.2 GHz`                        | `$760` <sub>(Amzn)</sub>  | `1.47`                |
| `11th Gen`              | `Performance`       | `NUC11PAHi7`       | `i7-1165G7`                  | `4 (8T)`                               | `2.8/4.7 GHz`                            | `11.2 GHz`                        | `$556` <sub>(Amzn)</sub>  | `2.01`                |
| `11th Gen`              | `Pro`               | `NUC11TNHi7`       | `i7-1165G7`                  | `4 (8T)`                               | `2.8/4.7 GHz`                            | `11.2 GHz`                        | `$717` <sub>(Amzn)</sub>  | `1.56`                |
| `11th Gen`              | `Pro`               | `NUC11TNHv5`       | `i5-1145G7`                  | `4 (8T)`                               | `2.6/4.4 GHz`                            | `10.4 GHz`                        | `$520` <sub>(Intc)</sub>  | `2.00`                |
| `11th Gen`              | `Performance`       | `NUC11PAHi5`       | `i5-1135G7`                  | `4 (8T)`                               | `2.4/4.2 GHz`                            | `9.6 GHz`                         | `$451` <sub>(Amzn)</sub>  | `2.13`                |
| `11th Gen`              | `Pro`               | `NUC11TNHi5`       | `i5-1135G7`                  | `4 (8T)`                               | `2.4/4.2 GHz`                            | `9.6 GHz`                         | `$467` <sub>(Intc)</sub>  | `2.06`                |
| <hr />                  | <hr />              | <hr />             | <hr />                       | <hr />                                 | <hr />                                   | <hr />                            | <hr />                    | <hr />                |
| `10th Gen`              | `Performance`       | `NUC10i7FNH`       | `i7-10710U`                  | `6 (12T)`                              | `1.1/4.7 GHz`                            | `6.6 GHz`                         | `$602` <sub>(Intc)</sub>  | `1.10`                |
| `10th Gen`              | `Performance`       | `NUC10i5FNH`       | `i5-10210U`                  | `4 (8T)`                               | `1.6/4.2 GHz`                            | `5.6 GHz`                         | `$428` <sub>(Intc)</sub>  | `1.31`                |
| `10th Gen`              | `Performance`       | `NUC10i3FNH`       | `i3-10110U`                  | `2 (4T)`                               | `2.1/4.1 GHz`                            | `4.2 GHz`                         | `$324` <sub>(Intc)</sub>  | `1.30`                |
| <hr />                  | <hr />              | <hr />             | <hr />                       | <hr />                                 | <hr />                                   | <hr />                            | <hr />                    | <hr />                |
| `9th Gen`               | `Extreme`           | `NUC9i9QNX`        | `i9-9980HK`                  | `8 (16T)`                              | `2.4/5.0 GHz`                            | `19.2 GHz`                        | `$1068` <sub>(Intc)</sub> | `1.80`                |
| `9th Gen`               | `Pro`               | `NUC9VXQNX`        | `E-2286M` <sub>(Xeon)</sub>  | `8 (16T)`                              | `2.4/5.0 GHz`                            | `19.2 GHz`                        | `$1564` <sub>(Intc)</sub> | `1.23`                |
| `9th Gen`               | `Pro`               | `NUC9V7QNX`        | `i7-9850H`                   | `6 (12T)`                              | `2.6/4.6 GHz`                            | `15.6 GHz`                        | `$1256` <sub>(Intc)</sub> | `1.24`                |
| `9th Gen`               | `Extreme`           | `NUC9i7QNX`        | `i7-9750H`                   | `6 (12T)`                              | `2.6/4.5 GHz`                            | `15.6 GHz`                        | `$768` <sub>(Intc)</sub>  | `2.03`                |
| `9th Gen`               | `Extreme`           | `NUC9i5QNX`        | `i5-9300H`                   | `4 (8T)`                               | `2.4/4.1 GHz`                            | `9.6 GHz`                         | `$608` <sub>(Intc)</sub>  | `1.58`                |
| <hr />                  | <hr />              | <hr />             | <hr />                       | <hr />                                 | <hr />                                   | <hr />                            | <hr />                    | <hr />                |
| `8th Gen`               | `(None)`            | `NUC8i7HVK`        | `i7-8809G`                   | `4 (8T)`                               | `3.1/4.2 GHz`                            | `12.4 GHz`                        | `$902` <sub>(Intc)</sub>  | `1.37`                |
| `8th Gen`               | `(None)`            | `NUC8i7HNK`        | `i7-8705G`                   | `4 (8T)`                               | `3.1/4.1 GHz`                            | `12.4 GHz`                        | `$739` <sub>(Intc)</sub>  | `1.68`                |
| `8th Gen`               | `Pro`               | `NUC8v7PNH`        | `i7-8665U`                   | `4 (8T)`                               | `1.9/4.8 GHz`                            | `7.6 GHz`                         | `$659` <sub>(Intc)</sub>  | `1.15`                |
| `8th Gen`               | `(None)`            | `NUC8i7BEH`        | `i7-8559U`                   | `4 (8T)`                               | `2.7/4.5 GHz`                            | `10.8 GHz`                        | `$564` <sub>(Amzn)</sub>  | `1.91`                |
| `8th Gen`               | `Pro`               | `NUC8v5PNH`        | `i5-8365U`                   | `4 (8T)`                               | `1.6/4.1 GHz`                            | `6.4 GHz`                         | `$487` <sub>(Intc)</sub>  | `1.31`                |
| `8th Gen`               | `(None)`            | `NUC8i5BEH`        | `i5-8259U`                   | `4 (8T)`                               | `2.3/3.8 GHz`                            | `9.2 GHz`                         | `$416` <sub>(Intc)</sub>  | `2.21`                |
| `8th Gen`               | `Pro`               | `NUC8i3PNH`        | `i3-8145U`                   | `2 (4T)`                               | `2.1/3.9 GHz`                            | `4.2 GHz`                         | `$325` <sub>(Intc)</sub>  | `1.29`                |
| `8th Gen`               | `(None)`            | `NUC8i3BEH`        | `i3-8109U`                   | `2 (4T)`                               | `3.0/3.6 GHz`                            | `6.0 GHz`                         | `$317` <sub>(Intc)</sub>  | `1.89`                |
| <hr />                  | <hr />              | <hr />             | <hr />                       | <hr />                                 | <hr />                                   | <hr />                            | <hr />                    | <hr />                |
| `7th Gen`               | `(None)`            | `NUC7i7DNHE`       | `i7-8650U`                   | `4 (8T)`                               | `1.9/4.2 GHz`                            | `7.6 GHz`                         | `$694` <sub>(eBay)</sub>  | `1.10`                |
| `7th Gen`               | `(None)`            | `NUC7i7BNH`        | `i7-7567U`                   | `2 (4T)`                               | `3.5/4.0 GHz`                            | `7.0 GHz`                         | `$247` <sub>(eBay)</sub>  | `2.83`                |
| `7th Gen`               | `(None)`            | `NUC7i5DNHE`       | `i5-7300U`                   | `2 (4T)`                               | `2.6/3.5 GHz`                            | `5.2 GHz`                         | `$409` <sub>(Intc)</sub>  | `1.27`                |
| `7th Gen`               | `(None)`            | `NUC7i5BNH`        | `i5-7260U`                   | `2 (4T)`                               | `2.2/3.4 GHz`                            | `4.4 GHz`                         | `$320` <sub>(eBay)</sub>  | `1.38`                |
| `7th Gen`               | `(None)`            | `NUC7i3DNHE`       | `i3-7100U`                   | `2 (4T)`                               | `2.4 GHz` <sub>(No Turbo)</sub>          | `4.8 GHz`                         | `$258` <sub>(Intc)</sub>  | `1.86`                |
| `7th Gen`               | `(None)`            | `NUC7i3BNH`        | `i3-7100U`                   | `2 (4T)`                               | `2.4 GHz` <sub>(No Turbo)</sub>          | `4.8 GHz`                         | `$332` <sub>(Amzn)</sub>  | `1.45`                |
| <hr />                  | <hr />              | <hr />             | <hr />                       | <hr />                                 | <hr />                                   | <hr />                            | <hr />                    | <hr />                |
| `6th Gen`               | `(None)`            | `NUC6i7KYK`        | `i7-6770HQ`                  | `4 (8T)`                               | `2.6/3.5 GHz`                            | `10.4 GHz`                        | `$378` <sub>(Amzn)</sub>  | `2.75`                |
| `6th Gen`               | `(None)`            | `NUC6i5SYH`        | `i5-6260U`                   | `2 (4T)`                               | `1.8/2.9 GHz`                            | `3.6 GHz`                         | `$349` <sub>(Amzn)</sub>  | `1.03`                |
| `6th Gen`               | `(None)`            | `NUC6i3SYH`        | `i3-6100U`                   | `2 (4T)`                               | `2.3 GHz` <sub>(No Turbo)</sub>          | `4.6 GHz`                         | `$255` <sub>(Amzn)</sub>  | `1.80`                |
| <hr />                  | <hr />              | <hr />             | <hr />                       | <hr />                                 | <hr />                                   | <hr />                            | <hr />                    | <hr />                |
| `5th Gen`               | `(None)`            | `NUC5i7RYH`        | `i7-5557U`                   | `2 (4T)`                               | `3.1/3.4 GHz`                            | `6.2 GHz`                         | `$115` <sub>(eBay)</sub>  | `5.39`&nbsp;&starf;   |
| `5th Gen`               | `(None)`            | `NUC5i5MYHE`       | `i5-5300U`                   | `2 (4T)`                               | `2.3/2.9 GHz`                            | `4.6 GHz`                         | `$145` <sub>(eBay)</sub>  | `3.17`                |
| `5th Gen`               | `(None)`            | `NUC5i5RYH`        | `i5-5250U`                   | `2 (4T)`                               | `1.6/2.7 GHz`                            | `3.2 GHz`                         | `$123` <sub>(eBay)</sub>  | `2.60`                |
| `5th Gen`               | `(None)`            | `NUC5i3RYH`        | `i3-5010U`                   | `2 (4T)`                               | `2.1 GHz` <sub>(No Turbo)</sub>          | `4.2 GHz`                         | `$79`  <sub>(eBay)</sub>  | `5.32`                |
| <hr />                  | <hr />              | <hr />             | <hr />                       | <hr />                                 | <hr />                                   | <hr />                            | <hr />                    | <hr />                |

<hr />

## VMware ESXi on 12th Gen Intel NUCs
- VMware ESXI `8.0`
  - No additional action(s) are required for ESXi to run
- VMware ESXI `7.0` (requires `7.0U2 (Update 2)` or higher)
  - (Step 1/2) Add support for `Intel I225-LM 2.5GbE` networking adapter
    - Add `.vib` driver to ESXi install: [Community Networking Driver for ESXi](https://flings.vmware.com/community-networking-driver-for-esxi)
  - (Step 2/2) Add support for Intel CPUs with non-uniform (performance/efficiency) cores
    - ESXi `7.0 Update 2` or higher is required for kernal parameter `cpuUniformityHardCheckPanic` to be available
      - Set `cpuUniformityHardCheckPanic` to `FALSE` to disable E-cores (avoids `Fatal CPU mismatch` error(s))
        - During ESXi bootup via `Shift + O` option (temporary, use for ESXi installation):
          `runweasel cdromBoot cpuUniformityHardCheckPanic=FALSE`
        - While ESXi is running (permanent, use once ESXi has been installed):
          `esxcli system settings kernel set -s cpuUniformityHardCheckPanic -v FALSE`

<hr />

- ## VMware ESXi - Calculating CPU Capacity
  - CPU capacity is calculated by ESXi using the following formula:
    `Capacity = Core_Count * Base_Clock`
    - Two important things to note:
      &#49;. Formula ignores `HyperThreading` by using CPU `Core_Count` and not CPU `Thread_Count`
      &#50;. Formula ignores `Turbo Boost` by using CPU `Base_Clock` and not CPU `Max_Clock`

<hr />

- ## NUC Naming Schema
  - ### Intel NUC Generations 11 and higher
    - Schema: `NUC` + `[NUC_GEN]` + `[NUC_FAMILY_CODE]` + `[FORM_FACTOR_CODE]` + `[CPU_GEN]`
      - Example: `NUC12WSHi5`
      - Reference: [Product Code Naming Convention for Intel® NUC (Gen 11+)](https://www.intel.com/content/www/us/en/support/articles/000060119/intel-nuc.html)
  - ### Intel NUC Generations 10 and lower
    - Schema: `NUC` + `[NUC_GEN]` + `[CPU_GEN]` + `[NUC_FAMILY_CODE]` + `[FORM_FACTOR_CODE]`
      - Reference: [Product Code Naming Convention for Intel® NUC (Up to Gen 10)](https://www.intel.com/content/www/us/en/support/articles/000031273/intel-nuc.html)
      - Example: `NUC5i7RYH`

<hr />

## Citation(s)

  - [11th Gen Intel NUC - Which is the best candidate to run ESXi? | www.virten.net](https://www.virten.net/2021/01/11th-gen-intel-nuc-announced-which-is-the-best-candidate-to-run-esxi)

  - [ESXi 7 and 8 Installation fails with "Fatal CPU mismatch on feature" | www.virten.net](https://www.virten.net/2022/11/esxi-7-and-8-installation-fails-with-fatal-cpu-mismatch-on-feature)

  - [ESXi on 12th Gen Intel NUC Pro (Wall Street Canyon) | www.virten.net](https://www.virten.net/2022/12/esxi-on-12th-gen-intel-nuc-pro-wall-street-canyon)

  - [Intel Core i5 1240P: performance and specs | nanoreview.net](https://nanoreview.net/en/cpu/intel-core-i5-1240p)

  - [Intel NUC Kits Product Specifications | ark.intel.com](https://ark.intel.com/content/www/us/en/ark/products/series/70407/intel-nuc-kits.html#@nofilter)

  - [Intel NUC Model Lineup (VMware ESXi in homelabs) | www.virten.net](https://www.virten.net/vmware/homelab/intel-nuc-model-lineup)

  - [Kit Differences - NUC11TN (Pro) vs. NUC11PA (Performance) | www.reddit.com](https://www.reddit.com/r/intelnuc/comments/njyydd/difference_between_these_2_nucs)

  - [vSphere CPU Capacity calculation - VMware Technology Network VMTN | communities.vmware.com](https://communities.vmware.com/t5/vSphere-Hypervisor-Discussions/vSphere-CPU-Capacity-calculation/m-p/2858931/highlight/true#M6695)

<hr />
