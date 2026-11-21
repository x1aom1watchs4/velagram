# VelaStore catalogue format (schema 1)

The prototype currently reads local app metadata. This document defines a small, versioned JSON format for a future hosted catalogue.

## Rules

- `schemaVersion` is the format version, independent of the store app version.
- Every app has a stable, lowercase `id`.
- `packageSize` is an integer byte count, not a display string.
- `compatibility` contains declared platform/device profile identifiers. A generic `vela-watch` value is not proof of Watch S4 compatibility.
- `availability: catalog-only` means the entry is informational and has no installable package.
- Do not publish a package URL until the package is authorized for distribution and its integrity metadata is available.

## Future package metadata

Before enabling a package download, an app entry must include:
- an HTTPS package URL;
- a 64-character SHA-256 digest;
- a signature and signer/key identifier for the later installation-trust check;
- minimum and maximum platform requirements;
- an explicit supported-device list;
- release notes and a rollback-safe update policy.

The watch client uses `system.request` to download the RPK into the app cache and `system.crypto` to compare its SHA-256 digest. A checksum mismatch is rejected. A checksum confirms file integrity against catalogue metadata; it does not prove who published the package. Signature verification and a trusted publisher key are still required before any installation flow is enabled. Downloaded files currently remain in the VelaStore app cache; this is not an installer and does not guarantee permanent storage.

## Example

See `catalog/catalog.json`. It contains demonstration entries only; no installable packages are supplied.
