import 'package:mason/mason.dart';

/// Extension methods for [String] to add ANSI color formatting.
///
/// Provides convenient getters to wrap strings in various ANSI color codes
/// and special formatting like links, checkmarks, and text styles.
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

  /// Wraps the string in bold ANSI style.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toBold => styleBold.wrap(this) ?? this;

  /// Wraps the string in italic ANSI style.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toItalic => styleItalic.wrap(this) ?? this;

  /// Wraps the string in underline ANSI style.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toUnderline => styleUnderlined.wrap(this) ?? this;

  /// Wraps the string in blinking ANSI style.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toBlink => styleBlink.wrap(this) ?? this;

  /// Wraps the string in dim ANSI style (reduced intensity).
  ///
  /// Falls back to the original string if wrapping fails.
  String get toDim => styleDim.wrap(this) ?? this;

  /// Wraps the string in reverse ANSI style (swaps foreground and background colors).
  ///
  /// Falls back to the original string if wrapping fails.
  String get toReverse => styleReverse.wrap(this) ?? this;

  /// Prefixes the string with a red cross mark (✗).
  ///
  /// Example:
  /// ```dart
  /// 'Task failed'.toCrossMarked; // Prints: ✗ Task failed
  /// ```
  String get toCrossMarked => (red.wrap('✗ ') ?? '') + this;

  /// Wraps the string in a box made of ASCII characters.
  ///
  /// Example:
  /// ```dart
  /// 'Hello'.toBox;
  /// // Prints:
  /// // ┌─────┐
  /// // │Hello│
  /// // └─────┘
  /// ```
  String get toBox {
    final width = length;
    final top = '┌${'─' * (width + 2)}┐';
    final middle = '│ $this │';
    final bottom = '└${'─' * (width + 2)}┘';
    return '$top\n$middle\n$bottom';
  }

  /// Creates an indented block with a vertical line prefix.
  ///
  /// Useful for displaying hierarchical or nested information.
  /// Example:
  /// ```dart
  /// 'Details'.toIndentedBlock; // Prints: │ Details
  /// ```
  String get toIndentedBlock => '│ $this';

  /// Wraps text in a warning style with a warning symbol.
  ///
  /// Example:
  /// ```dart
  /// 'Careful!'.toWarning; // Prints: ⚠️  Careful! in yellow
  /// ```
  String get toWarning => '⚠️  ${lightYellow.wrap(this) ?? this}';

  /// Wraps text in an info style with an info symbol.
  ///
  /// Example:
  /// ```dart
  /// 'Note:'.toInfo; // Prints: ℹ️  Note: in blue
  /// ```
  String get toInfo => 'ℹ️  ${lightBlue.wrap(this) ?? this}';

  /// Wraps text in a success style with a success symbol.
  ///
  /// Example:
  /// ```dart
  /// 'Done!'.toSuccess; // Prints: 🎉 Done! in green
  /// ```
  String get toSuccess => '🎉 ${lightGreen.wrap(this) ?? this}';

  /// Wraps text in an error style with an error symbol.
  ///
  /// Example:
  /// ```dart
  /// 'Failed!'.toError; // Prints: ❌ Failed! in red
  /// ```
  String get toError => '❌ ${lightRed.wrap(this) ?? this}';
}
