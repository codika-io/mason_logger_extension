import 'package:mason/mason.dart';
import 'package:mason_logger_extension/src/constants/border_library.dart';
import 'package:mason_logger_extension/src/string_extensions/ansi.dart';

/// Enum representing text alignment options for formatted text.
enum LoggerTextAlign {
  /// Left-aligned text (default).
  left,

  /// Right-aligned text.
  right,

  /// Center-aligned text.
  center,
}

/// Extension methods for [Logger] to provide text formatting functionality.
///
/// This extension adds utility methods for formatting and displaying
/// blocks of text in the console with controlled line wrapping.
extension LoggerExtensionTexts on Logger {
  /// Formats and logs text as a paragraph with specified width.
  ///
  /// This method wraps text to fit within the specified width, handling
  /// ANSI escape sequences correctly when calculating line breaks.
  /// When autowrap is true, single newlines are ignored and text flows continuously,
  /// except for bullet detection which still preserves line structure.
  /// Double newlines (or more) are preserved as paragraph breaks.
  ///
  /// Bullet points are automatically detected when a line starts with a dash '-'.
  /// These are formatted with proper indentation for wrapped lines.
  ///
  /// Example:
  /// ```dart
  /// logger.paragraph(
  ///   'This is a paragraph with bullet points:\n'
  ///   '- First bullet point that might wrap to the next line\n'
  ///   '- Second bullet point\n\n'
  ///   'And this is a new paragraph without bullets.',
  ///   width: 40,
  ///   indentation: 3,
  ///   align: LoggerTextAlign.left,
  ///   bulletIndentation: 2,
  ///   autowrap: true,
  /// );
  /// ```
  ///
  /// Parameters:
  /// * [text] - The text to format and log
  /// * [width] - The maximum width of each line in characters (default: 80)
  /// * [indentation] - Number of spaces to indent all paragraph text (default: 0)
  /// * [align] - Text alignment within the specified width (default: LoggerTextAlign.left)
  /// * [bulletChar] - Character to use for bullet points when detected (default: "• ")
  /// * [bulletIndentation] - Additional indentation for bullet points (default: 2)
  /// * [enableHyphenation] - Whether to enable hyphenation for long words (default: false)
  /// * [autoBullets] - Whether to automatically detect bullet points (default: true)
  /// * [autowrap] - Whether to ignore single newlines and flow text continuously (default: true)
  /// * [color] - Optional color to apply to text that doesn't already have color formatting (default: null)
  void paragraph(
    String text, {
    int width = 50,
    int indentation = 0,
    LoggerTextAlign align = LoggerTextAlign.left,
    String bulletChar = '• ', // Character to use for bullet points
    int bulletIndentation = 2,
    bool enableHyphenation = false,
    bool autoBullets = true,
    bool autowrap = true,
    AnsiCode? color = darkGray,
  }) {
    if (text.isEmpty) {
      return;
    }

    // Use the formatParagraph method to get the formatted text
    final formattedText = formatParagraph(
      text,
      width: width,
      indentation: indentation,
      align: align,
      bulletChar: bulletChar,
      bulletIndentation: bulletIndentation,
      enableHyphenation: enableHyphenation,
      autoBullets: autoBullets,
      autowrap: autowrap,
      color: color,
    );

    // Split the formatted text into lines and log each line
    final lines = formattedText.split('\n');
    for (final line in lines) {
      info(line);
    }
  }

