# 0.3.0

### Features ✨

- feat: add new paragraph function for advanced text formatting
  - Provides sophisticated text wrapping with support for ANSI escape sequences
  - Handles bullet points with proper indentation and alignment
  - Preserves paragraph structure with customizable separations
  - Supports text alignment (left, right, center) and custom indentation
  - Includes color parameter that preserves existing text formatting
  - Enables hyphenation for long words and proper handling of special characters

# 0.2.8

### Features ✨

- feat: add missing foreground colors to string extensions
  - Add basic colors (`toBlack`, `toRed`, `toGreen`, `toYellow`, `toBlue`, `toMagenta`, `toCyan`)
  - Add additional colors (`toLightGray`, `toDefaultForeground`, `toDarkGray`, `toWhite`)
  - Ensures complete coverage of all available ANSI color options
- feat: add background color extensions as new `LoggerStringExtensionBackgroundColors`
  - Add all background color variants (e.g., `toBlackBackground`, `toRedBackground`, etc.)
  - Support all 16 standard background colors including light variants
  - Enable easy application of background colors to strings

# 0.2.7

### Features ✨

- feat: add `encloseFreeSide` parameter to titled separator component
  - Allows enclosing the free extremities of the titled separator with top corner characters
  - Improves visual aesthetics for hierarchical UI elements
  - Creates a more enclosed, refined appearance when multiple separators are used together

# 0.2.6

### Bug Fixes 🐛

- fix: ensure title box connections align perfectly with the table
  - Correctly account for position offsets by including the corner character in calculations
  - Maintain proper vertical alignment between title box and table connections

# 0.2.5

### Bug Fixes 🐛

- fix: correct the alignment of title box connections to tables
  - Fix position calculation for title connection points by accounting for corner character
  - Ensure title box vertical borders align perfectly with table connections

# 0.2.4

### Bug Fixes 🐛

- fix: resolve issue with ANSI color codes breaking table title connections
  - Fix problem where `[90m` color codes were visible in table borders
  - Completely rebuild the top line with uncolored characters before applying color
  - Ensure proper connections between non-stretched title box and main table
  - Fix visual inconsistency between different border styles with titled tables

# 0.2.3

### Bug Fixes 🐛

- fix: correct table title connections for both stretched and non-stretched titles
  - Use proper tee characters (teeRight and teeLeft) for stretched title bottom borders
  - Use appropriate intersection characters (cross or teeUp) where title vertical borders meet table top line
  - Fix visual representation when title box connects with table borders

# 0.2.2

### Features ✨

- feat: add border color customization to table component
- feat: add title support to tables with configurable options
  - `stretchTitle` parameter controls whether title spans full table width
  - `titlePadding` parameter controls spacing around title text
- feat: create new titled separator component
  - Supports left, center, and right alignment
  - Shows a title box connected to a horizontal separator line
  - Uses proper tee connections where title box meets separator line
  - Customizable length, padding, border style, and color

# 0.2.1

### Bug Fixes 🐛

- fix: resolve stack overflow in `LoggerBorder.getChar()` by removing recursive call for doubled border style

# 0.2.0

### Breaking Changes 🛠️

- refactor!: rename `LoggerBorderStyle.sharp` to `LoggerBorderStyle.doubled` for better clarity
- feat!: add new border style `LoggerBorderStyle.heavy` for bold/thick borders

# 0.1.8

### Features ✨

- feat: add `dynamicLength` parameter to `frame` method to allow content-based width
- feat: add `innerPadding` parameter to `frame` method to control spacing between content and borders

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
