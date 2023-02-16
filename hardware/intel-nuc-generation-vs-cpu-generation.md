# Intel NUC Hardware Comparisons

## NUC Naming Schema
  - ## Up to Gen 10
    - Schema: `NUC` + `[NUC_GEN]` + `[CPU_GEN]` + `[NUC_FAMILY_CODE]` + `[FORM_FACTOR_CODE]`
      - Reference: [Product Code Naming Convention for Intel® NUC (Up to Gen 10)](https://www.intel.com/content/www/us/en/support/articles/000031273/intel-nuc.html)
      - Example: `NUC5i7RYH`
  - ## Gen 11+
    - Schema: `NUC` + `[NUC_GEN]` + `[NUC_FAMILY_CODE]` + `[FORM_FACTOR_CODE]` + `[CPU_GEN]`
      - Example: `NUC12WSHi5`
      - Reference: [Product Code Naming Convention for Intel® NUC (Gen 11+)](https://www.intel.com/content/www/us/en/support/articles/000060119/intel-nuc.html)

## Intel NUC Generation vs CPU Generation
| <h3>NUC Generation</h3>         | <h3>Family (Kit) Type</h3> | <h3>NUC Model</h3> | <h3>CPU Model</h3>      |
| ------------------------------- | -------------------------- | ------------------ | ---------------------------- |
| <hr />                          | <hr />                     | <hr />             | <hr />                       |
| `NUC13` <sub>*(13th Gen)*</sub> | `Extreme`                  | `NUC13RNGi9`       | `i5-13900K`                  |
| `NUC13` <sub>*(13th Gen)*</sub> | `Extreme`                  | `NUC13RNGi7`       | `i5-13700K`                  |
| `NUC13` <sub>*(13th Gen)*</sub> | `Extreme`                  | `NUC13RNGi5`       | `i5-13600K`                  |
| <hr />                          | <hr />                     | <hr />             | <hr />                       |
| `NUC12` <sub>*(12th Gen)*</sub> | `Extreme`                  | `NUC12DCMi9`       | `i9-12900`                   |
| `NUC12` <sub>*(12th Gen)*</sub> | `Pro`                      | `NUC12WSHv7`       | `i7-1270P`                   |
| `NUC12` <sub>*(12th Gen)*</sub> | `Pro`                      | `NUC12WSHi7`       | `i7-1260P`                   |
| `NUC12` <sub>*(12th Gen)*</sub> | `Pro`                      | `NUC12WSHv5`       | `i5-1250P`                   |
| `NUC12` <sub>*(12th Gen)*</sub> | `Pro`                      | `NUC12WSHi5`       | `i5-1240P`                   |
| <hr />                          | <hr />                     | <hr />             | <hr />                       |
| `NUC11` <sub>*(11th Gen)*</sub> | `Extreme`                  | `NUC11BTMi9`       | `i9-11900KB`                 |
| `NUC11` <sub>*(11th Gen)*</sub> | `Pro`                      | `NUC11TNHv7`       | `i7-1185G7`                  |
| `NUC11` <sub>*(11th Gen)*</sub> | `Extreme`                  | `NUC11BTMi7`       | `i7-11700B`                  |
| `NUC11` <sub>*(11th Gen)*</sub> | `Enthusiast`               | `NUC11PHKi7C`      | `i7-1165G7`                  |
| `NUC11` <sub>*(11th Gen)*</sub> | `Performance`              | `NUC11PAHi7`       | `i7-1165G7`                  |
| `NUC11` <sub>*(11th Gen)*</sub> | `Pro`                      | `NUC11TNHi7`       | `i7-1165G7`                  |
| `NUC11` <sub>*(11th Gen)*</sub> | `Pro`                      | `NUC11TNHv5`       | `i5-1145G7`                  |
| `NUC11` <sub>*(11th Gen)*</sub> | `Performance`              | `NUC11PAHi5`       | `i5-1135G7`                  |
| `NUC11` <sub>*(11th Gen)*</sub> | `Pro`                      | `NUC11TNHi5`       | `i5-1135G7`                  |
| <hr />                          | <hr />                     | <hr />             | <hr />                       |
| `NUC10` <sub>*(10th Gen)*</sub> | `Performance`              | `NUC10i7FNH`       | `i7-10710U`                  |
| `NUC10` <sub>*(10th Gen)*</sub> | `Performance`              | `NUC10i5FNH`       | `i5-10210U`                  |
| `NUC10` <sub>*(10th Gen)*</sub> | `Performance`              | `NUC10i3FNH`       | `i3-10110U`                  |
| <hr />                          | <hr />                     | <hr />             | <hr />                       |
| `NUC9` <sub>*(9th Gen)*</sub>   | `Extreme`                  | `NUC9i9QNX`        | `i9-9980HK`                  |
| `NUC9` <sub>*(9th Gen)*</sub>   | `Pro`                      | `NUC9V7QNX`        | `i7-9850H`                   |
| `NUC9` <sub>*(9th Gen)*</sub>   | `Extreme`                  | `NUC9i7QNX`        | `i7-9750H`                   |
| `NUC9` <sub>*(9th Gen)*</sub>   | `Extreme`                  | `NUC9i5QNX`        | `i5-9300H`                   |
| `NUC9` <sub>*(9th Gen)*</sub>   | `Pro`                      | `NUC9VXQNX`        | `E-2286M` <sub>(Xeon)</sub>  |
| <hr />                          | <hr />                     | <hr />             | <hr />                       |
| `NUC8` <sub>*(8th Gen)*</sub>   | `Pro`                      | `NUC8v7PNH`        | `i7-8665U`                   |
| `NUC8` <sub>*(8th Gen)*</sub>   | `(None)`                   | `NUC8i7BEH`        | `i7-8559U`                   |
| `NUC8` <sub>*(8th Gen)*</sub>   | `Pro`                      | `NUC8v5PNH`        | `i5-8365U`                   |
| `NUC8` <sub>*(8th Gen)*</sub>   | `(None)`                   | `NUC8i5BEH`        | `i5-8259U`                   |
| `NUC8` <sub>*(8th Gen)*</sub>   | `Pro`                      | `NUC8i3PNH`        | `i3-8145U`                   |
| `NUC8` <sub>*(8th Gen)*</sub>   | `(None)`                   | `NUC8i3BEH`        | `i3-8109U`                   |
| `NUC8` <sub>*(8th Gen)*</sub>   | `Rugged`                   | `NUC8CCHKR`        | `N3350` <sub>(Celeron)</sub> |
| <hr />                          | <hr />                     | <hr />             | <hr />                       |
| `NUC7` <sub>*(7th Gen)*</sub>   | `(None)`                   | `NUC7i7DNHE`       | `i7-8650U`                   |
| `NUC7` <sub>*(7th Gen)*</sub>   | `(None)`                   | `NUC7i7BNH`        | `i7-7567U`                   |
| `NUC7` <sub>*(7th Gen)*</sub>   | `(None)`                   | `NUC7i5DNHE`       | `i5-7300U`                   |
| `NUC7` <sub>*(7th Gen)*</sub>   | `(None)`                   | `NUC7i5BNH`        | `i5-7260U`                   |
| `NUC7` <sub>*(7th Gen)*</sub>   | `(None)`                   | `NUC7i3DNHE`       | `i3-7100U`                   |
| `NUC7` <sub>*(7th Gen)*</sub>   | `(None)`                   | `NUC7i3BNH`        | `i3-7100U`                   |
| `NUC7` <sub>*(7th Gen)*</sub>   | `(None)`                   | `NUC7PJYHN`        | `J5040` <sub>(Pentium)</sub> |
| `NUC7` <sub>*(7th Gen)*</sub>   | `(None)`                   | `NUC7CJYHN`        | `J4025` <sub>(Celeron)</sub> |
| <hr />                          | <hr />                     | <hr />             | <hr />                       |
| `NUC6` <sub>*(6th Gen)*</sub>   | `____`                     | `NUC6_____`        | `________`                   |
| <hr />                          | <hr />                     | <hr />             | <hr />                       |
| `NUC5` <sub>*(5th Gen)*</sub>   | `____`                     | `NUC5i7RYH`        | `i7-5557U`                   |
| <hr />                          | <hr />                     | <hr />             | <hr />                       |


## Citation(s)
- [Intel NUC Model Lineup | virten.net](https://www.virten.net/vmware/homelab/intel-nuc-model-lineup/)
- [Intel® NUC Kits Product Specifications](https://ark.intel.com/content/www/us/en/ark/products/series/70407/intel-nuc-kits.html#@nofilter)
- [NUC11 Family Code Differences - NUC11TN (`Pro Kit`) vs. NUC11PA (`Performance Kit`)](https://www.reddit.com/r/intelnuc/comments/njyydd/difference_between_these_2_nucs/)
