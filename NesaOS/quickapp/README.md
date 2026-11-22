# NesaOS Quick App shell

This is the first source-level app shell for testing NesaOS layout and navigation in the Vela Quick App environment. It is **not** a replacement firmware image and has not yet been built or tested on a physical Watch S4.

## Target

- Xiaomi Watch S4 display: 466 × 466
- Logical design width: 233
- Runtime: Vela JS Quick App
- Package: `com.nesaos.watch.shell`

## Build and test

1. Install the official Xiaomi AIoT IDE / Vela Quick App toolchain.
2. Open this folder as a Quick App project.
3. Install dependencies with `npm install`.
4. Start the official emulator from the IDE.
5. Run `npm run build` and test the generated app in the emulator.

The package scripts and source layout follow the public Vela Quick App example structure. Toolchain compatibility still needs to be checked against the currently supported AIoT IDE release.

## Current implementation

- NesaOS title and preview status
- Quick-access entries for Nesa Control, Nesa Faces, Nesa Themes, Apps, and Settings
- Basic panel text changes when a menu item is selected
- Turquoise, light-blue, and warm-brown accent palette

## Not implemented yet

- Live clock, battery, Bluetooth, phone-link, sensors, or button events
- Real application launching or package installation
- Persistent settings, watch faces, music playback, or system controls
- Device firmware, bootloader integration, or a flashable image

All device status is deliberately labelled as unavailable until a supported device API is verified.
