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
  ///   encloseFreeCorners: true, // Adds ┌ at the free end
  /// );
  /// ```
  ///
  /// [title] The title text to display
  /// [align] The alignment of the box (left, center, or right)
  /// [length] The total length of the separator line
  /// [titlePadding] Number of spaces to pad the title text
  /// [borderStyle] The style of border to use
  /// [borderColor] The color of the border characters
  /// [encloseFreeCorners] Whether to enclose the free side(s) of the bottom line with top-corner characters (┌/┐)
  /// [content] Optional content text to display below the title box using paragraphFramed
  /// [contentPadding] Horizontal padding between the frame border and content text (default: 2)
  /// [addBottomBorder] Whether to add a bottom border to the title box (default: true)
  /// [titleBoxExpand] Whether to make the title box expand across the entire width (default: false)
  /// [indentation] Number of spaces to add as indentation before each line (default: 0)
  void titledSeparator(
    String title, {
    int length = 80,
    LoggerBorderStyle borderStyle = LoggerBorderStyle.rounded,
    AnsiCode borderColor = darkGray,
    bool addBottomBorder = false,
    bool encloseFreeCorners = false,
    int titlePadding = 2,
    bool titleBoxExpand = false,
    TableContentAlign titleAlignement = TableContentAlign.center,
    String? content,
    int contentPadding = 2,
    AnsiCode contentColor = darkGray,
    AnsiCode? numberColor,
    LoggerTextAlign contentAlignement = LoggerTextAlign.left,
    int indentation = 0,
  }) {
    if (indentation <= 0) {
      // If no indentation, use the normal flow
      _titledSeparatorImpl(
        title,
        length: length,
        borderStyle: borderStyle,
        borderColor: borderColor,
        addBottomBorder: addBottomBorder,
        encloseFreeCorners: encloseFreeCorners,
        titlePadding: titlePadding,
        titleBoxExpand: titleBoxExpand,
        titleAlignement: titleAlignement,
        content: content,
        contentPadding: contentPadding,
        contentColor: contentColor,
        numberColor: numberColor,
        contentAlignement: contentAlignement,
      );
    } else {
      // Create an indented logger wrapper
      final indentedLogger = _IndentedLogger(this, indentation);

      // Use the indented logger to display the titled separator
      indentedLogger._titledSeparatorImpl(
        title,
        length: length,
        borderStyle: borderStyle,
        borderColor: borderColor,
        addBottomBorder: addBottomBorder,
        encloseFreeCorners: encloseFreeCorners,
        titlePadding: titlePadding,
        titleBoxExpand: titleBoxExpand,
        titleAlignement: titleAlignement,
        content: content,
        contentPadding: contentPadding,
        contentColor: contentColor,
        numberColor: numberColor,
        contentAlignement: contentAlignement,
      );
    }
  }

  /// The implementation of titledSeparator
  /// This is used both by the normal flow and by the indented logger wrapper
  void _titledSeparatorImpl(
    String title, {
    required int length,
    required LoggerBorderStyle borderStyle,
    required AnsiCode borderColor,
    required bool addBottomBorder,
    required bool encloseFreeCorners,
    required int titlePadding,
    required bool titleBoxExpand,
    required TableContentAlign titleAlignement,
    required String? content,
    required int contentPadding,
    required AnsiCode contentColor,
    required AnsiCode? numberColor,
    required LoggerTextAlign contentAlignement,
  }) {
    final effectiveNumberColor = numberColor ?? contentColor;

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
    final teeRight = borderColor.wrap(
      LoggerBorder.getChar(borderStyle, BorderPart.teeRight),
    );
    final teeLeft = borderColor.wrap(
      LoggerBorder.getChar(borderStyle, BorderPart.teeLeft),
    );
    // Calculate visible title length by stripping ANSI escape sequences
    final visibleTitleLength = title.visibleLength;

    // Calculate title width including padding
    final titleWidth = visibleTitleLength + (titlePadding * 2);

    // Title box width is the title width plus the two vertical borders
    final titleBoxWidth = titleBoxExpand ? length - 2 : titleWidth + 2;

    // Ensure the line is at least as wide as the title box
    final effectiveLength = length > titleBoxWidth ? length : titleBoxWidth + 2;

    // Create the horizontal line for the title box
    final titleHorizontalLine = titleBoxExpand
        ? horizontal! * (effectiveLength - 2)
        : horizontal! * titleWidth;

    // Build the title box lines
    final paddedTitle = titleBoxExpand
        ? _padExpandedTitleText(title, effectiveLength - 2)
        : _padTitleText(title, titlePadding);

    final titleTopLine = '$topLeft$titleHorizontalLine$topRight';
    final titleMiddleLine = '$vertical$paddedTitle$vertical';

    // Calculate alignment padding
    var alignmentPadding = '';

    if (titleBoxExpand) {
      // When title is expanded, it always fills the entire width
      // So we show the full box without alignment padding
      this
        ..info(titleTopLine)
        ..info(titleMiddleLine);

      // Create the bottom line with tee or corner characters based on encloseFreeCorners
      final bottomLine = encloseFreeCorners
          ? '$teeRight${horizontal * (effectiveLength - 2)}$teeLeft'
          : '$bottomLeft${horizontal * (effectiveLength - 2)}$bottomRight';

      info(bottomLine);
    } else {
      // Standard behavior without expansion
      switch (titleAlignement) {
        case TableContentAlign.left:
          // No padding for left alignment
          alignmentPadding = '';

          // For left alignment, keep bottom left corner rounded, but use tee for right connection
          final bottomLineLength = effectiveLength - titleBoxWidth;
          final bottomLine = encloseFreeCorners
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
          final bottomLine = encloseFreeCorners
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
          final bottomLine = encloseFreeCorners
              ? '$topLeft${horizontal * (leftLineLength - 1)}$teeUp$titleHorizontalLine$teeUp${horizontal * (rightLineLength - 1)}$topRight'
              : '${horizontal * leftLineLength}$teeUp$titleHorizontalLine$teeUp${horizontal * rightLineLength}';

          // Display the titled separator box
          this
            ..info('$alignmentPadding$titleTopLine')
            ..info('$alignmentPadding$titleMiddleLine')
            ..info(bottomLine); // No alignment padding for bottom line
      }
    }

    // Display the content if provided, using paragraphFramed
    if (content != null && content.isNotEmpty) {
      paragraphFramed(
        content,
        width: effectiveLength,
        innerPadding: contentPadding,
        borderStyle: borderStyle,
        color: contentColor,
        borderColor: borderColor,
        numberColor: effectiveNumberColor,
        showUpperBorder: false,
        align: contentAlignement,
      );
    } else if (addBottomBorder && !titleBoxExpand) {
      // Only add the bottom border if we're not using an expanded title
      // (expanded titles already have a bottom border)
      info(
        '$bottomLeft${horizontal * (effectiveLength - 2)}$bottomRight',
      );
    }
  }

  /// Helper method to pad the title text with the specified padding
  String _padTitleText(String title, int padding) {
    final paddingStr = ' ' * padding;
    return '$paddingStr$title$paddingStr';
  }

  /// Helper method to precisely center a title in the available space
  /// Ensures equal padding on both sides, or if odd space, places the extra space on the right
  String _padExpandedTitleText(String title, int availableWidth) {
    final visibleTitleLength = title.visibleLength;
    final totalPaddingNeeded = availableWidth - visibleTitleLength;

    // Calculate left and right padding (handling odd numbers)
    final leftPadding = totalPaddingNeeded ~/ 2;
    final rightPadding = totalPaddingNeeded - leftPadding;

    return '${' ' * leftPadding}$title${' ' * rightPadding}';
  }
}

