# Mason Logger Extension 🎨

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A powerful extension library for Mason Logger that adds beautiful formatting, interactive prompts, and rich display features to your command-line applications.

## Features 🚀

- 📦 **Base Extensions**: Checkmarks, X-marks, and formatted messages
- 🖼️ **Frames**: Beautiful borders and section titles
- 📊 **Tables**: Formatted tables with alignment and colors
- 📝 **Lists**: Bulleted and connected lists
- 🔍 **QR Codes**: Terminal-displayable QR codes
- 🎯 **Prompts**: Interactive user input with various styles
- 🎨 **Colors**: Rich ANSI color support
- 🔤 **String Formatting**: Convenient string manipulation

## Installation 💻

Add `mason_logger_extension` to your `pubspec.yaml`:

```yaml
dependencies:
  mason_logger_extension: ^0.1.0
```

## Usage 📝

```dart
import 'package:mason/mason.dart';
import 'package:mason_logger_extension/mason_logger_extension.dart';

void main() {
  final logger = Logger();
  
  // Basic logging with checkmarks
  logger.checkmark('Task completed successfully');
  logger.xmark('Task failed');

  // Create beautiful tables
  logger.printTable(
    headers: ['Name', 'Status', 'Priority'],
    rows: [
      ['Task 1', 'Complete'.colorLightGreen, 'High'],
      ['Task 2', 'Pending'.colorLightYellow, 'Medium'],
    ],
  );

  // Display formatted lists
  logger.listBullets(
    ['First item', 'Second item', 'Third item'],
    bulletColor: cyan,
  );

  // Show QR codes in the terminal
  logger.displayQRCode('https://github.com/codika-io/mason_logger_extension');

  // Interactive prompts
  final name = logger.askForString('What is your name?');
  final confirm = logger.askForBool('Continue?');
}
```

## Extensions Overview 📚

### Logger Extensions

- **Base**: Core logging utilities with formatted output
- **Frames**: Create boxed content with various border styles
- **Tables**: Display data in formatted tables
- **Lists**: Create bulleted or connected lists
- **QR Codes**: Generate scannable QR codes in the terminal
- **Prompts**: Interactive user input with validation

### String Extensions

- **Colors**: Easy ANSI color formatting
- **Appender**: Prefix strings with formatted symbols

## Border Styles 🎭

The library supports three border styles:

- `sharp` (╔═╗)
- `normal` (┌─┐)
- `rounded` (╭─╮)

## Examples 🌟

Check out the [example](example/main.dart) file for a comprehensive demonstration of all features.

## Contributing 🤝

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) to get started.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
