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
  String get toLightGreen => lightGreen.wrap(this) ?? this;

  /// Wraps the string in light red ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toLightRed => lightRed.wrap(this) ?? this;

  /// Wraps the string in light yellow ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toLightYellow => lightYellow.wrap(this) ?? this;

  /// Wraps the string in light blue ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toLightBlue => lightBlue.wrap(this) ?? this;

  /// Wraps the string in light magenta ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toLightMagenta => lightMagenta.wrap(this) ?? this;

  /// Wraps the string in light cyan ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toLightCyan => lightCyan.wrap(this) ?? this;

  /// Prefixes the string with a green checkmark (✓).
  ///
  /// Example:
  /// ```dart
  /// 'Task completed'.toCheckmarked; // Prints: ✓ Task completed
  /// ```
  String get toCheckmarked => (green.wrap('✓ ') ?? '') + this;
}
