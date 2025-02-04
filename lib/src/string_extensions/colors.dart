import 'package:mason/mason.dart';

/// Extension methods for [String] to add ANSI color formatting.
///
/// Provides convenient getters to wrap strings in various ANSI color codes
/// and special formatting like links and checkmarks.
extension LoggerStringExtensionColors on String {
  /// Formats the string as a clickable link with a link icon.
  ///
  /// Wraps the string in light cyan color and adds a 🔗 prefix.
  /// The text is also made bold.
  String get toLink => lightCyan.wrap('🔗 ${styleBold.wrap(this)}') ?? this;

  /// Wraps the string in light green ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get colorLightGreen => lightGreen.wrap(this) ?? this;

  /// Wraps the string in light red ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get colorLightRed => lightRed.wrap(this) ?? this;

  /// Wraps the string in light yellow ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get colorLightYellow => lightYellow.wrap(this) ?? this;

  /// Wraps the string in light blue ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get colorLightBlue => lightBlue.wrap(this) ?? this;

  /// Wraps the string in light magenta ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get colorLightMagenta => lightMagenta.wrap(this) ?? this;

  /// Wraps the string in light cyan ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get colorLightCyan => lightCyan.wrap(this) ?? this;

  /// Prefixes the string with a green checkmark (✓).
  ///
  /// Example:
  /// ```dart
  /// 'Task completed'.checkmarked; // Prints: ✓ Task completed
  /// ```
  String get checkmarked => (green.wrap('✓ ') ?? '') + this;
}
