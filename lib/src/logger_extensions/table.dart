import 'dart:math';

import 'package:mason/mason.dart';
import 'package:mason_logger_extension/mason_logger_extension.dart';

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
/// * Optional title
/// * Customizable border color
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
  ///   title: 'User Information',
  ///   borderColor: lightGray,
  /// );
  /// ```
  ///
  /// [headers] The column headers for the table
  /// [rows] The data rows to display
  /// [columnWidths] Optional fixed widths for each column
  /// [headerColors] Optional colors for each header
  /// [columnAlignments] Optional alignment settings for each column
  /// [contentPadding] Number of spaces to pad content (defaults to 2)
  /// [border] The border style to use for the table
  /// [borderColor] Optional color for the table border (defaults to light gray)
  /// [title] Optional title displayed above the table
  /// [stretchTitle] Whether the title box should stretch to full table width (defaults to false)
  /// [titlePadding] Number of spaces to pad the title (defaults to 4, used when stretchTitle is false)
  /// [indentation] Number of spaces to indent the table (defaults to 0)
  void table({
    required List<String> headers,
    required List<List<String>> rows,
    List<int>? columnWidths,
    List<AnsiCode>? headerColors,
    List<TableContentAlign>? columnAlignments,
    int contentPadding = 2,
    LoggerBorderStyle borderStyle = LoggerBorderStyle.rounded,
    AnsiCode borderColor = darkGray,
    String? title,
    bool stretchTitle = false,
    int titlePadding = 4,
    int indentation = 0,
  }) {
    assert(
      columnWidths == null || headers.length == columnWidths.length,
      'Headers and column widths must have the same length',
    );
    assert(
      rows.every((row) => row.length == headers.length),
      'All rows must have the same number of columns as headers',
    );

    // Create the indentation prefix
    final indent = ' ' * indentation;

    // Compute effective column widths
    final effectiveColumnWidths =
        List<int>.from(columnWidths ?? List.filled(headers.length, 0));

    for (var i = 0; i < headers.length; i++) {
      if (effectiveColumnWidths[i] <= 0) {
        // Get max content length for this column
        var maxLength = headers[i].visibleLength;
        for (final row in rows) {
          final contentLength = row[i].visibleLength;
          maxLength = max(maxLength, contentLength);
        }
        effectiveColumnWidths[i] = maxLength + contentPadding;
      }
    }

    // Get border characters from LoggerBorder
    final topLeft =
        borderColor.wrap(LoggerBorder.getChar(borderStyle, BorderPart.topLeft));
    final topRight = borderColor
        .wrap(LoggerBorder.getChar(borderStyle, BorderPart.topRight));
    final bottomLeft = borderColor
        .wrap(LoggerBorder.getChar(borderStyle, BorderPart.bottomLeft));
    final bottomRight = borderColor
        .wrap(LoggerBorder.getChar(borderStyle, BorderPart.bottomRight));
    final horizontal = borderColor
        .wrap(LoggerBorder.getChar(borderStyle, BorderPart.horizontal));
    final vertical = borderColor
        .wrap(LoggerBorder.getChar(borderStyle, BorderPart.vertical));
    final teeDown =
        borderColor.wrap(LoggerBorder.getChar(borderStyle, BorderPart.teeDown));
    final teeUp =
        borderColor.wrap(LoggerBorder.getChar(borderStyle, BorderPart.teeUp));
    final teeRight = borderColor
        .wrap(LoggerBorder.getChar(borderStyle, BorderPart.teeRight));
    final teeLeft =
        borderColor.wrap(LoggerBorder.getChar(borderStyle, BorderPart.teeLeft));
    final cross =
        borderColor.wrap(LoggerBorder.getChar(borderStyle, BorderPart.cross));

    // Create standard horizontal lines
    final topLine =
        '${topLeft!}${_createIntersectedLine(effectiveColumnWidths, horizontal!, teeDown!)}${topRight!}';
    final middleLine =
        '${teeRight!}${_createIntersectedLine(effectiveColumnWidths, horizontal, cross!)}${teeLeft!}';
    final bottomLine =
        '${bottomLeft!}${_createIntersectedLine(effectiveColumnWidths, horizontal, teeUp!)}${bottomRight!}';

    // Calculate total table width
    final totalWidth = effectiveColumnWidths.fold<int>(
          0,
          (prev, width) => prev + width,
        ) +
        // Add spacing for vertical borders (one at start, one at end, one between each column)
        (effectiveColumnWidths.length + 1) * 3 -
        2; // Adjust for the border characters counted twice in corners

    // Variables for the table top line - will be modified if title is present
    final tableTopLine = topLine;
    var skipTableTopLine = false;

    // Handle title if provided
    if (title != null) {
      if (stretchTitle) {
        // For stretched titles, make the title box exactly the same width as the table
        // The full width needed for the title content
        final titleBoxWidth = totalWidth;
        final titleHorizontalLine =
            horizontal * (titleBoxWidth - 2); // Subtract 2 for the corners

        // When stretched, the bottom of the title box becomes the top of the table
        // Use tee junctions to connect with table columns
        final titleBottomLine =
            '$teeRight${_createIntersectedLine(effectiveColumnWidths, horizontal, teeDown)}$teeLeft';

        // Skip printing the table top line since the title bottom serves as the table top
        skipTableTopLine = true;

        this
          ..info('$indent$topLeft$titleHorizontalLine$topRight')
          ..info(
            '$indent${vertical!} ${_padCenter(title, titleBoxWidth - 4)} $vertical',
          )
          ..info('$indent$titleBottomLine');
      } else {
        // For non-stretched titles, create a small box just around the title
        // and center it above the table
        // Calculate visible title length by stripping ANSI escape sequences
        final titleVisibleLength = title.visibleLength;
        final titleTextWidth = titleVisibleLength + titlePadding;
        final titleBoxWidth =
            titleTextWidth + 2; // Add 2 for the vertical borders
        final titleHorizontalLine = horizontal * titleTextWidth;

        // Calculate centering offset to perfectly align the title box with the table
        final leftSpaces = (totalWidth - titleBoxWidth) ~/ 2;
        final centeringPadding = ' ' * leftSpaces;

        // Calculate the exact space needed for the centered title text
        // This ensures we have equal padding on both sides
        final paddedTitle = _padCenter(title, titleTextWidth);

        // Print the centered, compact title box
        this
          ..info(
            '$indent$centeringPadding$topLeft$titleHorizontalLine$topRight',
          )
          ..info('$indent$centeringPadding$vertical$paddedTitle$vertical');

        // The simplest approach: create a completely new table top line
        // without using ANSI-colored components from the original line

        // Get plain characters directly from the LoggerBorder
        final plainTopLeft =
            LoggerBorder.getChar(borderStyle, BorderPart.topLeft);
        final plainTopRight =
            LoggerBorder.getChar(borderStyle, BorderPart.topRight);
        final plainHorizontal =
            LoggerBorder.getChar(borderStyle, BorderPart.horizontal);
        final plainTeeDown =
            LoggerBorder.getChar(borderStyle, BorderPart.teeDown);
        final plainTeeUp = LoggerBorder.getChar(borderStyle, BorderPart.teeUp);
        final plainCross = LoggerBorder.getChar(borderStyle, BorderPart.cross);

        // Calculate the positions where the title connects with the table
        // The left connection should be exactly under the left vertical border of the title box
        // The right connection should be exactly under the right vertical border
        // No offset adjustments needed - use exact positions
        final leftConnectPos = leftSpaces;
        final rightConnectPos = leftSpaces + titleBoxWidth - 1;

        // Build a plain uncolored top line first
        final plainTopLine = StringBuffer();

        // Add the top-left corner
        plainTopLine.write(plainTopLeft);

        // Add horizontal segments with proper connections
        var columnStart = 0;
        for (var i = 0; i < effectiveColumnWidths.length; i++) {
          final columnWidth = effectiveColumnWidths[i] + 2; // +2 for padding

          // For each position in this column
          for (var j = 0; j < columnWidth; j++) {
            final pos =
                columnStart + j + 1; // +1 because we already wrote the corner

            if (pos == leftConnectPos || pos == rightConnectPos) {
              // Title connection points
              plainTopLine.write(plainTeeUp);
            } else {
              // Regular horizontal
              plainTopLine.write(plainHorizontal);
            }
          }

          // Add column divider unless we're at the last column
          if (i < effectiveColumnWidths.length - 1) {
            final dividerPos = columnStart +
                columnWidth +
                1; // +1 for the corner we already wrote

            if (dividerPos == leftConnectPos || dividerPos == rightConnectPos) {
              // Title connection on divider
              plainTopLine.write(plainCross);
            } else {
              // Regular divider
              plainTopLine.write(plainTeeDown);
            }

            columnStart += columnWidth + 1; // +1 for the divider
          } else {
            columnStart += columnWidth;
          }
        }

        // Add the top-right corner
        plainTopLine.write(plainTopRight);

        // Now color the entire line with the border color
        final coloredTopLine = borderColor.wrap(plainTopLine.toString());

        // Replace the regular top line
        skipTableTopLine = true;
        info('$indent$coloredTopLine');
      }
    }

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
    if (!skipTableTopLine) {
      info('$indent$tableTopLine');
    }
    this
      ..info(
        '$indent${vertical!} ${styledHeaders.asMap().entries.map((e) {
          final text = e.value!;
          final width = effectiveColumnWidths[e.key];
          return _padText(text, width, effectiveAlignments[e.key]);
        }).join(' $vertical ')} $vertical',
      )
      ..info('$indent$middleLine');

    // Print rows with separators
    final lastIndex = rows.length - 1;
    for (var i = 0; i < rows.length; i++) {
      final row = rows[i];
      info(
        '$indent$vertical ${row.asMap().entries.map((e) {
          final text = e.value;
          final width = effectiveColumnWidths[e.key];
          return _padText(text, width, effectiveAlignments[e.key]);
        }).join(' $vertical ')} $vertical',
      );

      // Add separator line between rows, but not after the last row
      if (i != lastIndex) {
        info('$indent$middleLine');
      }
    }

    info('$indent$bottomLine');
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
    final visibleLength = text.visibleLength;
    final padding = width - visibleLength;
    return '${' ' * padding}$text';
  }

  /// Right-pads text with spaces to reach the specified width.
  ///
  /// Accounts for ANSI color codes when calculating visible length.
  String _padRight(String text, int width) {
    final visibleLength = text.visibleLength;
    final padding = width - visibleLength;
    return '$text${' ' * padding}';
  }

  /// Center-pads text with spaces to reach the specified width.
  ///
  /// Accounts for ANSI color codes when calculating visible length.
  String _padCenter(String text, int width) {
    final visibleLength = text.visibleLength;
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