  /// Formats and logs text as a paragraph with a frame around it.
  ///
  /// This method creates a framed paragraph with customizable horizontal and
  /// vertical padding. The width parameter refers to the width of the entire frame,
  /// not just the text within it.
  ///
  /// Example:
  /// ```dart
  /// logger.paragraphFramed(
  ///   'This is a framed paragraph with some text that will wrap to fit within the frame.',
  ///   width: 50,
  ///   innerPadding: 2,
  ///   verticalInnerPadding: 1,
  ///   borderStyle: LoggerBorderStyle.rounded,
  /// );
  /// ```
  ///
  /// This would produce a box like:
  /// ```
  /// ╭────────────────────────────────────────────────╮
  /// │                                                │
  /// │  This is a framed paragraph with some text     │
  /// │  that will wrap to fit within the frame.       │
  /// │                                                │
  /// ╰────────────────────────────────────────────────╯
  /// ```
  ///
  /// You can set different padding for top and bottom:
  /// ```dart
  /// logger.paragraphFramed(
  ///   'A paragraph with more padding at the top than at the bottom.',
  ///   topPadding: 3,
  ///   bottomPadding: 1,
  /// );
  /// ```
  ///
  /// The top and bottom borders can be selectively hidden:
  /// ```dart
  /// logger.paragraphFramed(
  ///   'A paragraph with only bottom border.',
  ///   showUpperBorder: false,
  /// );
  ///
  /// logger.paragraphFramed(
  ///   'A paragraph with only side borders.',
  ///   showUpperBorder: false,
  ///   showBottomBorder: false,
  /// );
  /// ```
  ///
  /// Parameters:
  /// * [text] - The text to format and log within the frame
  /// * [width] - The width of the entire frame in characters (default: 50)
  /// * [indentation] - Number of spaces to indent the entire frame (default: 0)
  /// * [align] - Text alignment within the frame (default: LoggerTextAlign.left)
  /// * [bulletChar] - Character to use for bullet points when detected (default: "• ")
  /// * [bulletIndentation] - Additional indentation for bullet points (default: 2)
  /// * [enableHyphenation] - Whether to enable hyphenation for long words (default: false)
  /// * [autoBullets] - Whether to automatically detect bullet points (default: true)
  /// * [autowrap] - Whether to ignore single newlines and flow text continuously (default: true)
  /// * [color] - Optional color to apply to text that doesn't already have color formatting (default: null)
  /// * [innerPadding] - Horizontal padding between the frame border and text (default: 2)
  /// * [verticalInnerPadding] - Number of empty lines above and below the text (default: 1)
  /// * [topPadding] - Number of empty lines above the text (overrides verticalInnerPadding for top)
  /// * [bottomPadding] - Number of empty lines below the text (overrides verticalInnerPadding for bottom)
  /// * [borderStyle] - Style to use for the frame border (default: LoggerBorderStyle.rounded)
  /// * [borderColor] - Optional color for the frame border (default: darkGray)
  /// * [showUpperBorder] - Whether to display the top border (default: true)
  /// * [showBottomBorder] - Whether to display the bottom border (default: true)
  void paragraphFramed(
    String text, {
    int width = 50,
    int indentation = 0,
    LoggerTextAlign align = LoggerTextAlign.left,
    String bulletChar = '• ',
    int bulletIndentation = 2,
    bool enableHyphenation = false,
    bool autoBullets = true,
    bool autowrap = true,
    AnsiCode? color = darkGray,
    AnsiCode borderColor = darkGray,
    int innerPadding = 2,
    int verticalInnerPadding = 1,
    int? topPadding,
    int? bottomPadding,
    LoggerBorderStyle borderStyle = LoggerBorderStyle.rounded,
    bool showUpperBorder = true,
    bool showBottomBorder = true,
  }) {
    if (text.isEmpty) {
      return;
    }

    // Validate padding values
    final validInnerPadding = innerPadding < 0 ? 0 : innerPadding;

    // Use separate padding values for top and bottom if provided,
    // otherwise use verticalInnerPadding for both
    final validTopPadding = (topPadding != null)
        ? (topPadding < 0 ? 0 : topPadding)
        : verticalInnerPadding;
    final validBottomPadding = (bottomPadding != null)
        ? (bottomPadding < 0 ? 0 : bottomPadding)
        : verticalInnerPadding;

    // Calculate text width (frame width minus borders and horizontal padding)
    final textWidth = width - 2 - (validInnerPadding * 2);
    if (textWidth <= 0) {
      // If the resulting width is too small, log an error and return
      err('Frame width is too small for the requested inner padding');
      return;
    }

    // Format the inner paragraph text
    final formattedText = formatParagraph(
      text,
      width: textWidth,
      align: align,
      bulletChar: bulletChar,
      bulletIndentation: bulletIndentation,
      enableHyphenation: enableHyphenation,
      autoBullets: autoBullets,
      autowrap: autowrap,
      color: color,
    );

    // Get border characters for the selected style
    final topLeft = borderColor
            .wrap(LoggerBorder.getChar(borderStyle, BorderPart.topLeft)) ??
        LoggerBorder.getChar(borderStyle, BorderPart.topLeft);
    final topRight = borderColor
            .wrap(LoggerBorder.getChar(borderStyle, BorderPart.topRight)) ??
        LoggerBorder.getChar(borderStyle, BorderPart.topRight);
    final bottomLeft = borderColor
            .wrap(LoggerBorder.getChar(borderStyle, BorderPart.bottomLeft)) ??
        LoggerBorder.getChar(borderStyle, BorderPart.bottomLeft);
    final bottomRight = borderColor
            .wrap(LoggerBorder.getChar(borderStyle, BorderPart.bottomRight)) ??
        LoggerBorder.getChar(borderStyle, BorderPart.bottomRight);
    final horizontal = borderColor
            .wrap(LoggerBorder.getChar(borderStyle, BorderPart.horizontal)) ??
        LoggerBorder.getChar(borderStyle, BorderPart.horizontal);
    final vertical = borderColor
            .wrap(LoggerBorder.getChar(borderStyle, BorderPart.vertical)) ??
        LoggerBorder.getChar(borderStyle, BorderPart.vertical);

    // Create the frame components
    final horizontalBorder = horizontal * (width - 2);
    final indent = ' ' * indentation;
    final innerPaddingStr = ' ' * validInnerPadding;
    final emptyContent = ' ' * (width - 2);

    // Log the framed paragraph
    if (showUpperBorder) {
      // Top border
      info('$indent$topLeft$horizontalBorder$topRight');
    }

    // Top vertical padding - using the top padding value
    for (var i = 0; i < validTopPadding; i++) {
      info('$indent$vertical$emptyContent$vertical');
    }

    // Content lines
    final contentLines = formattedText.split('\n');
    // Filter out empty lines
    final nonEmptyContentLines =
        contentLines.where((line) => line.trim().isNotEmpty).toList();

    for (final line in nonEmptyContentLines) {
      final contentLineLength = line.visibleLength;
      final remainingSpace =
          width - 2 - (validInnerPadding * 2) - contentLineLength;
      final rightPadding = remainingSpace > 0 ? ' ' * remainingSpace : '';
      info(
        '$indent$vertical$innerPaddingStr$line$rightPadding$innerPaddingStr$vertical',
      );
    }

    // Bottom vertical padding - using the bottom padding value
    for (var i = 0; i < validBottomPadding; i++) {
      info('$indent$vertical$emptyContent$vertical');
    }

    if (showBottomBorder) {
      // Bottom border
      info('$indent$bottomLeft$horizontalBorder$bottomRight');
    }
  }

