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

## Integrate into an openvela source checkout

The upstream manifest checks out open-vela/packages_demos at packages/demos.
Copy this directory's contents into:

    packages/demos/nesaos_home/

The parent demo Make.defs uses a wildcard to include each child Make.defs.
The Make.defs in this folder registers the application when enabled.

Also add this Kconfig source line to the parent demo Kconfig menu in the
checked-out openvela revision:

    source "$(APPDIR)/packages/demos/nesaos_home/Kconfig"

Do not assume the parent Kconfig path or menu layout without checking the
specific openvela revision being built.

Enable NESAOS_HOME in menuconfig, then build the selected target. The
first validation target should be the upstream Goldfish ARMv7-A emulator
configuration used by the native demo examples:

    ./build.sh vendor/openvela/boards/vela/configs/goldfish-armeabi-v7a-ap menuconfig
    ./build.sh vendor/openvela/boards/vela/configs/goldfish-armeabi-v7a-ap -j$(nproc)
    ./emulator.sh vela

From the openvela shell, start:

    nesaos_home &

## Next implementation steps

1. Validate compilation against a pinned openvela checkout.
2. Verify display and touch behavior in the emulator.
3. Add a tested app-launch mechanism using the target's supported process API.
4. Replace fixed layout dimensions with display-size-aware layout.
5. Add real clock and system-service status integrations.
6. Only then begin device-specific adaptation, if a vendor-authorized Watch S4
   development target becomes available.
