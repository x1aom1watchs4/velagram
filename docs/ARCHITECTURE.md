# NesaOS — initial architecture

## 1. Scope

NesaOS aims to be a watch-oriented system experience for Xiaomi Watch S4 (M2425W1). The project uses openvela as its intended OS base, but upstream openvela support for smartwatches in general is not proof that this exact retail watch has a public, buildable board target.

The work is divided into two tracks:

- **Platform feasibility:** establish what can legally and technically run on the target hardware using public sources and supported development interfaces.
- **Nesa experience:** design and implement the shell and applications against a verified emulator or development target.

A launcher or Quick App running inside the stock watch environment is not the same thing as replacing the device firmware. Keep those deliverables clearly distinguished.

## 2. Layer model

| Layer | Responsibility | Current state |
|---|---|---|
| openvela / NuttX | Kernel, scheduling, filesystem, networking, core services | Upstream project exists; target board not yet verified |
| Board support | CPU/SoC configuration, drivers, display, touch, keys, sensors, power | Unknown for M2425W1 |
| Device services | Bluetooth, phone link, notifications, battery, time | API and permissions need verification |
| Nesa shell | Home, widgets, launcher, navigation, system UI | Planned |
| Nesa apps | Settings, calculator, calendar, tasks, control, themes, faces | Planned |
| Packaging | Build, sign, install, update | Must follow supported target-specific workflow |

## 3. UI principles

- Round-screen-first layout at a 466 × 466 logical target until device scaling is confirmed.
- Material Design 3-inspired components with restrained motion and readable contrast.
- Color direction: turquoise, warm brown, light blue.
- Large touch targets and short navigation paths.
- Home screen: time/date plus glanceable widgets.
- Launcher: circular icons and predictable focus/scroll behavior.
- Hardware-key behavior must be mapped to a documented input event; do not assume it can be reassigned.

## 4. Connectivity and package handling

The settings UI may display Bluetooth and phone-connection status only when backed by real platform APIs. Do not show a fake Wi-Fi switch or infer internet availability from Bluetooth pairing alone.

An Install app flow for .rpk packages is conditional on a documented installer, package-signing policy, permissions, and device support. A file picker by itself cannot install an application. Until these are verified, treat local package installation as a research item, not a promised feature.

## 5. Milestones

1. Inventory the existing repository and isolate the old VelaStore implementation.
2. Pin the upstream openvela repositories, revisions, and licenses needed for research/build.
3. Set up a reproducible official emulator/development environment.
4. Identify whether public board support exists for the exact Watch S4 hardware.
5. Build a minimal Nesa shell prototype against the verified target.
6. Add system services and apps incrementally, with tests.
7. Document only supported deployment and update procedures.

## 6. Acceptance criteria

- Every claimed feature is backed by an implementation and a test or documented hardware verification.
- Emulator success is not described as physical-device support.
- No undocumented firmware modification or security bypass is required.
- Third-party source retains attribution and license notices.
