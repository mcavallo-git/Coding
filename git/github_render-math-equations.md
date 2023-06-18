<!-- ------------------------------------------------------------ -->
<!-- https://github.com/mcavallo-git/Coding/blob/main/git/github_render-math-equations.md -->
<!-- ------------------------------------------------------------ -->

# GitHub Renderer - Math Equations
  > Renders/Displays mathematical equations as an SVG image

<!-- ------------------------------ -->


- <img style="height:50px;margin:10px;background:white;padding:20px;"  src="https://render.githubusercontent.com/render/math?math=x%2by">
- <img style="height:50px;margin:10px;background:black;padding:20px;"  src="https://render.githubusercontent.com/render/math?math={\color{white}x-y}">
- <img style="height:50px;margin:10px;background:black;padding:20px;"  src="https://render.githubusercontent.com/render/math?math={\color{white}x+y}">
- <img style="height:50px;margin:10px;background:black;padding:20px;"  src="https://render.githubusercontent.com/render/math?math={\color{white}x%2dy}">
- <img style="height:50px;margin:10px;background:black;padding:20px;"  src="https://render.githubusercontent.com/render/math?math={\color{white}x%2by}">
- <img style="height:50px;margin:10px;background:black;padding:20px;"  src="https://render.githubusercontent.com/render/math?math={\color{white} x = y}">


<img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math={\color{white}\P(A|B)=\frac{\P(B|A)\P(A)}{\P(B|A)\P(A)\%2BP(B|\neg%20A)\P(\neg%20A)}}#gh-dark-mode-only">

<img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math={\color{white}\P(A|B)=\frac{\P(B|A)\P(A)}{\P(B|A)\P(A)\%2BP(B|\neg%20A)\P(\neg%20A)}}#gh-dark-mode-only">


<!--
math={
\color{white}
\P(A|B)=
\frac{\P(B|A)\P(A)}
{\P(B|A)\P(A)\%2BP(B|\neg%20A)\P(\neg%20A)}
}
-->


<!-- ------------------------------ -->

***
- ## General Syntax
  - HTML:<br />```<img src="https://render.githubusercontent.com/render/math?math={_____}">```&nbsp;&nbsp;&nbsp;*(replacing the `_____` in the URL with the math equation to be rendered)*
  

<!-- ------------------------------ -->

***
- ## Example 1 <sup><a href="https://github.com/mcavallo-git/Coding/search?q=schrader">Citation</a></sup>

  - HTML:<br />```<img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math={\color{white}\frac{12}{0.3937}%20\frac{threads}{inch}=30.48%20\frac{threads}{inch}}">```

  - Output:<br /><img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math={\color{white}\frac{12}{0.3937}%20\frac{threads}{inch}=30.48%20\frac{threads}{inch}}">

<!-- ------------------------------ -->

***
- ## Example 2 <sup><a href="https://tex.stackexchange.com/q/566327">Citation</a></sup>

  - HTML:<br />```<img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math=\color{white}\begin{equation}\sum_{n=0}^\infty\frac{1}{2^n}\end{equation}">```

  - Output:<br /><img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math=\color{white}\begin{equation}\sum_{n=0}^\infty\frac{1}{2^n}\end{equation}">

<!-- ------------------------------ -->

***
- ## Example 3 <sup><a href="https://gist.github.com/a-rodin/fef3f543412d6e1ec5b6cf55bf197d7b?permalink_comment_id=4051474#gistcomment-4051474">Citation</a></sup>

  - HTML:<br />```<img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math={\color{white}\L%20=%20-\sum_{j}[T_{j}ln(O_{j})]%20+%20\frac{\lambda%20W_{ij}^{2}}{2}%20\rightarrow%20\text{one-hot}%20\rightarrow%20-ln(O_{c})%20+%20\frac{\lambda%20W_{ij}^{2}}{2}}">```

  - Output:<br /><img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math={\color{white}\L%20=%20-\sum_{j}[T_{j}ln(O_{j})]%20+%20\frac{\lambda%20W_{ij}^{2}}{2}%20\rightarrow%20\text{one-hot}%20\rightarrow%20-ln(O_{c})%20+%20\frac{\lambda%20W_{ij}^{2}}{2}}">

<!-- ------------------------------ -->

***
- ## Example 4 - Match to `Light`/`Dark` mode <sup><a href="https://gist.github.com/a-rodin/fef3f543412d6e1ec5b6cf55bf197d7b?permalink_comment_id=4117952#gistcomment-4117952">Citation</a></sup>
  - ### Light Mode (`#gh-light-mode-only`)
    - HTML:<br />```<img src="https://render.githubusercontent.com/render/math?math={P(A|B)=\frac{\P(B|A)\P(A)}{\P(B|A)\P(A)\%2BP(B|\neg%20A)\P(\neg%20A)}}##gh-light-mode-only">```
    - Output:<br /><img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math={P(A|B)=\frac{\P(B|A)\P(A)}{\P(B|A)\P(A)\%2BP(B|\neg%20A)\P(\neg%20A)}}##gh-light-mode-only">
    - Output:<br /><img style="height:50px;margin:10px;background:white;padding:20px;" src="https://render.githubusercontent.com/render/math?math={P(A|B)=\frac{\P(B|A)\P(A)}{\P(B|A)\P(A)\%2BP(B|\neg%20A)\P(\neg%20A)}}#">
  - ### Dark Mode (`#gh-dark-mode-only`)
    - HTML:<br />```<img src="https://render.githubusercontent.com/render/math?math={\color{white}\P(A|B)=\frac{\P(B|A)\P(A)}{\P(B|A)\P(A)\%2BP(B|\neg%20A)\P(\neg%20A)}}#gh-dark-mode-only">```
    - Output:<br /><img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math={\color{white}\P(A|B)=\frac{\P(B|A)\P(A)}{\P(B|A)\P(A)\%2BP(B|\neg%20A)\P(\neg%20A)}}#gh-dark-mode-only">

<!-- ------------------------------ -->

***
- ## Example 5 <sup><a href="https://gist.github.com/VictorNS69/1c952045825eac1b5e4d9fc84ad9d384">Citation</a></sup>

  - HTML:<br />```<img style="height:50px;margin:10px" src="https://render.githubusercontent.com/render/math?math=e^{i%20\pi}%20=%20-1">```

  - Output:<br /><img style="height:50px;margin:10px;background:white;padding:20px;" src="https://render.githubusercontent.com/render/math?math=e^{i%20\pi}%20=%20-1">

<!-- ------------------------------ -->

***
- ## Citation(s)

  - [`Writing mathematical expressions - GitHub Docs | docs.github.com`](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/writing-mathematical-expressions)

  - [`A hack for showing LaTeX formulas in GitHub markdown.md · GitHub | gist.github.com`](https://gist.github.com/a-rodin/fef3f543412d6e1ec5b6cf55bf197d7b)

  - [`How to add LaTex formula to a Markdown · GitHub | gist.github.com`](https://gist.github.com/VictorNS69/1c952045825eac1b5e4d9fc84ad9d384)

  - [`Render mathematical expressions in Markdown | GitHub Changelog | github.blog`](https://github.blog/changelog/2022-05-19-render-mathematical-expressions-in-markdown/)

  - [`How to show math equations in general github's markdown(not github's blog) - Stack Overflow | stackoverflow.com`](https://stackoverflow.com/a/73641530)

<!-- ------------------------------ -->

***
