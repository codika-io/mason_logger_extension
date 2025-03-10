// ignore_for_file: cascade_invocations

import 'package:mason/mason.dart';
import 'package:mason_logger_extension/mason_logger_extension.dart';

void main() {
  final logger = Logger();

  logger.codikaLoggerExtensionExample();
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
  /// ║          Configuration            ║
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
      style: LoggerBorderStyle.doubled,
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
  /// ┌─ Details ────────────────────────┐
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
  /// ╚═════════════════════════════════════════╝
  /// ```
  ///
  /// Parameters:
  /// * [message] - The error message to display
  /// * [length] - The total width of the frame (default: 80)
  void errorSection(String message, {int length = 80}) {
    frame(
      'An Error Occurred',
      length: length,
      style: LoggerBorderStyle.doubled,
      color: red,
    );
    info(red.wrap(message));
    nextLine();
  }
}
