#!/bin/sh
# 安装 AVIC beamer 主题到本地 TeX 树（TEXMFHOME），装好后任意文档都能
# 直接 \usetheme{Avic}，无需再设 TEXINPUTS 或与 .tex 同级摆放。
#
# 用法：
#   sh install.sh            安装
#   sh install.sh -u         卸载
#   sh install.sh -f         覆盖时不询问
#
# 把 avic/ 下的 .sty 与 thm-* 素材复制到
#   <TEXMFHOME>/tex/latex/beamer-theme-avic/
# TEXMFHOME 由 kpsewhich 查询，查不到时回退到 ~/texmf。

set -eu

PACKAGE_NAME='beamer-theme-avic'

# 脚本所在目录，用于定位源 avic/（无论从哪里调用都对）
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SOURCE_DIR="$SCRIPT_DIR/avic"

UNINSTALL=0
FORCE=0
for arg in "$@"; do
    case "$arg" in
        -u|--uninstall) UNINSTALL=1 ;;
        -f|--force)     FORCE=1 ;;
        -h|--help)
            sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'
            exit 0 ;;
        *)
            echo "未知参数：$arg" >&2
            exit 2 ;;
    esac
done

# TEXMFHOME：优先问 kpsewhich，回退到 ~/texmf
if command -v kpsewhich >/dev/null 2>&1; then
    TEXMFHOME=$(kpsewhich -var-value=TEXMFHOME 2>/dev/null || true)
fi
if [ -z "${TEXMFHOME:-}" ]; then
    echo "警告：未找到 kpsewhich，回退到 ~/texmf。请确认已安装 TeX 发行版。" >&2
    TEXMFHOME="$HOME/texmf"
fi

TARGET_DIR="$TEXMFHOME/tex/latex/$PACKAGE_NAME"

if [ "$UNINSTALL" -eq 1 ]; then
    if [ -d "$TARGET_DIR" ]; then
        rm -rf "$TARGET_DIR"
        echo "已卸载：$TARGET_DIR"
    else
        echo "未发现安装目录，无需卸载：$TARGET_DIR"
    fi
    exit 0
fi

# --- 安装 ---
[ -d "$SOURCE_DIR" ] || { echo "源目录不存在：$SOURCE_DIR" >&2; exit 1; }

if [ -d "$TARGET_DIR" ] && [ "$FORCE" -eq 0 ]; then
    printf '目标已存在，覆盖？ [%s] (y/N) ' "$TARGET_DIR"
    read -r answer
    case "$answer" in
        [Yy]*) ;;
        *) echo '已取消。'; exit 0 ;;
    esac
fi

mkdir -p "$TARGET_DIR"

# 只复制主题运行所需的 .sty 与素材
copied=0
for f in "$SOURCE_DIR"/*.sty "$SOURCE_DIR"/*.png "$SOURCE_DIR"/*.pdf; do
    [ -e "$f" ] || continue
    cp -f "$f" "$TARGET_DIR/"
    copied=$((copied + 1))
done

echo "已安装 $copied 个文件到：$TARGET_DIR"

# MiKTeX 需要刷新文件名数据库；TeX Live 的 TEXMFHOME 无需 texhash
if command -v initexmf >/dev/null 2>&1; then
    echo '检测到 MiKTeX，正在刷新文件名数据库…'
    initexmf --update-fndb >/dev/null 2>&1 || true
fi

echo ''
echo '完成。现在任意文档都可以：'
echo '    \usetheme[color=blue]{Avic}'
