import 'package:mason/mason.dart';
import 'package:mason_logger_extension/mason_logger_extension.dart';

/// Extension on [Logger] that provides methods for creating framed text output
/// in the console.
///
/// This extension offers various methods to create visually appealing frames
/// around text, including section titles, secondary titles, and error messages.
extension LoggerExtensionFrames on Logger {
  // We suggest creating your own logger extension on top of this one to
  // generalise frame types in you CLI application.
  //
  // /// Creates a primary section title with sharp borders and cyan coloring.
  // ///
  // /// This is typically used for main section headers in the console output.
  // ///
  // /// Example:
  // /// ```dart
  // /// logger.sectionTitle('Configuration');
  // /// ╔══════════════════════════════════╗
  // /// ║          Configuration           ║
  // /// ╚══════════════════════════════════╝
  // /// ```
  // ///
  // /// Parameters:
  // /// * [title] - The text to display in the frame
  // /// * [length] - The total width of the frame (default: 80)
  // void sectionTitle(String title, {int length = 80}) {
  //   frame(
  //     title,
  //     length: length,
  //     style: LoggerBorderStyle.sharp,
  //     color: cyan,
  //   );
  // }

  // /// Creates a secondary title with normal borders and blue coloring.
  // ///
  // /// This is typically used for subsections or less prominent headers.
  // ///
  // /// Example:
  // /// ```dart
  // /// logger.secondaryTitle('Details');
  // /// ┌─ Details ───────────────────────┐
  // /// └──────────────────────────────────┘
  // /// ```
  // ///
  // /// Parameters:
  // /// * [title] - The text to display in the frame
  // /// * [length] - The total width of the frame (default: 80)
  // void secondaryTitle(String title, {int length = 80}) {
  //   frame(
  //     title,
  //     length: length,
  //     centered: false,
  //     style: LoggerBorderStyle.normal,
  //     linesBefore: 1,
  //     color: blue,
  //   );
  // }

  // /// Creates an error section with sharp borders and red coloring.
  // ///
  // /// This is used to highlight error messages in the console output.
  // ///
  // /// Example:
  // /// ```dart
  // /// logger.errorSection('Failed to connect to the server');
  // /// ╔══════════ An Error Occurred ════════════╗
  // /// ║  Failed to connect to the server        ║
  // /// ╚════════════════════════════════════════╝
  // /// ```
  // ///
  // /// Parameters:
  // /// * [message] - The error message to display
  // /// * [length] - The total width of the frame (default: 80)
  // void errorSection(String message, {int length = 80}) {
  //   frame(
  //     'An Error Occurred',
  //     length: length,
  //     style: LoggerBorderStyle.sharp,
  //     color: red,
  //   );
  //   info(red.wrap(message));
  //   nextLine();
  // }

  /// Creates a customizable framed title with various styling options.
  ///
  /// This is the core method used by other title methods, providing full
  /// control over the appearance of the frame.
  ///
  /// Parameters:
  /// * [title] - The text to display in the frame
  /// * [centered] - Whether to center the title text (default: true)
  /// * [length] - The total width of the frame (default: 80)
  /// * [style] - The border style to use (default: rounded)
  /// * [linesBefore] - Number of blank lines before the frame (default: 2)
  /// * [linesAfter] - Number of blank lines after the frame (default: 1)
  /// * [color] - The color to apply to the frame (default: lightCyan)
  void frame(
    String title, {
    bool centered = true,
    int length = 80,
    LoggerBorderStyle style = LoggerBorderStyle.rounded,
    int linesBefore = 2,
    int linesAfter = 1,
    AnsiCode color = lightCyan,
  }) {
    final topLeft = LoggerBorder.getChar(style, BorderPart.topLeft);
    final topRight = LoggerBorder.getChar(style, BorderPart.topRight);
    final bottomLeft = LoggerBorder.getChar(style, BorderPart.bottomLeft);
    final bottomRight = LoggerBorder.getChar(style, BorderPart.bottomRight);
    final horizontal = LoggerBorder.getChar(style, BorderPart.horizontal);
    final vertical = LoggerBorder.getChar(style, BorderPart.vertical);

    // Calculate title positioning
    final titleLength = title.length;
    final contentWidth = length - 2; // Subtract 2 for left and right borders
    String titleLine;

    if (centered) {
      final padding = (contentWidth - titleLength) ~/ 2;
      titleLine = ' ' * padding + title;
      // Add extra padding if needed to reach full length
      titleLine = titleLine.padRight(contentWidth);
    } else {
      // For non-centered, add a single space before the title
      titleLine = ' $title';
      titleLine = titleLine.padRight(contentWidth);
    }

    // Print the box with extra spacing for emphasis
    nextLine(count: linesBefore);
    info(color.wrap('$topLeft${horizontal * contentWidth}$topRight'));
    info(color.wrap('$vertical$titleLine$vertical'));
    info(color.wrap('$bottomLeft${horizontal * contentWidth}$bottomRight'));
    nextLine(count: linesAfter);
  }
}
