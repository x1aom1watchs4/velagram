#!/usr/bin/env bash
set -Eeuo pipefail

# Prepare and build the upstream openvela ARM64 Goldfish reference target.
# This is NOT a Xiaomi Watch S4 firmware build.

WORKSPACE="${1:-$HOME/work/nesaos-openvela}"
JOBS="${JOBS:-4}"
TARGET="vendor/openvela/boards/vela/configs/goldfish-arm64-v8a-ap/"
LOG_DIR="$WORKSPACE/nesaos-build-logs"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"

die() { echo "ERROR: $*" >&2; exit 1; }
need() { command -v "$1" >/dev/null 2>&1 || die "Missing command: $1"; }

[[ "$JOBS" =~ ^[1-9][0-9]*$ ]] || die "JOBS must be a positive integer."
need repo
need git
need git-lfs
need cmake
need python3
need tee

git lfs install

mkdir -p "$WORKSPACE"
cd "$WORKSPACE"

if [[ ! -f .repo/manifest.xml ]]; then
  if [[ -n "$(find . -mindepth 1 -maxdepth 1 ! -name .repo -print -quit)" ]]; then
    die "$WORKSPACE is not empty and has no repo manifest. Choose a clean workspace."
  fi
  repo init -u https://github.com/open-vela/manifests -b trunk -m openvela.xml --git-lfs
fi

repo sync -c -j"$JOBS"
repo manifest -r -o manifest.lock.xml

[[ -x ./build.sh ]] || die "openvela build.sh is missing or not executable."
[[ -d "$TARGET" ]] || die "Build target not found: $TARGET"

mkdir -p "$LOG_DIR"
echo "Workspace: $WORKSPACE"
echo "Target: $TARGET"
echo "Parallel jobs: $JOBS"
echo "Manifest lock: $WORKSPACE/manifest.lock.xml"
echo "Logs: $LOG_DIR"

set +e
./build.sh "$TARGET" --cmake -j"$JOBS" 2>&1 | tee "$LOG_DIR/build-$STAMP.log"
BUILD_STATUS=${PIPESTATUS[0]}
set -e
printf '%s\n' "$BUILD_STATUS" > "$LOG_DIR/build-$STAMP.exit"
if [[ "$BUILD_STATUS" -ne 0 ]]; then
  die "Build failed with exit code $BUILD_STATUS. See $LOG_DIR/build-$STAMP.log"
fi

OUT="cmake_out/vela_goldfish-arm64-v8a-ap"
[[ -d "$OUT" ]] || die "Build returned success but expected output directory is missing: $OUT"
find "$OUT" -maxdepth 2 -type f -printf '%P\t%s bytes\n' | sort > "$LOG_DIR/artifacts-$STAMP.txt"

echo
echo "Reference build completed. This validates only the upstream ARM64 emulator target."
echo "It does not produce or validate Xiaomi Watch S4 firmware."
echo "To launch the emulator, run:"
echo "  cd \"$WORKSPACE\" && ./emulator.sh \"$OUT\""
