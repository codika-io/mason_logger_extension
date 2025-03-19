import 'package:mason/mason.dart';
import 'package:mason_logger_extension/mason_logger_extension.dart';

/// Extension for [Logger] that adds titled separator functionality.
///
/// This extension provides methods to create horizontal separators
/// with embedded titles, useful for organizing terminal output.
extension LoggerExtensionTitledSeparator on Logger {
  /// Displays a titled separator box.
  ///
  /// Creates a box with borders on all sides and the title text in the middle.
  /// The box can be aligned left, center, or right on the line.
  ///
  /// Example:
  /// ```dart
  /// // Creates a centered title box
  /// logger.titledSeparator('Section Title');
  ///
  /// // Creates a left-aligned title box
  /// logger.titledSeparator(
  ///   'Section Title',
  ///   align: TableContentAlign.left,
  ///   length: 50,
  /// );
  ///
  /// // Creates a right-aligned title box with top-corner character at the free end
  /// logger.titledSeparator(
  ///   'Section Title',
  ///   align: TableContentAlign.right,
  ///   encloseFreeSide: true, // Adds ┌ at the free end
  /// );
  /// ```
  ///
  /// [title] The title text to display
  /// [align] The alignment of the box (left, center, or right)
  /// [length] The total length of the separator line
  /// [titlePadding] Number of spaces to pad the title text
  /// [borderStyle] The style of border to use
  /// [borderColor] The color of the border characters
  /// [encloseFreeSide] Whether to enclose the free side(s) of the bottom line with top-corner characters (┌/┐)
  void titledSeparator(
    String title, {
    TableContentAlign align = TableContentAlign.center,
    int length = 80,
    int titlePadding = 2,
    LoggerBorderStyle borderStyle = LoggerBorderStyle.rounded,
    AnsiCode borderColor = darkGray,
    bool encloseFreeSide = true,
  }) {
    // Get border characters
    final topLeft = borderColor.wrap(
      LoggerBorder.getChar(borderStyle, BorderPart.topLeft),
    );
    final topRight = borderColor.wrap(
      LoggerBorder.getChar(borderStyle, BorderPart.topRight),
    );
    final bottomLeft = borderColor.wrap(
      LoggerBorder.getChar(borderStyle, BorderPart.bottomLeft),
    );
    final bottomRight = borderColor.wrap(
      LoggerBorder.getChar(borderStyle, BorderPart.bottomRight),
    );
    final horizontal = borderColor.wrap(
      LoggerBorder.getChar(borderStyle, BorderPart.horizontal),
    );
    final vertical = borderColor.wrap(
      LoggerBorder.getChar(borderStyle, BorderPart.vertical),
    );
    final teeUp = borderColor.wrap(
      LoggerBorder.getChar(borderStyle, BorderPart.teeUp),
    );

    // Calculate visible title length by stripping ANSI escape sequences
    final visibleTitleLength = title.visibleLength;

    // Calculate title width including padding
    final titleWidth = visibleTitleLength + (titlePadding * 2);

    // Title box width is the title width plus the two vertical borders
    final titleBoxWidth = titleWidth + 2;

    // Ensure the line is at least as wide as the title box
    final effectiveLength = length > titleBoxWidth ? length : titleBoxWidth + 2;

    // Create the horizontal line for the title box
    final titleHorizontalLine = horizontal! * titleWidth;

    // Build the title box lines
    final titleTopLine = '$topLeft$titleHorizontalLine$topRight';
    final titleMiddleLine =
        '$vertical${_padTitleText(title, titlePadding)}$vertical';

    // Calculate alignment padding
    var alignmentPadding = '';

    switch (align) {
      case TableContentAlign.left:
        // No padding for left alignment
        alignmentPadding = '';

        // For left alignment, keep bottom left corner rounded, but use tee for right connection
        final bottomLineLength = effectiveLength - titleBoxWidth;
        final bottomLine = encloseFreeSide
            ? '$bottomLeft$titleHorizontalLine$teeUp${horizontal * (bottomLineLength - 1)}$topRight'
            : '$bottomLeft$titleHorizontalLine$teeUp${horizontal * bottomLineLength}';

        // Display the titled separator box
        this
          ..info('$alignmentPadding$titleTopLine')
          ..info('$alignmentPadding$titleMiddleLine')
          ..info('$alignmentPadding$bottomLine');

      case TableContentAlign.right:
        // Padding to right-align the box
        final paddingWidth = effectiveLength - titleBoxWidth;
        alignmentPadding = ' ' * paddingWidth;

        // For right alignment, use tee for left connection, but keep bottom right corner rounded
        final bottomLineLength = effectiveLength - titleBoxWidth;
        final bottomLine = encloseFreeSide
            ? '$topLeft${horizontal * (bottomLineLength - 1)}$teeUp$titleHorizontalLine$bottomRight'
            : '${horizontal * bottomLineLength}$teeUp$titleHorizontalLine$bottomRight';

        // Display the titled separator box
        this
          ..info('$alignmentPadding$titleTopLine')
          ..info('$alignmentPadding$titleMiddleLine')
          ..info(bottomLine); // No alignment padding for bottom line

      case TableContentAlign.center:

        // Padding to center the box
        final paddingWidth = (effectiveLength - titleBoxWidth) ~/ 2;
        alignmentPadding = ' ' * paddingWidth;

        // For center alignment, use tees for both left and right connections
        final leftLineLength = paddingWidth;
        final rightLineLength =
            effectiveLength - titleBoxWidth - leftLineLength;

        // For center alignment, we can optionally enclose both sides
        final bottomLine = encloseFreeSide
            ? '$topLeft${horizontal * (leftLineLength - 1)}$teeUp$titleHorizontalLine$teeUp${horizontal * (rightLineLength - 1)}$topRight'
            : '${horizontal * leftLineLength}$teeUp$titleHorizontalLine$teeUp${horizontal * rightLineLength}';

        // Display the titled separator box
        this
          ..info('$alignmentPadding$titleTopLine')
          ..info('$alignmentPadding$titleMiddleLine')
          ..info(bottomLine); // No alignment padding for bottom line
    }
  }

  /// Helper method to pad the title text with the specified padding
  String _padTitleText(String title, int padding) {
    final paddingStr = ' ' * padding;
    return '$paddingStr$title$paddingStr';
  }
}
