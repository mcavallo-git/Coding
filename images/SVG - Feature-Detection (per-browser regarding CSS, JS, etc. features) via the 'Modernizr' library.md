
# CSS/JS browser-feature-detection using the "Modernizr" library
* Open Modernizr docs:    ```https://modernizr.com/docs```     (Modernizr docs)
* Search for text:  ```Features detected by Modernizr```   (Feature-detection table w/ two columns, "Detect" and "CSS class/JS property")
* Create CSS class-names on a per-feature basis by PRE-pending the string ```no-``` onto the front-of the string in the ```CSS class/JS property``` column

#### Example:
```
<svg width="96px" height="96px" viewBox="0 0 512 512" enable-background="new 0 0 512 512" xml:space="preserve"><path id="time-3-icon" .../></svg>
<image class="my-svg-alternate" width="96" height="96" src="ppngfallback.png" />
```

<!--
  --	Citation(s)
  --
  --		modernizr.com  |  "Modernizr: the feature detection library for HTML5/CSS3"  |  https://modernizr.com/docs
  --
  --		stackoverflow.com  |  "Change svg color"  |  https://stackoverflow.com/a/22253046
  --
  -->