  /// Formats text as a paragraph with specified width and returns it as a string.
  ///
  /// This method wraps text to fit within the specified width, handling
  /// ANSI escape sequences correctly when calculating line breaks.
  /// When autowrap is true, single newlines are ignored and text flows continuously,
  /// except for bullet detection which still preserves line structure.
  /// Double newlines (or more) are preserved as paragraph breaks.
  ///
  /// Bullet points are automatically detected when a line starts with a dash '-'.
  /// These are formatted with proper indentation for wrapped lines.
  ///
  /// Example:
  /// ```dart
  /// final formattedText = logger.formatParagraph(
  ///   'This is a paragraph with bullet points:\n'
  ///   '- First bullet point that might wrap to the next line\n'
  ///   '- Second bullet point\n\n'
  ///   'And this is a new paragraph without bullets.',
  ///   width: 40,
  ///   indentation: 3,
  ///   align: LoggerTextAlign.left,
  ///   bulletIndentation: 2,
  ///   autowrap: true,
  /// );
  /// print(formattedText); // Or use it any way you want
  /// ```
  ///
  /// Parameters:
  /// * [text] - The text to format
  /// * [width] - The maximum width of each line in characters (default: 80)
  /// * [indentation] - Number of spaces to indent all paragraph text (default: 0)
  /// * [align] - Text alignment within the specified width (default: LoggerTextAlign.left)
  /// * [bulletChar] - Character to use for bullet points when detected (default: "• ")
  /// * [bulletIndentation] - Additional indentation for bullet points (default: 2)
  /// * [enableHyphenation] - Whether to enable hyphenation for long words (default: false)
  /// * [autoBullets] - Whether to automatically detect bullet points (default: true)
  /// * [autowrap] - Whether to ignore single newlines and flow text continuously (default: true)
  /// * [color] - Optional color to apply to text that doesn't already have color formatting (default: null)
  ///
  /// Returns a formatted string containing the formatted paragraph text.
  String formatParagraph(
    String text, {
    int width = 50,
    int indentation = 0,
    LoggerTextAlign align = LoggerTextAlign.left,
    String bulletChar = '• ', // Character to use for bullet points
    int bulletIndentation = 2,
    bool enableHyphenation = false,
    bool autoBullets = true,
    bool autowrap = true,
    AnsiCode? color = darkGray,
  }) {
    if (text.isEmpty) {
      return '';
    }

    final buffer = StringBuffer();

    // Adjust available width for indentation
    final effectiveWidth = width - indentation;

    // Split on double newlines to preserve paragraphs
    final paragraphs = text.split(RegExp(r'\n{2,}'));

    for (var i = 0; i < paragraphs.length; i++) {
      final paragraph = paragraphs[i];

      // If paragraph is empty, add a blank line and continue
      if (paragraph.trim().isEmpty) {
        buffer.writeln();
        continue;
      }

      // Split into lines for bullet detection and/or line preservation
      final lines = paragraph.split('\n');

      // Process each logical section (either a bullet item or a continuous text block)
      var currentTextBlock = '';
      var isBulletSection = false;

      for (var lineIndex = 0; lineIndex < lines.length; lineIndex++) {
        final line = lines[lineIndex];
        final trimmedLine = line.trim();

        // Skip empty lines within a paragraph
        if (trimmedLine.isEmpty) {
          // Process any accumulated text before continuing
          if (currentTextBlock.isNotEmpty) {
            _formatTextBlockToBuffer(
              buffer,
              currentTextBlock,
              width: width,
              effectiveWidth: effectiveWidth,
              indentation: indentation,
              align: align,
              isBulletLine: isBulletSection,
              bulletChar: bulletChar,
              bulletIndentation: bulletIndentation,
              enableHyphenation: enableHyphenation,
              color: color,
            );
            currentTextBlock = '';
            isBulletSection = false;
          }
          buffer.writeln();
          continue;
        }

        // Check if this line is a bullet point
        final isBulletLine = autoBullets && trimmedLine.startsWith('-');

        // Handle bullet points as separate sections
        if (isBulletLine) {
          // Process any accumulated non-bullet text before starting a bullet
          if (currentTextBlock.isNotEmpty && !isBulletSection) {
            _formatTextBlockToBuffer(
              buffer,
              currentTextBlock,
              width: width,
              effectiveWidth: effectiveWidth,
              indentation: indentation,
              align: align,
              isBulletLine: false,
              bulletChar: bulletChar,
              bulletIndentation: bulletIndentation,
              enableHyphenation: enableHyphenation,
              color: color,
            );
            currentTextBlock = '';
          }

          // Get the text content (remove the dash for bullet points)
          final contentText = trimmedLine.substring(1).trimLeft();

          // Process this bullet point
          _formatLineToBuffer(
            buffer,
            contentText,
            width: width,
            effectiveWidth: effectiveWidth,
            indentation: indentation,
            align: align,
            bullet: bulletChar,
            isBulletLine: true,
            bulletIndentation: bulletIndentation,
            enableHyphenation: enableHyphenation,
            color: color,
          );
        } else {
          // For non-bullet lines, we either append to the current text block
          // or start a new text block based on the autowrap setting
          if (autowrap) {
            // When autowrapping, append to the current text block
            if (currentTextBlock.isNotEmpty && !isBulletSection) {
              // Add a space between lines to maintain word separation
              currentTextBlock += ' $trimmedLine';
            } else {
              // Start a new text block
              currentTextBlock = trimmedLine;
              isBulletSection = false;
            }
          } else {
            // When not autowrapping, process each line separately
            _formatLineToBuffer(
              buffer,
              trimmedLine,
              width: width,
              effectiveWidth: effectiveWidth,
              indentation: indentation,
              align: align,
              isBulletLine: false,
              bulletIndentation: bulletIndentation,
              enableHyphenation: enableHyphenation,
              color: color,
            );
          }
        }
      }

      // Process any remaining text block
      if (currentTextBlock.isNotEmpty) {
        _formatTextBlockToBuffer(
          buffer,
          currentTextBlock,
          width: width,
          effectiveWidth: effectiveWidth,
          indentation: indentation,
          align: align,
          isBulletLine: isBulletSection,
          bulletChar: bulletChar,
          bulletIndentation: bulletIndentation,
          enableHyphenation: enableHyphenation,
          color: color,
        );
      }

      // Add a blank line between paragraphs, except after the last paragraph
      if (i < paragraphs.length - 1) {
        buffer.writeln();
      }
    }

    // Get the formatted text
    var formattedText = buffer.toString();

    // First, trim any trailing newlines completely
    formattedText = formattedText.trimRight();

    // Apply trimming to remove empty lines at start and end
    formattedText = _trimEmptyLinesAtStartAndEnd(formattedText);

    return formattedText;
  }

