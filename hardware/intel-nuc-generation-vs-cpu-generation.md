# Intel NUC Generation vs CPU Generation

## NUC Naming Schema
  - ## Up to Gen 10
    - Schema: `NUC` + `[NUC_GEN]` + `[CPU_GEN]` + `[NUC_FAMILY_CODE]` + `[FORM_FACTOR_CODE]`
      - Reference: [Product Code Naming Convention for Intel® NUC (Up to Gen 10)](https://www.intel.com/content/www/us/en/support/articles/000031273/intel-nuc.html)
      - Example: `NUC5i7RYH`
  - ## Gen 11+
    - Schema: `NUC` + `[NUC_GEN]` + `[NUC_FAMILY_CODE]` + `[FORM_FACTOR_CODE]` + `[CPU_GEN]`
      - Example: `NUC12WSHi5`
      - Reference: [Product Code Naming Convention for Intel® NUC (Gen 11+)](https://www.intel.com/content/www/us/en/support/articles/000060119/intel-nuc.html)

| Intel NUC Generation | Intel CPU Generation | NUC Model (Example) | Associated CPU Model (Example) | NUC Family (Kit) Type |
| -------------------- | -------------------- | ------------------- | ------------------------------ | --------------------- |
| <hr />               | <hr />               | <hr />              | <hr />                         | `Extreme`             |
| 13th Gen Intel NUCs  | 13th Gen Intel CPUs  | `NUC13RNGi9`        | `i5-13900K`                    | `Extreme`             |
| 13th Gen Intel NUCs  | 13th Gen Intel CPUs  | `NUC13RNGi7`        | `i5-13700K`                    | `Extreme`             |
| 13th Gen Intel NUCs  | 13th Gen Intel CPUs  | `NUC13RNGi5`        | `i5-13600K`                    |                       |
| <hr />               | <hr />               | <hr />              | <hr />                         |                       |
| 12th Gen Intel NUCs  | 12th Gen Intel CPUs  | `NUC12DCMi9`        | `i9-12900`                     | `Extreme`             |
| 12th Gen Intel NUCs  | 12th Gen Intel CPUs  | `NUC12WSHv7`        | `i7-1270P`                     | `Pro`                 |
| 12th Gen Intel NUCs  | 12th Gen Intel CPUs  | `NUC12WSHi7`        | `i7-1260P`                     | `Pro`                 |
| 12th Gen Intel NUCs  | 12th Gen Intel CPUs  | `NUC12WSHv5`        | `i5-1250P`                     | `Pro`                 |
| 12th Gen Intel NUCs  | 12th Gen Intel CPUs  | `NUC12WSHi5`        | `i5-1240P`                     | `Pro`                 |
| <hr />               | <hr />               | <hr />              | <hr />                         |                       |
| 11th Gen Intel NUCs  | 11th Gen Intel CPUs  | `NUC11BTMi9`        | `i9-11900KB`                   | `Extreme`             |
| 11th Gen Intel NUCs  | 11th Gen Intel CPUs  | `NUC11TNHv7`        | `i7-1185G7`                    | `Pro`                 |
| 11th Gen Intel NUCs  | 11th Gen Intel CPUs  | `NUC11BTMi7`        | `i7-11700B`                    | `Extreme`             |
| 11th Gen Intel NUCs  | 11th Gen Intel CPUs  | `NUC11PHKi7C`       | `i7-1165G7`                    | `Enthusiast`          |
| 11th Gen Intel NUCs  | 11th Gen Intel CPUs  | `NUC11PAHi7`        | `i7-1165G7`                    | `Performance`         |
| 11th Gen Intel NUCs  | 11th Gen Intel CPUs  | `NUC11TNHi7`        | `i7-1165G7`                    | `Pro`                 |
| 11th Gen Intel NUCs  | 11th Gen Intel CPUs  | `NUC11TNHv5`        | `i5-1145G7`                    | `Pro`                 |
| 11th Gen Intel NUCs  | 11th Gen Intel CPUs  | `NUC11PAHi5`        | `i5-1135G7`                    | `Performance`         |
| 11th Gen Intel NUCs  | 11th Gen Intel CPUs  | `NUC11TNHi5`        | `i5-1135G7`                    | `Pro`                 |
| <hr />               | <hr />               | <hr />              | <hr />                         |                       |
| 10th Gen Intel NUCs  | 10th Gen Intel CPUs  | `NUC10i7FNH`        | `i7-10710U`                    | `Performance`         |
| 10th Gen Intel NUCs  | 10th Gen Intel CPUs  | `NUC10i5FNH`        | `i5-10210U`                    | `Performance`         |
| 10th Gen Intel NUCs  | 10th Gen Intel CPUs  | `NUC10i3FNH`        | `i3-10110U`                    | `Performance`         |
| <hr />               | <hr />               | <hr />              | <hr />                         |                       |
| 9th Gen Intel NUCs   | 9th Gen Intel CPUs   | `NUC9i9QNX`         | `i9-9980HK`                    | `Extreme`             |
| 9th Gen Intel NUCs   | 9th Gen Intel CPUs   | `NUC9V7QNX`         | `i7-9850H`                     | `Pro`                 |
| 9th Gen Intel NUCs   | 9th Gen Intel CPUs   | `NUC9i7QNX`         | `i7-9750H`                     | `Extreme`             |
| 9th Gen Intel NUCs   | 9th Gen Intel CPUs   | `NUC9i5QNX`         | `i5-9300H`                     | `Extreme`             |
| 9th Gen Intel NUCs   | 9th Gen Intel CPUs   | `NUC9VXQNX`         | `E-2286M` <sub>(Xeon)</sub>    | `Pro`                 |
| <hr />               | <hr />               | <hr />              | <hr />                         |                       |
| 8th Gen Intel NUCs   | 8th Gen Intel CPUs   | `_________`         | `________`                     |                       |
| <hr />               | <hr />               | <hr />              | <hr />                         |                       |
| 7th Gen Intel NUCs   | 7th Gen Intel CPUs   | `_________`         | `________`                     |                       |
| <hr />               | <hr />               | <hr />              | <hr />                         |                       |
| 6th Gen Intel NUCs   | 6th Gen Intel CPUs   | `_________`         | `________`                     |                       |
| <hr />               | <hr />               | <hr />              | <hr />                         |                       |
| 5th Gen Intel NUCs   | 5th Gen Intel CPUs   | `NUC5i7RYH`         | `i7-5557U`                     |                       |
| <hr />               | <hr />               | <hr />              | <hr />                         |                       |


## Citation(s)

- [Intel® NUC Kits Product Specifications](https://ark.intel.com/content/www/us/en/ark/products/series/70407/intel-nuc-kits.html#@nofilter)
- [NUC11 Family Code Differences - NUC11TN (`Pro Kit`) vs. NUC11PA (`Performance Kit`)](https://www.reddit.com/r/intelnuc/comments/njyydd/difference_between_these_2_nucs/)
