#!/usr/bin/env bash
# install.sh — install the HPC reference skills into your Claude Code skills dir.
#
# Mechanism: COPY (not symlink). Each skills/<name> is copied into
# ~/.claude/skills/<name>. Re-running overwrites existing copies (idempotent),
# so update with:  git pull && ./install.sh
#
# Usage:
#   ./install.sh              install/refresh all skills
#   ./install.sh -n           dry-run (show what would happen)
#   ./install.sh --uninstall  remove skills that this repo provides
#
# Override the target with CLAUDE_SKILLS_DIR if your skills live elsewhere.

set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
SRC="$REPO/skills"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

MODE=install
case "${1:-}" in
  -n|--dry-run)   DRY=1 ;;
  -D|--uninstall) MODE=uninstall; DRY=0 ;;
  "")             DRY=0 ;;
  -h|--help)
    sed -n '2,14p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
  *) echo "Unknown option: $1 (try --help)" >&2; exit 1 ;;
esac
DRY="${DRY:-0}"

if [[ ! -d "$SRC" ]]; then
  echo "ERROR: skills/ not found in repo ($SRC)" >&2; exit 1
fi
mkdir -p "$DEST"

mapfile -t SKILLS < <(find "$SRC" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)
if [[ ${#SKILLS[@]} -eq 0 ]]; then
  echo "No skills found under $SRC" >&2; exit 1
fi

echo "Skills target: $DEST"
[[ $DRY -eq 1 ]] && echo "(dry-run — no changes)"
echo

for skill in "${SKILLS[@]}"; do
  target="$DEST/$skill"
  if [[ "$MODE" == uninstall ]]; then
    if [[ -e "$target" ]]; then
      [[ $DRY -eq 1 ]] && { echo "  would remove  $skill"; continue; }
      rm -rf "$target"; echo "  removed   $skill"
    else
      echo "  absent    $skill"
    fi
    continue
  fi
  # install / refresh
  if [[ -L "$target" ]]; then
    echo "  WARNING: $target is a symlink (likely managed by your dotfiles/stow)." >&2
    echo "           Skipping to avoid clobbering it. Remove it first to install this copy." >&2
    continue
  fi
  [[ $DRY -eq 1 ]] && { echo "  would copy    $skill"; continue; }
  rm -rf "$target"
  cp -R "$SRC/$skill" "$target"
  echo "  installed $skill"
done

echo
if [[ "$MODE" == uninstall ]]; then
  echo "Uninstall complete."
else
  echo "Install complete. Restart Claude Code (or reload skills) to pick them up."
fi
