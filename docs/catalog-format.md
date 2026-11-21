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

Before enabling downloads, extend an app entry with:
- an HTTPS package URL;
- a SHA-256 digest;
- a signature and signer/key identifier;
- minimum and maximum platform requirements;
- an explicit supported-device list;
- release notes and a rollback-safe update policy.

The client must verify authenticity and integrity before presenting a package as installable. A catalogue response alone must never trigger installation.

## Example

See `catalog/catalog.json`. It contains demonstration entries only; no installable packages are supplied.
