# beamer-theme-avic

AVIC 风格的 beamer 主题。封面、章节页、结束页自动生成，正文只写内容。蓝 / 红两套配色、两种内页标题带样式，都由 `\usetheme` 的选项切换。

需要 **XeLaTeX**（依赖 fontspec / xeCJK）。字体用 Microsoft YaHei / Arial / Courier New，缺失时自动回退到 PingFang SC、Helvetica、Menlo。

## 安装

把 `avic/` 目录（`beamerthemeAvic.sty` 与 `thm-*` 素材）放到文档能找到的地方，二选一：

- 和 `.tex` 放在同一目录，直接可用；
- 或编译时用 `TEXINPUTS` 指向该目录，末尾的分隔符不能省，否则 kpathsea 不再搜索默认路径。

```sh
# Linux / macOS
TEXINPUTS=/path/to/avic: latexmk -xelatex demo.tex
```

```bat
:: Windows（分隔符是分号）
set TEXINPUTS=D:\path\to\avic;
latexmk -xelatex demo.tex
```

素材不与 `.sty` 同级时，用 `assets` 选项给出前缀，例如 `assets={figs/avic/}`。

## 最简用法

```tex
\documentclass[aspectratio=169]{beamer}
\usetheme[color=blue]{Avic}

\title{汇报标题}
\author{汇报人}
\institute{单位名称}

\begin{document}
\begin{frame}[plain]\titlepage\end{frame}

\section{第一章}
\begin{frame}{页面标题}
  正文内容
\end{frame}
\end{document}
```

- 每个 `\section` 前自动插入章节页，目录中高亮当前章；
- 文末自动插入结束页；
- 日期默认写成 `2026年8月2日`，也可以自己 `\date{...}` 覆盖；
- 结束页排在 `\appendix` 之后，不计入 `\inserttotalframenumber`，所以页码里的总数比 PDF 实际页数少 1；
- 主题只加载渲染自身所需的宏包，`amsmath`、`booktabs` 等按需自己 `\usepackage`。

## 选项

| 选项 | 默认值 | 说明 |
|---|---|---|
| `color` | `blue` | 配色与配套素材，可选 `blue`、`red` |
| `header` | `gradient` | 内页标题带样式。`gradient` 深色渐变横幅 + 白色渐隐收边线、白色页底；`plain` 白色标题带 + 主题色通栏细线、浅灰页底 |
| `brandcn` | 中国航空制造技术研究院 | 封面右上单位中文名 |
| `branden` | AVIC MANUFACTURING TECHNOLOGY INSTITUTE | 单位英文名，自动缩放至与中文名同宽 |
| `security` | 公开 | 封面左上密级标识，置空则不显示 |
| `agenda` | 汇\\报\\内\\容 | 章节页竖排标题，`\\` 换行 |
| `closing` | 汇报完毕 | 结束页文字 |
| `assets` | 空 | 素材路径前缀 |
| `sectionpage` | `true` | 是否每章前自动插入章节页 |
| `closingpage` | `true` | 是否在文末自动插入结束页 |
| `cjkdate` | `true` | 默认日期是否用中文格式 |

```tex
\usetheme[color=red, header=plain, security={},
          closing={谢谢观看}, sectionpage=false]{Avic}
```

## 正文里能用的宏和颜色

| 名称 | 用途 |
|---|---|
| `\avicclosing[文字]` | 手动插入结束页，配合 `closingpage=false` 使用 |
| `\avicagendadecor{竖排标题}` | 章节页的装饰底板，可用来做自定义过渡页 |
| `\avictoday` | 中文日期 |
| `\aviccoverbg` `\avicheaderbg` `\avicwatermark` `\avicframelogo` `\avicwhitelogo` | 当前配色的素材路径，可直接 `\includegraphics` |
| `themecolor` | 当前配色名，可用于 `\textcolor`、TikZ、表格底色 |

## 看效果

`tests/` 下有四个演示文档，覆盖两种配色 × 两种标题带样式：

```sh
make -C tests          # 全部编译到 dist/
make -C tests red-gradient
make -C tests clean
```
