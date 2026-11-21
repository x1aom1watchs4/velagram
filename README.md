# VelaStore

VelaStore is an experimental catalogue for Xiaomi Vela watches, designed for a 466 × 466 watch display.

## Projects

- `watch/` — VelaStore catalogue app.
- `games/tap-rush/` — 30-tap challenge.
- `games/memory-match/` — matching-pairs game.
- `games/2048-mini/` — number-merging puzzle.
- `games/snake-lite/` — touch-controlled grid snake.

Each game is a separate Vela app project with its own package identifier and manifest.

## Build

Build the catalogue from `watch/`:

```sh
npm install
npm run build
```

Build an individual game from its folder, for example:

```sh
cd games/tap-rush
npm install
npm run build
```

GitHub Actions builds the catalogue and all four games as separate debug RPK artifacts.

## Important device limitation

The RPK build output is a test package, not proof that retail Xiaomi Watch S4 (M2425W1) accepts third-party installations. Installation may require Xiaomi partner/developer access and an officially supported device-side installer. VelaStore does not bypass that restriction, modify firmware, or silently install packages.