  /// Helper method to trim empty lines at start and end of text
  String _trimEmptyLinesAtStartAndEnd(String text) {
    if (text.isEmpty) return text;

    // Split into lines
    final lines = text.split('\n');

    // Find first non-empty line
    var startIndex = 0;
    while (startIndex < lines.length && lines[startIndex].trim().isEmpty) {
      startIndex++;
    }

    // If all lines are empty, return an empty string
    if (startIndex >= lines.length) return '';

    // Find last non-empty line
    var endIndex = lines.length - 1;
    while (endIndex >= 0 && lines[endIndex].trim().isEmpty) {
      endIndex--;
    }

    // Extract the non-empty lines
    final trimmedLines = lines.sublist(startIndex, endIndex + 1);

    // Rejoin the lines
    return trimmedLines.join('\n');
  }

  /// Process a block of text, formatting it as a paragraph and adding it to the buffer.
  void _formatTextBlockToBuffer(
    StringBuffer buffer,
    String text, {
    required int width,
    required int effectiveWidth,
    required int indentation,
    required LoggerTextAlign align,
    required bool isBulletLine,
    required String bulletChar,
    required int bulletIndentation,
    required bool enableHyphenation,
    AnsiCode? color,
  }) {
    _formatLineToBuffer(
      buffer,
      text,
      width: width,
      effectiveWidth: effectiveWidth,
      indentation: indentation,
      align: align,
      bullet: isBulletLine ? bulletChar : null,
      isBulletLine: isBulletLine,
      bulletIndentation: bulletIndentation,
      enableHyphenation: enableHyphenation,
      color: color,
    );
  }