/// A wrapper for Logger that adds indentation to each line of output
class _IndentedLogger extends Logger {
  _IndentedLogger(this._baseLogger, int indentationSpaces)
      : _indentation = ' ' * indentationSpaces,
        super();
  final Logger _baseLogger;
  final String _indentation;

  @override
  void info(String? message, {String? Function(String?)? style}) {
    if (message != null) {
      _baseLogger.info('$_indentation$message', style: style);
    }
  }

  @override
  void detail(String? message, {String? Function(String?)? style}) {
    if (message != null) {
      _baseLogger.detail('$_indentation$message', style: style);
    }
  }

  @override
  void err(String? message, {String? Function(String?)? style}) {
    if (message != null) {
      _baseLogger.err('$_indentation$message', style: style);
    }
  }

  @override
  void warn(
    String? message, {
    String? Function(String?)? style,
    String tag = 'WARN',
  }) {
    if (message != null) {
      _baseLogger.warn('$_indentation$message', style: style, tag: tag);
    }
  }

  @override
  void success(String? message, {String? Function(String?)? style}) {
    if (message != null) {
      _baseLogger.success('$_indentation$message', style: style);
    }
  }

  @override
  void write(String? message) {
    if (message != null) {
      _baseLogger.write('$_indentation$message');
    }
  }
}
