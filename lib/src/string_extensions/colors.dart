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

  /// Wraps the string in black ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toBlack => black.wrap(this) ?? this;

  /// Wraps the string in red ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toRed => red.wrap(this) ?? this;

  /// Wraps the string in green ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toGreen => green.wrap(this) ?? this;

  /// Wraps the string in yellow ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toYellow => yellow.wrap(this) ?? this;

  /// Wraps the string in blue ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toBlue => blue.wrap(this) ?? this;

  /// Wraps the string in magenta ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toMagenta => magenta.wrap(this) ?? this;

  /// Wraps the string in cyan ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toCyan => cyan.wrap(this) ?? this;

  /// Wraps the string in light gray ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toLightGray => lightGray.wrap(this) ?? this;

  /// Wraps the string in default foreground ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toDefaultForeground => defaultForeground.wrap(this) ?? this;

  /// Wraps the string in dark gray ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toDarkGray => darkGray.wrap(this) ?? this;

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

  /// Wraps the string in white ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toWhite => white.wrap(this) ?? this;

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

/// Extension methods for [String] to add ANSI background color formatting.
///
/// Provides convenient getters to wrap strings in various ANSI background color codes.
extension LoggerStringExtensionBackgroundColors on String {
  /// Wraps the string in black background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toBlackBackground => backgroundBlack.wrap(this) ?? this;

  /// Wraps the string in red background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toRedBackground => backgroundRed.wrap(this) ?? this;

  /// Wraps the string in green background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toGreenBackground => backgroundGreen.wrap(this) ?? this;

  /// Wraps the string in yellow background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toYellowBackground => backgroundYellow.wrap(this) ?? this;

  /// Wraps the string in blue background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toBlueBackground => backgroundBlue.wrap(this) ?? this;

  /// Wraps the string in magenta background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toMagentaBackground => backgroundMagenta.wrap(this) ?? this;

  /// Wraps the string in cyan background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toCyanBackground => backgroundCyan.wrap(this) ?? this;

  /// Wraps the string in light gray background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toLightGrayBackground => backgroundLightGray.wrap(this) ?? this;

  /// Wraps the string in default background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toDefaultBackground => backgroundDefault.wrap(this) ?? this;

  /// Wraps the string in dark gray background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toDarkGrayBackground => backgroundDarkGray.wrap(this) ?? this;

  /// Wraps the string in light red background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toLightRedBackground => backgroundLightRed.wrap(this) ?? this;

  /// Wraps the string in light green background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toLightGreenBackground => backgroundLightGreen.wrap(this) ?? this;

  /// Wraps the string in light yellow background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toLightYellowBackground =>
      backgroundLightYellow.wrap(this) ?? this;

  /// Wraps the string in light blue background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toLightBlueBackground => backgroundLightBlue.wrap(this) ?? this;

  /// Wraps the string in light magenta background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toLightMagentaBackground =>
      backgroundLightMagenta.wrap(this) ?? this;

  /// Wraps the string in light cyan background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toLightCyanBackground => backgroundLightCyan.wrap(this) ?? this;

  /// Wraps the string in white background ANSI color.
  ///
  /// Falls back to the original string if wrapping fails.
  String get toWhiteBackground => backgroundWhite.wrap(this) ?? this;
}
