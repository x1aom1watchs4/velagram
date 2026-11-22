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

The public openvela manifest currently contains a Xiaomi vendor project at `vendor/xiaomi/vela/pyxis`. This confirms that Xiaomi Vela vendor code is part of the public source manifest; it does not identify that project as the M2425W1 board or prove that the public source can boot on a retail Watch S4.

The official Xiaomi Vela documentation says real-device debugging is currently supported only on Xiaomi Watch S4 devices, but requires a special OTA version and is open only to specific partners. That is an app-debugging workflow, not a documented replacement-firmware installation path.

## Reproducible upstream checkout

The upstream source workspace is managed by Google's `repo` manifest tool. From a Linux development machine with the official openvela prerequisites installed:

```sh
mkdir -p ~/work/nesaos-openvela
cd ~/work/nesaos-openvela
repo init -u https://github.com/open-vela/manifests -b dev -m openvela.xml
repo sync -c -j4
```

This checks out the upstream openvela source workspace. It does **not** check out a Watch S4 firmware target and does not produce a NesaOS image by itself.

Use the official openvela documentation to select a currently supported emulator/development-board target and follow that target's exact build instructions. The first system milestone is a reproducible upstream system build for a supported reference target, not a Quick App package.

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
