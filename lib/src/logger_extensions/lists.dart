import 'package:mason/mason.dart';
import 'package:mason_logger_extension/mason_logger_extension.dart';
import 'package:mason_logger_extension/src/constants/border_library.dart';

/// Extension on [Logger] that provides methods for creating formatted lists
/// in the console output.
///
/// This extension offers various ways to display lists with bullets or
/// connected items using box-drawing characters.
extension LoggerExtensionLists on Logger {
  /// Creates a bulleted list with customizable bullet points and colors.
  ///
  /// Example:
  /// ```dart
  /// logger.listBullets(['First item', 'Second item']);
  ///   • First item
  ///   • Second item
  /// ```
  ///
  /// Parameters:
  /// * [items] - The list of strings to display
  /// * [prefix] - Space or characters to add before each bullet (default: '  ')
  /// * [bullet] - The bullet character to use (default: '•')
  /// * [bulletColor] - The color to apply to the bullet (default: green)
  void infoBulletList(
    List<String> items, {
    String prefix = '  ',
    String bullet = '•',
    AnsiCode bulletColor = green,
  }) {
    for (final item in items) {
      info(prefix + (bulletColor.wrap(bullet) ?? '') + item);
    }
  }

  /// Creates a connected list where items are joined by box-drawing characters.
  ///
  /// This creates a tree-like structure where items are connected by lines,
  /// useful for showing hierarchical or sequential information.
  ///
  /// Example:
  /// ```dart
  /// logger.listAnchors(['First step', 'Second step']);
  ///   ├ First step
  ///   │
  ///   ├ Second step
  ///   │
  /// ```
  ///
  /// Parameters:
  /// * [items] - The list of strings to display
  /// * [prefix] - Space or characters to add before each line (default: '  ')
  /// * [bullet] - Optional bullet character to display after the line
  /// * [bulletColor] - The color to apply to the bullet (default: green)
  /// * [style] - The border style to use for connecting lines (default: normal)
  /// * [showLastLine] - Whether to show the vertical line after the last item (default: true)
  void infoConnectedList(
    List<String> items, {
    String prefix = '  ',
    String? bullet,
    AnsiCode bulletColor = green,
    LoggerBorderStyle style = LoggerBorderStyle.normal,
    bool showLastLine = true,
  }) {
    final teeRight = LoggerBorder.getChar(style, BorderPart.teeRight);
    final vertical = LoggerBorder.getChar(style, BorderPart.vertical);
    final bulletStr = bullet != null ? ' ${bulletColor.wrap(bullet)}' : '';

    for (var i = 0; i < items.length; i++) {
      final isLast = i == items.length - 1;
      final lineChar = isLast && !showLastLine ? teeRight : teeRight;
      final item = items[i];

      info('$prefix$lineChar$bulletStr $item');

      if (!isLast || showLastLine) {
        info('$prefix$vertical');
      }
    }
  }
}
