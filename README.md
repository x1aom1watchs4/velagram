# VelaStore

VelaStore is an experimental app catalogue for Xiaomi Vela watches, currently designed for a 466 × 466 watch display.

## Version 1.0 preview

- Home screen with featured catalogue entries
- Category browser with category-filtered search
- Search by app name, category, and description
- App detail pages with version, package size, and listing status
- Sample library/status page
- Settings and device compatibility information
- English UI to avoid missing Cyrillic glyphs on the target display

## Build

From the `watch/` directory:

```sh
npm install
npm run build
```

The GitHub Actions workflow builds a debug RPK and uploads it as an artifact.

## Current limitations

- The catalogue currently uses local demo data; there is no remote catalogue API yet.
- Search and navigation work within the prototype, but the library is informational only.
- The app does not download or install third-party apps.
- Installation on retail Xiaomi Watch S4 (M2425W1) has not been verified and may require Xiaomi partner/developer access and device-specific support.
- This project does not modify watch firmware.

## Next development milestones

1. Validate the app in the Vela emulator and on supported hardware if access becomes available.
2. Add a remote catalogue API and signed metadata format.
3. Define package hosting, integrity checks, and update flow.
4. Investigate official installation support for the exact Watch S4 Bluetooth model before implementing an installer.
