# NesaOS device compatibility: Xiaomi Watch S4

**Target:** Xiaomi Watch S4, model M2425W1  
**Display target:** round, 466 × 466 px  
**Status:** research / feasibility stage — no device firmware build or installation is claimed.

## Findings

1. Xiaomi's product specification identifies M2425W1 as Xiaomi Watch S4 and lists the 466 × 466-class watch target in the public device ecosystem. The product specification lists the T1 wearable platform and a maximum CPU frequency of 500 MHz.
2. The public openvela manifest includes the project path `vendor/xiaomi/vela/pyxis`. This is evidence that Xiaomi-specific Vela vendor code exists in the openvela source manifest. **It does not, by itself, prove that Pyxis is the M2425W1 board target** or that a complete public firmware configuration for this watch is available.
3. The openvela documentation describes a source-based NuttX system with vendor board support, frameworks, packages, and QEMU/emulator targets. A QEMU build is useful for development but is not a Watch S4 firmware image.
4. A community wearable-development guide lists Xiaomi Watch S3/S4 among Vela JS Quick App targets at 466 × 466, with a design width of 233. This is application-level compatibility information, not evidence that a third-party replacement OS can be flashed.
5. Xiaomi's official Vela documentation says real-device debugging is currently supported only on Watch S4 devices, but requires a special OTA version and is open only to specific partners. This is an app-debugging route, not a public replacement-firmware route.
6. The watch's retail firmware, boot chain, hardware drivers, signing requirements, and supported installation route have not been verified for NesaOS.

## Compatibility matrix

| Area | Current evidence | NesaOS decision |
|---|---|---|
| Display | 466 × 466 round display; 233 design-width convention appears in a community Quick App guide | Use 233 logical units for the first app UI prototype; verify on the official emulator/device |
| Quick Apps | Community guide lists S3/S4 as Vela JS targets; Xiaomi's official real-device debug is partner-limited | Keep only as a separate prototype; it is not the OS build target |
| Full openvela firmware | Manifest contains Xiaomi Vela vendor path `pyxis`; exact mapping to M2425W1 unconfirmed | Do not claim a bootable Watch S4 image until board config and drivers are verified |
| Bluetooth / phone link | openvela has general connectivity frameworks; watch-specific API availability is unverified | Show status only after a documented API is confirmed |
| Hardware button | No verified public Watch S4 event API found yet | Keep button mapping as a pending integration item |
| RPK / app installation | Community material describes app packaging; retail-device acceptance and signing policy remain unverified | Do not promise an installer or sideload workflow until an official supported path is confirmed |
| Sensors, battery, display control | Device-specific interfaces not yet confirmed | No fake controls or fabricated live values in the product |

## Recommended build path

### Phase 1 — native openvela system baseline

- Initialize the official openvela source workspace from `open-vela/manifests` using its `openvela.xml` manifest.
- Select a currently supported upstream emulator or development-board target from the official documentation.
- Produce and record a reproducible native system build for that reference target.
- Keep NesaOS product changes in a separate overlay so upstream kernel, frameworks, and vendor code remain traceable.
- Treat the browser and Quick App prototypes as visual references only; neither is the NesaOS operating system.

### Phase 2 — documented device APIs

- Verify each API against official Xiaomi Vela documentation and the target firmware.
- Add Bluetooth/phone state, hardware-button input, battery, sensors, and display settings only when the API is available and tested.
- Test text rendering, touch targets, scrolling, and performance on the actual S4 through an officially supported developer workflow.

### Phase 3 — native firmware feasibility

Before attempting a full OS port, establish all of the following from public/vendor-authorized sources:

- Exact board configuration and SoC/MCU mapping for M2425W1.
- Display controller, touch controller, PMIC, battery, sensor, storage, and Bluetooth drivers.
- Bootloader and verified-boot constraints, image format, signing keys, and an authorized recovery path.
- Whether the vendor provides a supported way to build and install a replacement system image.

If any of these are unavailable, NesaOS should remain an application-layer experience rather than being presented as a replacement firmware.

## Safety and integrity constraints

- Do not overwrite or remove the watch's existing firmware as part of exploratory development.
- Do not rely on hidden debug pages, undocumented installer entry points, or security bypasses.
- Do not label emulator output, a browser mockup, or an RPK build as a working Watch S4 OS.
- Preserve the existing repository history while the NesaOS implementation is developed on its own branch.

## Sources

- Xiaomi Watch S4 official specifications: https://www.mi.com/prod/xiaomi-watchS4/specs
- openvela source manifest: https://github.com/open-vela/manifests/blob/dev/openvela.xml
- openvela documentation: https://github.com/open-vela/docs
- Community wearable development guide (use as a lead, not as vendor certification): https://github.com/oryonatan/xiaomi-band-development
