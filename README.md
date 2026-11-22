# NesaOS

NesaOS is an experimental smartwatch operating-system project targeting the Xiaomi Watch S4 (M2425W1, 466 × 466 display), with openvela as the intended OS foundation.

The goal is a Material Design 3 / Material You-inspired watch experience with a glanceable home screen, round app launcher, settings, and useful built-in apps.

> **Development status:** foundation and feasibility stage. This repository does not yet contain a bootable NesaOS firmware image. Compatibility with retail Xiaomi Watch S4 hardware, its boot chain, display/touch drivers, power management, and supported installation path must be established before claiming device support.

## Product direction

- **Name:** NesaOS
- **Target:** Xiaomi Watch S4 (M2425W1)
- **Display target:** 466 × 466, round
- **Visual language:** Material Design 3 / Material You
- **Palette direction:** turquoise, warm brown, and light blue
- **Home:** watch face with glanceable widgets
- **Launcher:** circular app icons
- **Hardware key:** intended to open/switch apps, subject to the supported input API
- **Network:** show Bluetooth/phone connection state; expose only controls confirmed by hardware and platform APIs
- **Apps:** adapt suitable openvela examples and develop Nesa-specific utilities

## Planned built-in apps

- Calculator
- Calendar
- Tasks
- Music controls/player (subject to supported media APIs)
- Nesa Control
- Nesa Themes
- Nesa Faces

These are roadmap items, not implemented features yet.

## Architecture direction

NesaOS is planned as a product layer on top of openvela:

1. **Platform foundation** — openvela / NuttX kernel, board support, drivers, and system services.
2. **Device adaptation** — Watch S4 display, touch, buttons, sensors, Bluetooth, battery, and power management. This layer is blocked until a supported board configuration and hardware interfaces are verified.
3. **Nesa shell** — home screen, widget host, launcher, navigation, and system UI.
4. **System apps** — settings, connectivity status, clock/faces, and built-in utilities.
5. **App compatibility** — adapt upstream examples where APIs and licenses permit.

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for the initial technical plan.

## Build status

There is currently no verified NesaOS firmware build command. The previous VelaStore app build scripts are not a NesaOS firmware build system and must not be presented as one.

The first engineering milestone is to identify a reproducible openvela development environment and a supported target/emulator configuration, then document the gap between that target and Xiaomi Watch S4 (M2425W1).

## Safety and installation

NesaOS development will use documented development and testing paths. A generated package or successful emulator build does not prove that retail Watch S4 firmware will accept it.

## Upstream

- [openvela project](https://github.com/open-vela)
- [openvela documentation](https://doc.openvela.com/)
- [openvela source repositories](https://github.com/open-vela)

Each upstream component retains its own license. Review the relevant repository's LICENSE and third-party notices before copying or redistributing code.
