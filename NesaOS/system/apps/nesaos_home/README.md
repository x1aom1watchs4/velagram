# NesaOS Home — native openvela component

This folder contains the first native NesaOS home-screen component. It uses
openvela's NuttX + LVGL integration and follows the native demo structure used
by upstream openvela examples.

## Current functionality

- Native C application entry point.
- Initializes LVGL through the openvela NuttX display/input adapter.
- Draws a NesaOS home screen with turquoise, light-blue and brown tiles.
- Touching a tile updates the status line to show the intended app target.

## Explicit limitations

- The tiles do not launch applications yet. The status line says
  "integration pending" so the UI does not pretend otherwise.
- Time, battery, Bluetooth, phone connection and other device status are not
  faked.
- The 174×66 tile layout is a first emulator-oriented layout, not yet tuned
  against the Xiaomi Watch S4 round 466×466 panel.
- This is one native system component, not a bootable NesaOS firmware image.
- The source has not yet been compiled or run against an openvela checkout.

## Integrate into an openvela source checkout

The upstream manifest checks out `open-vela/packages_demos` at
`packages/demos/`. Copy this directory into that source tree:

```sh
mkdir -p packages/demos/nesaos_home
cp -a /path/to/velagram/NesaOS/system/apps/nesaos_home/. packages/demos/nesaos_home/
```

**Register the app in the parent build files.** The official openvela demo
integration guide requires editing the parent `packages/demos/Make.defs`;
do not assume a child `Make.defs` is discovered automatically. Add:

```make
ifneq ($(CONFIG_NESAOS_HOME),)
CONFIGURED_APPS += $(APPDIR)/packages/demos/nesaos_home
endif
```

Then add this source line to the parent demo Kconfig menu at the appropriate
location in the checked-out revision:

```kconfig
source "$(APPDIR)/packages/demos/nesaos_home/Kconfig"
```

Check the actual parent Kconfig file and menu structure in the pinned checkout
before editing it. The child `Make.defs` in this repository contains the
registration fragment above as a reference; the parent registration is the
required build-system step.

## First build and runtime validation

The first validation target should be the upstream Goldfish ARMv7-A emulator
configuration used by native demo examples:

```sh
./build.sh vendor/openvela/boards/vela/configs/goldfish-armeabi-v7a-ap menuconfig
./build.sh vendor/openvela/boards/vela/configs/goldfish-armeabi-v7a-ap -j$(nproc)
./emulator.sh vela
```

Enable `NESAOS_HOME` in menuconfig. After boot, start the application from the
openvela shell:

```sh
nesaos_home &
```

Record the compiler output, build exit code, emulator boot result, and runtime
logs. A successful emulator build proves only that this native component works
on that emulator target; it does not establish Xiaomi Watch S4 compatibility.

## Next implementation steps

1. Integrate the component into a pinned openvela checkout and compile it.
2. Verify display and touch behavior in the emulator.
3. Add a tested app-launch mechanism using the target's supported process API.
4. Replace fixed layout dimensions with display-size-aware layout.
5. Add real clock and system-service status integrations.
6. Only then begin device-specific adaptation, if a vendor-authorized Watch S4
   development target becomes available.

## Upstream references

- [openvela native demo integration guide](https://doc.openvela.com/document?id=211&language=en&version=trunk)
- [openvela native demos](https://github.com/open-vela/packages_demos)
