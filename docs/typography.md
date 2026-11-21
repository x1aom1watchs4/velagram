# VelaStore typography

## Platform constraint

The app targets Xiaomi Vela JS, not Wear OS. The official Vela `text` component documents `font-size`, `font-style`, `font-weight`, `line-height`, and text alignment, but does not document `font-family`, `@font-face`, or bundled font registration. Vela documents only two effective font-weight modes: normal and bold.

Material 3 Expressive on Wear OS uses Roboto Flex. It is the visual reference for this project, but it cannot be truthfully claimed as the rendered typeface on VelaStore until the target runtime confirms custom-font support.

## Current implementation

- Keep the platform's native font to preserve Cyrillic and avoid an unverified font-loading path.
- Use a consistent hierarchy of compact labels, readable body text, and bold page/app titles.
- Avoid letter spacing because it is not listed in the Vela text-style support table.
- Do not add `font-family` or `@font-face` to production pages without runtime confirmation.

## Next verification

A real-device or official Vela simulator test is required to establish whether bundled Roboto Flex can be loaded. A successful RPK build alone would only prove packaging, not that the runtime actually renders the custom typeface.
