import 'package:mason/mason.dart';

/// Extension methods for [Logger] to provide additional logging functionality.
///
/// This extension adds various utility methods for formatted logging, including:
/// * Checkmarks and X-marks for success/failure indicators
/// * Isolated messages with newline spacing
/// * Prefixed messages with optional color and padding
extension LoggerExtensionBase on Logger {
  /// Logs a message with a green checkmark (✓) prefix.
  ///
  /// Example:
  /// ```dart
  /// logger.checkmark('Task completed'); // Prints: ✓ Task completed
  /// ```
  ///
  /// [message] The message to log
  /// [prefix] Optional prefix to add before the checkmark
  void checkmark(String message, {String prefix = ''}) {
    info(prefix + green.wrap('✓ ')! + message);
  }

  /// Logs a message with a red X-mark (✗) prefix.
  ///
  /// Example:
  /// ```dart
  /// logger.xmark('Task failed'); // Prints: ✗ Task failed
  /// ```
  ///
  /// [message] The message to log
  /// [prefix] Optional prefix to add before the x-mark
  void xmark(String message, {String prefix = ''}) {
    info(prefix + red.wrap('✗ ')! + message);
  }

  /// Adds one or more empty lines to the log output.
  ///
  /// [count] The number of empty lines to add (defaults to 1)
  void nextLine({int count = 1}) {
    for (var i = 0; i < count; i++) {
      info('');
    }
  }

  /// Logs a message with optional empty lines before and after.
  ///
  /// Useful for isolating important messages in the log output.
  ///
  /// [message] The message to log
  /// [before] Whether to add an empty line before the message (defaults to true)
  /// [after] Whether to add an empty line after the message (defaults to true)
  void infoIso(
    String message, {
    bool before = true,
    bool after = true,
  }) {
    if (before) {
      nextLine();
    }
    info(message);
    if (after) {
      nextLine();
    }
  }

  /// Logs an error message with empty lines before and after.
  ///
  /// The message is prefixed with a '!' character.
  ///
  /// [message] The error message to log
  void error(String message) {
    this
      ..nextLine()
      ..err('! $message')
      ..nextLine();
  }

  /// Logs a message with a colored prefix and optional padding.
  ///
  /// Example:
  /// ```dart
  /// logger.infoPrefixed('Status', prefix: '→', minLength: 20, suffix: '[OK]');
  /// ```
  ///
  /// [message] The message to log
  /// [prefix] A string to prefix the message with (defaults to empty)
  /// [color] The color to apply to the prefix (defaults to green)
  /// [minLength] Optional minimum length for padding the message
  /// [suffix] Optional suffix to add after padding (if minLength is specified)
  void infoPrefixed(
    String message, {
    String prefix = '',
    AnsiCode? color,
    int? minLength,
    String? suffix,
  }) {
    var effectiveMessage = (color ?? green).wrap('$prefix ')! + message;

    if (minLength != null) {
      effectiveMessage = effectiveMessage.padRight(minLength);
      if (suffix != null) {
        effectiveMessage += suffix;
      }
    }

    info(effectiveMessage);
  }
}
