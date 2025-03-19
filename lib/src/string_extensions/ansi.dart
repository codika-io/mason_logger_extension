/// String extension methods for handling ANSI escape sequences.
///
/// These extensions provide functionality for:
/// * Calculating visible string length by stripping ANSI escape codes
/// * Checking if a string contains ANSI formatting
/// * Other ANSI-related string operations
extension StringExtensionAnsi on String {
  /// Regular expression matching ANSI escape sequences
  static final RegExp _ansiEscapeRegExp = RegExp(r'\x1B\[[0-9;]*m');

  /// Returns the string with all ANSI escape sequences removed.
  ///
  /// This is useful when you need to work with the raw content of a string
  /// that might contain color or formatting codes.
  ///
  /// Example:
  /// ```dart
  /// final coloredText = '\x1B[31mRed text\x1B[0m';
  /// final plainText = coloredText.stripAnsi(); // 'Red text'
  /// ```
  String stripAnsi() => replaceAll(_ansiEscapeRegExp, '');

  /// Returns the visible length of the string after stripping ANSI escape sequences.
  ///
  /// This is particularly useful for text layout and alignment when the string
  /// contains color or style formatting.
  ///
  /// Example:
  /// ```dart
  /// final coloredText = '\x1B[31mRed text\x1B[0m';
  /// final length = coloredText.visibleLength; // 8, not 16
  /// ```
  int get visibleLength => stripAnsi().length;

  /// Returns true if the string contains ANSI escape sequences.
  ///
  /// This can be used to determine if a string has color or formatting applied.
  ///
  /// Example:
  /// ```dart
  /// final coloredText = '\x1B[31mRed text\x1B[0m';
  /// final hasFormatting = coloredText.hasAnsi; // true
  ///
  /// final plainText = 'Plain text';
  /// final hasFormatting = plainText.hasAnsi; // false
  /// ```
  bool get hasAnsi => _ansiEscapeRegExp.hasMatch(this);
}
