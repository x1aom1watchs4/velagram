# VelaStore

VelaStore is an experimental app catalogue for Xiaomi Vela watches, initially designed for a 466×466 display.

## Version 1.0.0 preview

- Home screen with featured catalogue entries.
- Category browser.
- Individual information screens for sample apps.
- My Library placeholder with an explicit installation status.
- Settings and device compatibility notes.
- English-only UI to avoid missing-glyph boxes on the target watch.

## Important compatibility note

This project is a catalogue UI prototype. It does not install RPK packages, communicate with Xiaomi's private developer services, or modify watch firmware. Retail Xiaomi Watch S4 (M2425W1) installation support is not confirmed. App compatibility labels are deliberately marked as unverified.

## Build

Requirements: Node.js 20+

```sh
cd watch
npm install
npm run build
```

GitHub Actions builds a debug RPK and uploads it as a workflow artifact when the toolkit produces the expected package.

## Project structure

- `watch/src/common/apps.js`: sample catalogue data.
- `watch/src/pages/`: home, categories, app details, library and settings screens.
- `watch/src/manifest.json`: app metadata and page routes.
