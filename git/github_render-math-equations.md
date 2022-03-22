<!-- ------------------------------------------------------------ -->
<!-- https://github.com/mcavallo-git/Coding/blob/master/git/github_render-math-equations.md -->
<!-- ------------------------------------------------------------ -->

<hr />

# GitHub Math Equation Rendering

<br /><hr />

## General Syntax
- HTML:
```<img src="https://render.githubusercontent.com/render/math?math={_____}">```&nbsp;&nbsp;&nbsp;*(replacing the `_____` in the URL with the math equation to be rendered)*

<br /><hr />

## Example 1

- HTML:
```<img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math={\color{white}\frac{12}{0.3937}%20\frac{threads}{inch}=30.48%20\frac{threads}{inch}}">``` <sup><a href="https://github.com/mcavallo-git/Coding/blob/master/hardware/screw-dimensions-outer-diameter-tpi.schrader-valves-car-tires.presta-valves-bike-tires.md#dimensions">Citation</a></sup>

- Output:
<img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math={\color{white}\frac{12}{0.3937}%20\frac{threads}{inch}=30.48%20\frac{threads}{inch}}">


<br /><hr />

## Example 2

- HTML:
```<img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math=\color{white}\begin{equation}\sum_{n=0}^\infty\frac{1}{2^n}\end{equation}">``` <sup><a href="https://tex.stackexchange.com/q/566327">Citation</a></sup>

- Output:
<img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math=\color{white}\begin{equation}\sum_{n=0}^\infty\frac{1}{2^n}\end{equation}">


<br /><hr />

## Example 3

- HTML:
```<img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math={\color{white}\L = -\sum_{j}[T_{j}ln(O_{j})] + \frac{\lambda W_{ij}^{2}}{2} \rightarrow \text{one-hot} \rightarrow -ln(O_{c}) + \frac{\lambda W_{ij}^{2}}{2}}">``` <sup><a href="https://gist.github.com/a-rodin/fef3f543412d6e1ec5b6cf55bf197d7b?permalink_comment_id=4051474#gistcomment-4051474">Citation</a></sup>

- Output:
<img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math={\color{white}\L = -\sum_{j}[T_{j}ln(O_{j})] + \frac{\lambda W_{ij}^{2}}{2} \rightarrow \text{one-hot} \rightarrow -ln(O_{c}) + \frac{\lambda W_{ij}^{2}}{2}}">


<br /><hr />
