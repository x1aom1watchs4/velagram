# NesaOS system port

This directory is the **operating-system porting workstream**, not an application package.

## Intended architecture

NesaOS is intended to be a product distribution built on openvela/NuttX:

- Kernel and board support: upstream openvela/NuttX.
- Device adaptation: board-specific display, touch, keys, power, storage, sensors, and connectivity.
- System services: graphics, input, power, connectivity, package management, and update services where supported.
- NesaOS product layer: boot experience, home/watch face, widgets, launcher, settings, and system applications.

## Current state

**No NesaOS firmware has been built. No Watch S4 board target has been verified.**

The public openvela manifest contains a Xiaomi vendor project at `vendor/xiaomi/vela/pyxis`. This confirms that Xiaomi Vela vendor code is part of the public source manifest; it does not identify that project as the M2425W1 board or prove that the public source can boot on a retail Watch S4.

The official Xiaomi Vela documentation says real-device debugging is currently supported only on Xiaomi Watch S4 devices, but requires a special OTA version and is open only to specific partners. That is an app-debugging workflow, not a documented replacement-firmware installation path.

## Native NesaOS component

The first native product-layer component is [NesaOS Home](./apps/nesaos_home/README.md). It is written in C and uses openvela's LVGL/NuttX display integration. It draws the first turquoise, light-blue and brown home-screen layout, with tappable demo tiles.

The tiles currently report their intended app target; they do not launch applications yet. The component has not been compiled or run against a pinned openvela checkout. Treat it as initial native source, not a verified binary or complete launcher.

### Integrating NesaOS Home into an openvela checkout

A guarded helper script is available at [scripts/integrate_openvela.sh](./scripts/integrate_openvela.sh). From the root of a prepared openvela workspace, run:

```bash
/path/to/velagram/NesaOS/system/scripts/integrate_openvela.sh \
  /path/to/velagram/NesaOS/system/apps/nesaos_home
```

The script checks that it is running at an openvela workspace root, copies the component without overwriting a different existing directory, backs up `packages/demos/Make.defs`, and adds the conditional app registration once. It deliberately does **not** guess which parent Kconfig file includes the demos: inspect the actual checkout and add the component's Kconfig source line beside the other demos before enabling `NESAOS_HOME` in menuconfig.

The helper has not been executed against a real openvela checkout in this environment. Review its output and the generated diff before building.

## First system milestone: upstream reference build

The immediate build target is the officially documented openvela ARM64 emulator configuration:

`vendor/openvela/boards/vela/configs/goldfish-arm64-v8a-ap/`

Use the stable `trunk` manifest baseline for hardware-porting work, then record exact project revisions with `repo manifest -r`. Do not use the moving `dev` branch as the hardware-porting baseline.

The full host requirements, checkout, build, emulator launch, and acceptance checklist are in [BUILD_BASELINE.md](./BUILD_BASELINE.md).

A successful reference build is a genuine OS build milestone, but it is **not** a Watch S4 firmware image.

## Porting gates for Xiaomi Watch S4 (M2425W1)

A Watch S4 port cannot be called buildable until all of these are established from public or vendor-authorized documentation/source:

1. Exact silicon/board identification and a matching board configuration.
2. Boot ROM / bootloader hand-off contract and image layout.
3. Display and touch controller identification plus drivers.
4. Clock, memory, storage, PMIC, battery, and power-management integration.
5. Bluetooth, sensors, crown/button input, vibration, and other device interfaces.
6. Secure boot, image signing, and a documented recovery/update process.
7. A supported device test path and validation that the resulting image boots.

Unknowns must remain explicit; do not substitute guessed driver names, board identifiers, or firmware offsets.

## Development policy

- Keep the Quick App and browser UI prototypes separate from this OS workstream.
- Do not label a Quick App, emulator skin, or mockup as a system image.
- Do not overwrite device firmware during feasibility research.
- Use official emulator/development-board targets until a vendor-authorized Watch S4 target is available.
- Record build logs, toolchain versions, target configuration, and test results for every claimed successful build.
