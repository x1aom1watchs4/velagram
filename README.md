# VelaStore

VelaStore is an experimental app catalogue prototype for Xiaomi Vela watches, initially designed around the 466×466 display class.

## Current scope

- Browse a curated catalogue of sample apps.
- Explore categories and app information.
- View compatibility and release metadata.
- Demonstrate the store interface without attempting installation.

## Important compatibility note

This repository contains a catalogue UI prototype. It does not currently install RPK packages, communicate with Xiaomi's private developer services, or modify watch firmware. Retail Xiaomi Watch S4 installation support is not confirmed.

## Build

Requirements: Node.js 20+

```sh
cd watch
npm install
npm run build
```

The build workflow uploads a debug RPK artifact when the toolkit produces one.
