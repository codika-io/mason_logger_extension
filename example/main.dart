// ignore_for_file: cascade_invocations

import 'package:mason/mason.dart';
import 'package:mason_logger_extension/mason_logger_extension.dart';

void main() {
  final logger = Logger();

  // Basic logging with checkmarks and x-marks
  logger
    ..info('\n1. Basic Logging Examples:'.toLink)
    ..checkmark('Task completed successfully')
    ..xmark('Task failed')
    ..nextLine();

  // Frames for important sections
  logger
    ..info('2. Frames Examples:'.toLink)
    ..frame('Configuration Settings')
    ..frame('Database Options');

  // Tables for structured data
  logger
    ..info('\n3. Table Example:'.toLink)
    ..table(
      headers: ['Name', 'Status', 'Priority'],
      rows: [
        ['Task 1', 'Complete'.toLightGreen, 'High'.toLightRed],
        ['Task 2', 'Pending'.toLightYellow, 'Medium'.toLightBlue],
        ['Task 3', 'In Progress'.toLightCyan, 'Low'.toLightMagenta],
      ],
      headerColors: [cyan, cyan, cyan],
      columnAlignments: [
        TableContentAlign.left,
        TableContentAlign.center,
        TableContentAlign.right,
      ],
    );

  // Lists with bullets and anchors
  logger
    ..info('\n4. Lists Examples:'.toLink)
    ..listBullets(
      ['First item', 'Second item', 'Third item'],
      bulletColor: cyan,
    )
    ..nextLine()
    ..listAnchors(
      ['Step 1: Initialize', 'Step 2: Configure', 'Step 3: Run'],
      style: LoggerBorderStyle.rounded,
    );

  // QR Code generation
  logger
    ..info('\n5. QR Code Example:'.toLink)
    ..qrCode('https://github.com/codika-io/mason_logger_extension');

  // Interactive prompts (commented out as they require user input)
  logger.info('\n6. Prompts Examples:'.toLink);
  // Uncomment to try interactive features:
  /*
  final name = logger.askForString('What is your name?');
  final age = logger.askForString('How old are you?');
  final likesCoding = logger.askForBool('Do you like coding?');
  final bio = logger.askForMultilineString('Tell us about yourself:');
  final favoriteColor = logger.askForEnum(
    'Choose your favorite color:',
    ['Red', 'Blue', 'Green', 'Yellow'],
  );
  */

  // String extensions for colors and formatting
  logger
    ..info('\n7. String Formatting Examples:'.toLink)
    ..info('This is a success message'.toLightGreen)
    ..info('This is an error message'.toLightRed)
    ..info('This is a warning message'.toLightYellow)
    ..info('Visit our website'.toLink);

  // Prompt styling
  logger
    ..info('\n8. Prompt Styling Example:'.toLink)
    ..info('Are you sure?'.questionMark())
    ..info('Continue?'.questionMark(symbol: '❓', color: cyan));

  // Different border styles
  logger
    ..info('\n9. Border Styles Example:'.toLink)
    ..frame(
      'Sharp Border',
      style: LoggerBorderStyle.sharp,
      color: lightGreen,
    )
    ..frame(
      'Normal Border',
      style: LoggerBorderStyle.normal,
      color: lightBlue,
    )
    ..frame(
      'Rounded Border',
      color: lightMagenta,
    );
}

extension LoggerExtensionFrames on Logger {
  /// Creates a primary section title with sharp borders and cyan coloring.
  ///
  /// This is typically used for main section headers in the console output.
  ///
  /// Example:
  /// ```dart
  /// logger.sectionTitle('Configuration');
  /// ╔══════════════════════════════════╗
  /// ║          Configuration           ║
  /// ╚══════════════════════════════════╝
  /// ```
  ///
  /// Parameters:
  /// * [title] - The text to display in the frame
  /// * [length] - The total width of the frame (default: 80)
  void sectionTitle(String title, {int length = 80}) {
    frame(
      title,
      length: length,
      style: LoggerBorderStyle.sharp,
      color: cyan,
    );
  }

  /// Creates a secondary title with normal borders and blue coloring.
  ///
  /// This is typically used for subsections or less prominent headers.
  ///
  /// Example:
  /// ```dart
  /// logger.secondaryTitle('Details');
  /// ┌─ Details ───────────────────────┐
  /// └──────────────────────────────────┘
  /// ```
  ///
  /// Parameters:
  /// * [title] - The text to display in the frame
  /// * [length] - The total width of the frame (default: 80)
  void secondaryTitle(String title, {int length = 80}) {
    frame(
      title,
      length: length,
      centered: false,
      style: LoggerBorderStyle.normal,
      linesBefore: 1,
      color: blue,
    );
  }

  /// Creates an error section with sharp borders and red coloring.
  ///
  /// This is used to highlight error messages in the console output.
  ///
  /// Example:
  /// ```dart
  /// logger.errorSection('Failed to connect to the server');
  /// ╔══════════ An Error Occurred ════════════╗
  /// ║  Failed to connect to the server        ║
  /// ╚════════════════════════════════════════╝
  /// ```
  ///
  /// Parameters:
  /// * [message] - The error message to display
  /// * [length] - The total width of the frame (default: 80)
  void errorSection(String message, {int length = 80}) {
    frame(
      'An Error Occurred',
      length: length,
      style: LoggerBorderStyle.sharp,
      color: red,
    );
    info(red.wrap(message));
    nextLine();
  }
}
