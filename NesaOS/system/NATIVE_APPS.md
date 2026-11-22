# NesaOS native system-app integration plan

This plan is based on the upstream `open-vela/packages_demos` repository and its checked-in application instructions. These are **native openvela applications**, not Quick Apps and not RPK packages.

## Source integration

The stable openvela manifest includes this project:

```xml
<project path="packages/demos" name="packages_demos" />
```

After `repo sync`, the source tree is available at:

```text
packages/demos/
```

The upstream demo repository currently documents native examples including Calculator, Snake Game, Virtual Pet, and Music Player 2. Each demo has its own configuration and hardware/service assumptions. Do not enable every demo blindly.

## First native application set

| NesaOS component | Upstream reference | Verified upstream configuration / notes |
|---|---|---|
| Calculator | `packages/demos/calculator` | `LVX_USE_DEMO_CALCULATOR=y`; upstream guide documents the Goldfish ARMv7-A emulator target |
| Snake | `packages/demos/snake_game` | `LVX_USE_DEMO_SNAKE_GAME=y`; resource root `/data`; upstream guide documents the Goldfish ARMv7-A emulator target |
| Virtual Pet | `packages/demos/pet` | `CONFIG_LVX_USE_DEMO_PET=y`; requires LVGL, NuttX and libuv according to its README |
| Music Player 2 | `packages/demos/music_player2` | `CONFIG_LVX_USE_DEMO_VELA_AUDIO=y`; resource root `/data`; audio framework and audio output required; Wi-Fi functionality depends on a supported Wi-Fi driver |

The upstream configuration naming is not perfectly uniform across demos. Use each demo's own Kconfig and Makefile as the source of truth when integrating it into a selected openvela release.

## Integration sequence

### 1. Establish a known-good native-app target

The upstream Calculator and Snake guides use:

```sh
./build.sh vendor/openvela/boards/vela/configs/goldfish-armeabi-v7a-ap menuconfig
```

This is a different target from the ARM64 reference baseline in [BUILD_BASELINE.md](./BUILD_BASELINE.md). Keep the two targets separate until both are built and tested. Do not copy ARMv7 configuration symbols into the ARM64 target without checking its Kconfig.

### 2. Enable one demo at a time

For the first proof, enable Calculator only:

```text
LVX_USE_DEMO_CALCULATOR=y
```

Then build the same target selected in menuconfig:

```sh
./build.sh vendor/openvela/boards/vela/configs/goldfish-armeabi-v7a-ap -j$(nproc)
```

After booting the emulator with the matching upstream instructions, start the native program from the openvela shell using its documented command. For the Calculator demo, the upstream guide documents `calculator &`.

### 3. Verify the actual native app lifecycle

Record whether the app:
- is compiled into the system image;
- starts from the shell;
- creates its LVGL UI successfully;
- exits cleanly;
- preserves system responsiveness after exit.

Only after this works should NesaOS begin replacing the demo UI with its own launcher/home/settings components.

### 4. NesaOS product integration

The target product structure is:

- **Nesa Home** — watch face, widgets and app launcher.
- **Nesa Settings** — display, sound, battery and supported connectivity settings.
- **Nesa Apps** — native system applications with stable launch identifiers.
- **Nesa Themes / Nesa Faces** — theme and watch-face resources, subject to the real graphics/resource APIs.
- **Nesa Control** — device controls exposed only when a real system service and hardware capability exist.

This is a product-layer plan, not a claim that these components already exist as native code.

## Important compatibility boundary

The upstream demos document emulator configurations. They do not prove that the same binaries, display assumptions, touch input, audio, or resource paths work on Xiaomi Watch S4 M2425W1. The Watch S4 board port remains blocked on vendor-authorized board support, boot/signing details, drivers, and a documented recovery/update path.

## Upstream sources

- [openvela native demos](https://github.com/open-vela/packages_demos)
- [Calculator integration guide](https://github.com/open-vela/packages_demos/blob/dev/calculator/Readme.md)
- [Snake integration guide](https://github.com/open-vela/packages_demos/blob/dev/snake_game/Readme.md)
- [Virtual Pet guide](https://github.com/open-vela/packages_demos/blob/dev/pet/README.md)
- [Music Player 2 guide](https://github.com/open-vela/packages_demos/blob/dev/music_player2/README-en.md)
- [openvela manifest](https://github.com/open-vela/manifests/blob/trunk/openvela.xml)
