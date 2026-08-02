# beamer-theme-avic

## 选项

| 选项 | 默认值 | 说明 |
|---|---|---|
| `color` | `blue` | 配色，可选 `blue`、`red` |
| `header` | `gradient` | 标题带样式，`gradient` 渐变横幅 / `plain` 通栏细线 |
| `brandcn` | 中国航空制造技术研究院 | 封面单位中文名 |
| `security` | 公开 | 封面密级标识，置空不显示 |
| `closing` | 汇报完毕 | 结束页文字 |
| `sectionpage` | `true` | 自动插入章节页 |
| `closingpage` | `true` | 自动插入结束页 |

## 使用示例

```tex
\documentclass[aspectratio=169]{beamer}
\usetheme[color=blue, header=gradient]{Avic}

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
