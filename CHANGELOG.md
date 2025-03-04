# 0.1.7

### Features ✨

- feat: add new text style extensions (`toBold`, `toItalic`, `toUnderlined`, `toBlink`, `toDim`, `toReverse`)
- feat: add new formatting utilities (`toBox`, `toIndentedBlock`)
- feat: add new status indicators (`toCrossMarked`, `toWarning`, `toInfo`, `toSuccess`, `toError`)

# 0.1.6

- refactor!: rename `printTable` method to `table` for better consistency with Dart naming conventions
- refactor!: rename `displayQRCode` method to `qrCode` for better consistency with Dart naming conventions
- refactor!: rename `infoBulletList` method to `listBullets` for better consistency with Dart naming conventions
- refactor!: rename `infoConnectedList` method to `listAnchors` for better consistency with Dart naming conventions

### Features ✨

- feat: add `borderType` parameter to `table` method to control table border style

# 0.1.5

### Breaking Changes 🛠️

### Features ✨

- feat: add customizable border parameter to `table` method
- feat: add spacing parameters to QR code display (`spacingTop` and `spacingBottom`)

### Bug Fixes 🐛

- fix: correct QR code display by properly adding line breaks between rows

# 0.1.4

### Breaking Changes 🛠️

- refactor!: rename functions to follow native Dart naming conventions
- refactor!: remove imposed frame types

# 0.1.3Hey! Thanks for connecting - my post about Codika went viral but honestly not many people added me as a contact, so I guess you're really interested in what we're building! What caught your attention about it?

We've got an amazing Discord community for Flutter devs starting up: <https://discord.gg/SqDVTEkH>
Let me know if you have any questions!

### Documentation 📝

- docs: add tags in pub.dev page for better discoverability
- docs: update package keywords and categories

# 0.1.2

### Dependencies 📦

- deps: upgrade package dependencies to latest stable versions
- deps: update minimum SDK constraints

# 0.1.1

### Documentation 📝

- docs: improve README.md with better examples and usage instructions
- docs: add API documentation and code examples
- docs: enhance package description

# 0.1.0+1

### Features 🎉

- feat: add base logger extension with core logging utilities
- feat: add frames extension for boxed content and borders
- feat: add lists extension for bulleted and connected lists
- feat: add prompts extension for interactive user input
- feat: add QR code extension for terminal display
- feat: add table extension with Unicode box-drawing support
- feat: add string appender extension for formatted prefixes
- feat: add string colors extension for ANSI color support
- feat: add border library for consistent styling

### Dependencies 📦

- deps: add mason logger dependency
- deps: add QR code generation support
- deps: add development dependencies for testing and analysis
