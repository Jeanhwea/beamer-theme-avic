# beamer-theme-avic

AVIC 风格的 beamer 主题，蓝 / 红两套配色由同一个宏包的选项切换。封面、章节页、结束页自动生成，正文只写内容。

需要 XeLaTeX。字体用 Microsoft YaHei / Arial / Courier New，缺失时自动回退到 PingFang SC、Helvetica、Menlo。宏包只加载 graphicx、fontspec、xeCJK、tikz，amsmath、booktabs 等内容宏包由文档自行加载。

## 使用

`TEXINPUTS` 指向 `avic/`，或把该目录放进 TeX 搜索路径。

```tex
\documentclass[aspectratio=169]{beamer}
\usetheme[color=blue]{Avic}
\title{汇报标题}\author{汇报人}\institute{单位名称}
\begin{document}
\begin{frame}[plain]\titlepage\end{frame}
\section{第一章}
\begin{frame}{页面标题}正文内容\end{frame}
\end{document}
```

```sh
TEXINPUTS=/path/to/avic: latexmk -xelatex demo.tex
```

每个 `\section` 前自动插入章节页，文末自动插入结束页。结束页排在 `\appendix` 之后，不计入 `\inserttotalframenumber`，所以页码总数比 PDF 实际页数少 1。

## 选项

| 选项 | 默认值 | 说明 |
|---|---|---|
| `color` | `blue` | 配色与配套素材，可选 `blue`、`red` |
| `brandcn` | 中国航空制造技术研究院 | 封面右上单位中文名 |
| `branden` | AVIC MANUFACTURING TECHNOLOGY INSTITUTE | 单位英文名，自动缩放至与中文名同宽 |
| `security` | 公开 | 封面左上密级标识，置空则不显示 |
| `agenda` | 汇\\报\\内\\容 | 章节页竖排标题，`\\` 换行 |
| `closing` | 汇报完毕 | 结束页文字 |
| `assets` | 空 | 素材路径前缀，素材不与 `.sty` 同级时使用 |
| `sectionpage` | `true` | 是否每章前自动插入章节页 |
| `closingpage` | `true` | 是否在文末自动插入结束页 |
| `cjkdate` | `true` | 默认日期是否用 `2026年8月2日` 格式 |

```tex
\usetheme[color=red, security={}, closing={谢谢观看}, sectionpage=false]{Avic}
```

## 公开宏

| 宏 | 用途 |
|---|---|
| `\avicclosing[文字]` | 手动插入结束页，配合 `closingpage=false` |
| `\avicagendadecor{竖排标题}` | 章节页装饰底板，可用于自定义过渡页 |
| `\avictoday` | 中文日期 |
| `\aviccoverbg` `\avicwatermark` `\avicframelogo` `\avicwhitelogo` | 当前配色的素材路径，正文可直接 `\includegraphics` |
| `\avicthemepath` | 素材路径前缀，等价于 `assets`，须在 `\usetheme` 之前定义 |

## 新增配色

加一个调色板宏和一套同名后缀的素材（`thm-cover-bg-green.png` 等），宏包主体不用改。宏名含 `@`，须在 `\usetheme` 之前定义；传入未定义的配色会报 `Unknown color variant`。

```tex
\makeatletter
\newcommand{\avic@palette@green}{\colorlet{themecolor}{green!60!black}}
\makeatother
\usetheme[color=green]{Avic}
```

## 目录与测试

```
avic/    主题宏包与素材，thm-*-{blue,red}.* 分配色，白色徽标双色共用
tests/   测试文档，content.tex 为两个配色共用的内容
dist/    编译产物（git 忽略）
```

`make -C tests` 支持 `all`、`blue`、`red`、`open`、`clean`、`distclean`。`content.tex` 覆盖封面、章节页、标题带、页码、结束页，以及列表、表格、TikZ、图片、公式、图标、区块、双栏、超长标题。验证时除了看 PDF，还要确认 `dist/*.log` 里的 `Missing character` 与字体告警为 0。
