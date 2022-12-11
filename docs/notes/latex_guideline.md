# 前言

之前本科时跟学长协作论文在[Overleaf](https://www.overleaf.com/)平台上接触过LaTeX，没有系统地进行学习，遇到啥想要实现的功能就搜索，从blog或者StackOverflow上copy下来下来试试，非常凌乱，也搞不懂xelatex、pdflatex等编译选项的区别。Overleaf虽然无需配置环境、直接上手、适合多人协作，但是提交服务器在线编译、在浏览器中呈现的效率低，补全功能稀碎。恰好课程作业推荐使用LaTeX书写，综上考虑，我决定配置LaTeX的本地环境，并将常用功能整理成个人所用模板。

# 概念学习

以下两篇文章对LaTeX相关的常见概念进行了介绍，推荐阅读。

[LaTeX引擎、格式、宏包、发行版大梳理 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/181557253)

[TeX 引擎、格式、发行版之介绍 | 始终 (liam.page)](https://liam.page/2018/11/26/introduction-to-TeX-engine-format-and-distribution/)

# 发行版选择

下面这篇文账对LaTeX发行版和系统环境的选型进行了分析。我个人的文本资料都放在Windows的磁盘中，尤其是用于同步的OneDrive，虽然可以挂载到WSL2中但这样效率最低，因此最终的LaTeX环境选择在Windows上安装MiKTeX。

[LaTeX配置安装大对比：TeXLive/MiKTeX、Windows/WSL、xelatex/lualatex/pdflatex编译器的速度性能详细对比 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/374491983)

# 环境配置

## 基础配置

- 操作系统：Windows
- LaTeX发行版：MiKTeX
- LaTeX引擎：xelatex为主，可以胜任中文和西文环境。
- 编辑工具：VS Code+LaTeX Workshop插件

配置过程可以参考这篇文章。

[使用VSCode编写LaTeX - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/38178015)

## formater配置

下载latexindet，[官网链接](https://ctan.org/tex-archive/support/latexindent)
解压至本地后，在LaTeX Workshop插件中配置latexindet可执行文件的路径。

```json
"latex-workshop.latexindent.path": "D:\\Software\\Tools\\latexindent\\latexindent.exe",
```

## 配置文件一览

我的settings.json如下所示，测试后没有问题。

```json
"latex-workshop.latex.tools": [
  {
    // 编译工具和命令
    "name": "xelatex",
    "command": "xelatex",
    "args": [
      "-synctex=1",
      "-interaction=nonstopmode",
      "-file-line-error",
      // "-pdf",
      "%DOCFILE%"
    ]
  },
  {
    "name": "pdflatex",
    "command": "pdflatex",
    "args": [
      "-synctex=1",
      "-interaction=nonstopmode",
      "-file-line-error",
      "%DOCFILE%"
    ]
  },
  {
    "name": "bibtex",
    "command": "bibtex",
    "args": [
      "%DOCFILE%"
    ]
  }
],
"latex-workshop.latex.recipes": [
  {
    "name": "xelatex",
    "tools": [
      "xelatex"
    ],
  },
  {
    "name": "pdflatex",
    "tools": [
      "pdflatex"
    ]
  },
  {
    "name": "xe->bib->xe->xe",
    "tools": [
      "xelatex",
      "bibtex",
      "xelatex",
      "xelatex"
    ]
  },
  {
    "name": "pdf->bib->pdf->pdf",
    "tools": [
      "pdflatex",
      "bibtex",
      "pdflatex",
      "pdflatex"
    ]
  }
],
"latex-workshop.latex.clean.fileTypes": [
  "*.aux",
  "*.bbl",
  "*.blg",
  "*.idx",
  "*.ind",
  "*.lof",
  "*.lot",
  "*.out",
  "*.toc",
  "*.acn",
  "*.acr",
  "*.alg",
  "*.glg",
  "*.glo",
  "*.gls",
  "*.fls",
  "*.log",
  "*.fdb_latexmk",
  "*.snm",
  "*.synctex(busy)",
  "*.synctex.gz(busy)",
  "*.nav",
  "*.vrb",
  "*.synctex.gz"
],
// latex格式化配置
"latex-workshop.latexindent.path": "D:\\Software\\Tools\\latexindent\\latexindent.exe",
```

# 模板

tex文件直接下载：[template.tex](notes/latex_guideline.assets/template.tex ':include')

OneDrive链接：[https://1drv.ms/u/s!AkOnT6hYJeUyhmd2aHMDQ64U3C-m?e=qSePjX](https://1drv.ms/u/s!AkOnT6hYJeUyhmd2aHMDQ64U3C-m?e=qSePjX)

用于计算机专业作业。参考自以下文章

[https://liam.page/2014/09/08/latex-introduction/](https://liam.page/2014/09/08/latex-introduction/)

[https://zhuanlan.zhihu.com/p/266241159](https://zhuanlan.zhihu.com/p/266241159)

# For More

Overleaf教程：[https://www.overleaf.com/learn](https://www.overleaf.com/learn)