  /// Formats a single line of text with wrapping and alignment, adding it to the buffer.
  void _formatLineToBuffer(
    StringBuffer buffer,
    String text, {
    required int width,
    required int effectiveWidth,
    required int indentation,
    required LoggerTextAlign align,
    required bool isBulletLine,
    required int bulletIndentation,
    required bool enableHyphenation,
    String? bullet,
    AnsiCode? color,
  }) {
    // Calculate bullet adjustment
    final hasBullet = bullet != null && bullet.isNotEmpty;
    final bulletVisibleLength = hasBullet ? bullet.visibleLength : 0;

    // Calculate indentation for different line types
    // For bullet lines, add bulletIndentation to the base indentation
    final baseIndent =
        isBulletLine ? indentation + bulletIndentation : indentation;

    // For the first line with bullet text, use the base indent
    final firstLineIndent = baseIndent;

    // For continuation lines of a bullet item, indent to align with text after bullet
    final bulletContinuationIndent = baseIndent + bulletVisibleLength;

    // For regular text (non-bullet), all lines use the same indentation
    final regularIndent = indentation;

    // Available width for text on different lines
    final firstBulletLineWidth =
        effectiveWidth - bulletIndentation - bulletVisibleLength;
    final continuationBulletLineWidth =
        effectiveWidth - bulletIndentation - bulletVisibleLength;
    final regularLineWidth = effectiveWidth;

    // Determine the appropriate width based on line type
    final firstLineWidth =
        isBulletLine ? firstBulletLineWidth : regularLineWidth;
    final continuationLineWidth =
        isBulletLine ? continuationBulletLineWidth : regularLineWidth;

    // Split into words
    final words = text.split(' ').where((w) => w.isNotEmpty).toList();

    if (words.isEmpty) {
      // If there are no words but we have a bullet, still add the bullet
      if (hasBullet) {
        buffer.writeln(' ' * baseIndent + bullet);
      } else {
        // Add an empty line with indentation
        buffer.writeln(' ' * regularIndent);
      }
      return;
    }

    final lines = <String>[];
    var currentLine = '';
    var isFirstLine = true;

    for (var wordIndex = 0; wordIndex < words.length; wordIndex++) {
      final word = words[wordIndex];

      // Current effective width depends on line type
      final currentWidth = isFirstLine ? firstLineWidth : continuationLineWidth;

      // Check if this word needs hyphenation
      if (enableHyphenation &&
          word.visibleLength > currentWidth / 2 &&
          (currentLine.isEmpty ||
              currentLine.visibleLength + word.visibleLength + 1 >
                  currentWidth)) {
        final hyphenated = _hyphenateWord(
          word,
          currentWidth - currentLine.visibleLength - 1,
        );

        if (hyphenated.length > 1) {
          // Add the first part to the current line
          final firstPart = hyphenated.first;
          final potentialLine =
              currentLine.isEmpty ? firstPart : '$currentLine $firstPart';

          if (potentialLine.visibleLength <= currentWidth) {
            lines.add(
              _applyAlignment(
                potentialLine,
                currentWidth,
                align,
                isFirstLine
                    ? firstLineIndent
                    : (isBulletLine ? bulletContinuationIndent : regularIndent),
                isFirstLine && hasBullet ? bullet : null,
                color,
              ),
            );

            // Start a new line with the remaining parts
            for (var j = 1; j < hyphenated.length - 1; j++) {
              lines.add(
                _applyAlignment(
                  hyphenated[j],
                  continuationLineWidth,
                  align,
                  isBulletLine ? bulletContinuationIndent : regularIndent,
                  null,
                  color,
                ),
              );
            }

            // Initialize the next line with the last part
            currentLine = hyphenated.last;
            isFirstLine = false;
            continue;
          }
        }
      }

      // Normal word addition logic
      final potentialLine = currentLine.isEmpty ? word : '$currentLine $word';

      if (potentialLine.visibleLength <= currentWidth) {
        currentLine = potentialLine;
      } else {
        // Output the current line and start a new one
        lines.add(
          _applyAlignment(
            currentLine,
            currentWidth,
            align,
            isFirstLine
                ? firstLineIndent
                : (isBulletLine ? bulletContinuationIndent : regularIndent),
            isFirstLine && hasBullet ? bullet : null,
            color,
          ),
        );
        currentLine = word;
        isFirstLine = false;
      }
    }

    // Output any remaining text
    if (currentLine.isNotEmpty) {
      lines.add(
        _applyAlignment(
          currentLine,
          isFirstLine ? firstLineWidth : continuationLineWidth,
          align,
          isFirstLine
              ? firstLineIndent
              : (isBulletLine ? bulletContinuationIndent : regularIndent),
          isFirstLine && hasBullet ? bullet : null,
          color,
        ),
      );
    }

    // Add formatted lines to the buffer
    for (var i = 0; i < lines.length; i++) {
      buffer.write(lines[i]);
      // Only add newline if this is not the last line
      if (i < lines.length - 1) {
        buffer.write('\n');
      }
    }

    // Add a single newline at the end
    buffer.write('\n');
  }

