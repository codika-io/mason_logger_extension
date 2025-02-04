import 'package:mason/mason.dart';

/// Extension methods for [String] to add formatted prefixes.
///
/// Provides utility methods to append special characters or symbols
/// to strings with optional color formatting.
extension LoggerStringExtensionAppender on String {
  /// Prefixes the string with a question mark symbol.
  ///
  /// Example:
  /// ```dart
  /// 'Enter your name'.questionMark(); // Prints: ? Enter your name
  /// ```
  ///
  /// [symbol] The symbol to use as prefix (defaults to '?')
  /// [color] The color to apply to the symbol (defaults to green)
  ///
  /// Returns the string with the colored symbol prefix
  String questionMark({
    String symbol = '?',
    AnsiCode color = green,
  }) {
    return StringAppender.questionMark(this, symbol: symbol, color: color);
  }
}

/// Utility class for string prefix operations.
///
/// Provides static methods to add formatted prefixes to strings.
class StringAppender {
  /// Creates a question mark prefixed string with optional styling.
  ///
  /// [prompt] The string to prefix
  /// [symbol] The symbol to use as prefix (defaults to '?')
  /// [color] The color to apply to the symbol (defaults to green)
  ///
  /// Returns the string with the colored symbol prefix
  static String questionMark(
    String prompt, {
    String symbol = '?',
    AnsiCode color = green,
  }) {
    return '${color.wrap('$symbol ')}$prompt';
  }
}
