import 'dart:math';

import 'package:mason/mason.dart';

/// Defines the alignment options for table content.
///
/// Used to specify how text should be aligned within table cells.
enum TableContentAlign {
  /// Aligns text to the left side of the cell
  left,

  /// Centers text within the cell
  center,

  /// Aligns text to the right side of the cell
  right,
}

/// Extension methods for [Logger] to display formatted tables in the terminal.
///
/// This extension provides functionality to create beautiful ASCII tables with:
/// * Unicode box-drawing characters
/// * Customizable column widths
/// * Text alignment options
/// * Colored headers
/// * Automatic content padding
extension LoggerExtensionTable on Logger {
  /// Prints a formatted table with the given headers and rows.
  ///
  /// Creates a table using Unicode box-drawing characters with support for
  /// custom styling and formatting options.
  ///
  /// Example:
  /// ```dart
  /// logger.printTable(
  ///   headers: ['Name', 'Age', 'City'],
  ///   rows: [
  ///     ['John', '25', 'New York'],
  ///     ['Alice', '30', 'London'],
  ///   ],
  ///   headerColors: [cyan, cyan, cyan],
  ///   columnAlignments: [
  ///     TableContentAlign.left,
  ///     TableContentAlign.right,
  ///     TableContentAlign.center,
  ///   ],
  /// );
  /// ```
  ///
  /// [headers] The column headers for the table
  /// [rows] The data rows to display
  /// [columnWidths] Optional fixed widths for each column
  /// [headerColors] Optional colors for each header
  /// [columnAlignments] Optional alignment settings for each column
  /// [contentPadding] Number of spaces to pad content (defaults to 2)
  ///
  /// Throws [AssertionError] if:
  /// * Column widths length doesn't match headers length
  /// * Any row has a different number of columns than headers
  void printTable({
    required List<String> headers,
    required List<List<String>> rows,
    List<int>? columnWidths,
    List<AnsiCode>? headerColors,
    List<TableContentAlign>? columnAlignments,
    int contentPadding = 2,
  }) {
    assert(
      columnWidths == null || headers.length == columnWidths.length,
      'Headers and column widths must have the same length',
    );
    assert(
      rows.every((row) => row.length == headers.length),
      'All rows must have the same number of columns as headers',
    );

    // Compute effective column widths
    final effectiveColumnWidths =
        List<int>.from(columnWidths ?? List.filled(headers.length, 0));

    for (var i = 0; i < headers.length; i++) {
      if (effectiveColumnWidths[i] <= 0) {
        // Get max content length for this column
        var maxLength = headers[i].length;
        for (final row in rows) {
          final contentLength =
              row[i].replaceAll(RegExp(r'\x1B\[[0-9;]*m'), '').length;
          maxLength = max(maxLength, contentLength);
        }
        effectiveColumnWidths[i] = maxLength + contentPadding;
      }
    }

    // Box drawing characters
    const topLeft = '╭';
    const topRight = '╮';
    const bottomLeft = '╰';
    const bottomRight = '╯';
    const horizontal = '─';
    const vertical = '│';
    const teeDown = '┬';
    const teeUp = '┴';
    const teeRight = '├';
    const teeLeft = '┤';
    const cross = '┼';

    // Create horizontal lines
    final topLine =
        '$topLeft${_createIntersectedLine(effectiveColumnWidths, horizontal, teeDown)}$topRight';
    final middleLine =
        '$teeRight${_createIntersectedLine(effectiveColumnWidths, horizontal, cross)}$teeLeft';
    final bottomLine =
        '$bottomLeft${_createIntersectedLine(effectiveColumnWidths, horizontal, teeUp)}$bottomRight';

    // Style headers with provided colors or default to cyan
    final effectiveColors = headerColors ?? List.filled(headers.length, cyan);
    final effectiveAlignments = columnAlignments ??
        List.filled(headers.length, TableContentAlign.center);
    final styledHeaders = headers
        .asMap()
        .entries
        .map((e) => effectiveColors[e.key].wrap(e.value))
        .toList();

    // Print table
    this
      ..info(topLine)
      ..info(
        '$vertical ${styledHeaders.asMap().entries.map((e) {
          final text = e.value!;
          final width = effectiveColumnWidths[e.key];
          return _padText(text, width, effectiveAlignments[e.key]);
        }).join(' $vertical ')} $vertical',
      )
      ..info(middleLine);

    // Print rows with separators
    final lastIndex = rows.length - 1;
    for (var i = 0; i < rows.length; i++) {
      final row = rows[i];
      info(
        '$vertical ${row.asMap().entries.map((e) {
          final text = e.value;
          final width = effectiveColumnWidths[e.key];
          return _padText(text, width, effectiveAlignments[e.key]);
        }).join(' $vertical ')} $vertical',
      );

      // Add separator line between rows, but not after the last row
      if (i != lastIndex) {
        info(middleLine);
      }
    }

    info(bottomLine);
  }

  /// Pads text according to the specified alignment and width.
  ///
  /// [text] The text to pad
  /// [width] The desired width after padding
  /// [align] The alignment to use for padding
  String _padText(String text, int width, TableContentAlign align) {
    return switch (align) {
      TableContentAlign.left => _padRight(text, width),
      TableContentAlign.right => _padLeft(text, width),
      TableContentAlign.center => _padCenter(text, width),
    };
  }

  /// Left-pads text with spaces to reach the specified width.
  ///
  /// Accounts for ANSI color codes when calculating visible length.
  String _padLeft(String text, int width) {
    final visibleLength = text.replaceAll(RegExp(r'\x1B\[[0-9;]*m'), '').length;
    final padding = width - visibleLength;
    return '${' ' * padding}$text';
  }

  /// Right-pads text with spaces to reach the specified width.
  ///
  /// Accounts for ANSI color codes when calculating visible length.
  String _padRight(String text, int width) {
    final visibleLength = text.replaceAll(RegExp(r'\x1B\[[0-9;]*m'), '').length;
    final padding = width - visibleLength;
    return '$text${' ' * padding}';
  }

  /// Center-pads text with spaces to reach the specified width.
  ///
  /// Accounts for ANSI color codes when calculating visible length.
  String _padCenter(String text, int width) {
    final visibleLength = text.replaceAll(RegExp(r'\x1B\[[0-9;]*m'), '').length;
    final padding = width - visibleLength;
    final left = padding ~/ 2;
    final right = padding - left;
    return '${' ' * left}$text${' ' * right}';
  }

  /// Creates a horizontal line with intersections for the table border.
  ///
  /// [widths] The widths of each column
  /// [line] The character to use for the horizontal line
  /// [intersection] The character to use at column intersections
  String _createIntersectedLine(
    List<int> widths,
    String line,
    String intersection,
  ) {
    return widths.map((w) => line * (w + 2)).join(intersection);
  }
}