  /// Breaks a long word into parts to fit within the available width.
  List<String> _hyphenateWord(String word, int availableWidth) {
    if (word.visibleLength <= availableWidth) {
      return [word];
    }

    final result = <String>[];
    var start = 0;

    while (start < word.length) {
      // Find the maximum number of characters that can fit
      var end = start;
      var visibleLength = 0;

      while (end < word.length && visibleLength < availableWidth - 1) {
        // Since we can't easily get the visible length of a substring with ANSI,
        // we need to build it incrementally
        final currentPart = word.substring(start, end + 1);
        visibleLength = currentPart.visibleLength;

        if (visibleLength < availableWidth - 1) {
          end++;
        } else {
          break;
        }
      }

      // If we couldn't fit even a single character, take one anyway
      if (end == start) {
        end = start + 1;
      }

      // Add a hyphen if this isn't the end of the word
      var part = word.substring(start, end);
      if (end < word.length) {
        part += '-';
      }

      result.add(part);
      start = end;
    }

    return result;
  }

  /// Applies alignment and indentation to a line of text.
  String _applyAlignment(
    String text,
    int width,
    LoggerTextAlign align,
    int indentation,
    String? prefix,
    AnsiCode? color,
  ) {
    final indent = ' ' * indentation;
    final prefixStr = prefix ?? '';

    // Calculate the available width after indentation and prefix
    final availableWidth = width - prefixStr.visibleLength;

    // Apply color to the text if specified and the text doesn't already have ANSI codes
    // We only apply color to portions that don't already have ANSI codes
    var coloredText = text;
    if (color != null) {
      // If the text already has ANSI codes, we need to apply color selectively
      if (text.hasAnsi) {
        // Define RegExp for matching ANSI escape sequences
        final regex = RegExp(r'\x1B\[[0-9;]*m');
        final matches = regex.allMatches(text).toList();

        if (matches.isNotEmpty) {
          var lastIndex = 0;
          final buffer = StringBuffer();

          // Keep track of active formatting codes
          final activeFormatting = <String>[];

          // Prefix for our debugging
          // print('Processing: "$text"');

          for (var i = 0; i < matches.length; i++) {
            final match = matches[i];
            final escapeSequence = text.substring(match.start, match.end);

            // For debugging
            // print('  Sequence: $escapeSequence');

            // Process any text before this escape sequence
            if (match.start > lastIndex) {
              final plainText = text.substring(lastIndex, match.start);

              // Check if we have any active color formatting
              final hasActiveColor = activeFormatting.any((code) {
                // Check if the active code is a color code
                // Color codes include: 30-37, 90-97 (foreground colors)
                //                       40-47, 100-107 (background colors)
                //                       38, 48 (extended colors)
                return RegExp(r'^\x1B\[(([34])[0-9]|9[0-7]|10[0-7]|[34]8;)')
                    .hasMatch(code);
              });

              // Apply our color only if there's no active color formatting
              if (!hasActiveColor) {
                buffer.write(color.wrap(plainText) ?? plainText);
              } else {
                buffer.write(plainText);
              }
            }

            // Process the escape sequence
            if (escapeSequence == '\x1B[0m' || escapeSequence == '\x1B[m') {
              // Reset code - clear all active formatting
              activeFormatting.clear();
            } else {
              // Add this code to our active formatting
              activeFormatting.add(escapeSequence);
            }

            // Always add the escape sequence as is
            buffer.write(escapeSequence);

            lastIndex = match.end;
          }

          // Process any remaining text after the last escape sequence
          if (lastIndex < text.length) {
            final plainText = text.substring(lastIndex);

            // Check if we have any active color formatting
            final hasActiveColor = activeFormatting.any((code) {
              return RegExp(r'^\x1B\[(([34])[0-9]|9[0-7]|10[0-7]|[34]8;)')
                  .hasMatch(code);
            });

            // Apply our color only if there's no active color formatting
            if (!hasActiveColor) {
              buffer.write(color.wrap(plainText) ?? plainText);
            } else {
              buffer.write(plainText);
            }
          }

          coloredText = buffer.toString();
        } else {
          // No matches found but hasAnsi is true, which should not happen
          // Use normal coloring as fallback
          coloredText = color.wrap(text) ?? text;
        }
      } else {
        // If no ANSI codes, apply color to the whole text
        coloredText = color.wrap(text) ?? text;
      }
    }

    // Apply alignment
    switch (align) {
      case LoggerTextAlign.right:
        final padding = availableWidth - text.visibleLength;
        return indent +
            prefixStr +
            ' ' * (padding > 0 ? padding : 0) +
            coloredText;

      case LoggerTextAlign.center:
        final padding = (availableWidth - text.visibleLength) ~/ 2;
        return indent +
            prefixStr +
            ' ' * (padding > 0 ? padding : 0) +
            coloredText;

      case LoggerTextAlign.left:
        return indent + prefixStr + coloredText;
    }
  }
}
