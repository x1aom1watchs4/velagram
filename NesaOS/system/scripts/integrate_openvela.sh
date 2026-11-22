#!/usr/bin/env bash
set -euo pipefail

# Integrate the NesaOS Home native demo into an existing openvela checkout.
# Run this from the openvela workspace root; pass the path to the NesaOS
# system/apps/nesaos_home directory as the only argument.

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 /path/to/velagram/NesaOS/system/apps/nesaos_home" >&2
  exit 2
fi

SRC_DIR="$(cd "$1" && pwd)"
WORKSPACE="$PWD"
DEMOS_DIR="$WORKSPACE/packages/demos"
PARENT_MAKEDEFS="$DEMOS_DIR/Make.defs"
DEST_DIR="$DEMOS_DIR/nesaos_home"
MARKER="# NesaOS Home integration (managed by NesaOS script)"

for required in build.sh packages/demos/Make.defs; do
  if [[ ! -e "$WORKSPACE/$required" ]]; then
    echo "Error: '$required' not found. Run this script from the openvela workspace root." >&2
    exit 1
  fi
done

for required in Kconfig Makefile Make.defs nesaos_home_main.c README.md; do
  if [[ ! -f "$SRC_DIR/$required" ]]; then
    echo "Error: missing NesaOS Home source file: $SRC_DIR/$required" >&2
    exit 1
  fi
done

if [[ -e "$DEST_DIR" ]]; then
  if diff -qr "$SRC_DIR" "$DEST_DIR" >/dev/null; then
    echo "NesaOS Home files are already present and match the source."
  else
    echo "Error: $DEST_DIR already exists and differs from the source." >&2
    echo "Review it manually; this script will not overwrite existing files." >&2
    exit 1
  fi
else
  cp -a "$SRC_DIR" "$DEST_DIR"
  echo "Copied NesaOS Home to $DEST_DIR"
fi

if grep -Fq "$MARKER" "$PARENT_MAKEDEFS"; then
  echo "Parent Make.defs already contains the NesaOS registration."
elif grep -Eq 'CONFIG_NESAOS_HOME|packages/demos/nesaos_home' "$PARENT_MAKEDEFS"; then
  echo "Error: a possible NesaOS Home registration already exists without this script's marker." >&2
  echo "Inspect $PARENT_MAKEDEFS and merge the registration manually to avoid duplication." >&2
  exit 1
else
  BACKUP="$PARENT_MAKEDEFS.nesaos-backup"
  if [[ -e "$BACKUP" ]]; then
    echo "Error: backup already exists: $BACKUP" >&2
    echo "Inspect the backup and parent Make.defs before proceeding." >&2
    exit 1
  fi

  cp -p "$PARENT_MAKEDEFS" "$BACKUP"
  TMP_FILE="$(mktemp "${PARENT_MAKEDEFS}.XXXXXX")"
  trap 'rm -f "$TMP_FILE"' EXIT

  cat "$PARENT_MAKEDEFS" > "$TMP_FILE"
  printf '\n%s\nifneq ($(CONFIG_NESAOS_HOME),)\nCONFIGURED_APPS += $(APPDIR)/packages/demos/nesaos_home\nendif\n' "$MARKER" >> "$TMP_FILE"
  cat "$TMP_FILE" > "$PARENT_MAKEDEFS"
  rm -f "$TMP_FILE"
  trap - EXIT
  echo "Registered NesaOS Home in $PARENT_MAKEDEFS"
  echo "Original Make.defs backup: $BACKUP"
fi

cat <<'NEXT'

Next steps (not performed automatically):
1. Inspect the actual parent Kconfig structure in this checkout.
2. Add this source line beside the other packages/demos Kconfig entries:
   source "$(APPDIR)/packages/demos/nesaos_home/Kconfig"
3. Open menuconfig, enable NESAOS_HOME, save, then build the selected emulator target.

This script does not change any board configuration, bootloader, device firmware,
or signing settings. NesaOS Home is a native demo component, not a complete OS.
NEXT
