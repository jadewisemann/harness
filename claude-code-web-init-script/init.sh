#!/usr/bin/env bash
# Claude Code 웹 샌드박스 초기 세팅: 플러그인 설치 + 로컬 skill 배치
set -uo pipefail

REPO_URL="https://github.com/jadewisemann/harness"
REPO_SUBDIR="claude-code-web-init-script"

MARKETPLACES=(
  snflkd/fluent-korean
  ayghri/i-have-adhd
  JuliusBrussee/caveman
)
PLUGINS=(
  fluent-korean@fluent-korean
  i-have-adhd@i-have-adhd
  caveman@caveman
)

# 1. 플러그인 (마켓플레이스 등록 → 설치, 이미 있으면 건너뜀)
if command -v claude >/dev/null 2>&1; then
  for m in "${MARKETPLACES[@]}"; do
    claude plugin marketplace add "$m" 2>/dev/null || echo "marketplace 이미 등록됨: $m"
  done
  for p in "${PLUGINS[@]}"; do
    claude plugin install "$p" 2>/dev/null || echo "plugin 설치 실패 또는 이미 설치됨: $p"
  done
else
  echo "경고: claude CLI 없음 — 플러그인 설치 건너뜀" >&2
fi

# 2. 로컬 skill 배치 (curl | bash 실행이면 레포를 임시로 클론)
SRC="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd)"
if [ ! -d "$SRC/skills" ]; then
  TMP="$(mktemp -d)"
  git clone -q --depth 1 "$REPO_URL" "$TMP"
  SRC="$TMP/$REPO_SUBDIR"
fi
mkdir -p "$HOME/.claude/skills"
cp -r "$SRC/skills/." "$HOME/.claude/skills/"

echo "완료: 플러그인 ${#PLUGINS[@]}개 + skills/ 배치"
