// ignore_for_file: cascade_invocations

import 'package:mason/mason.dart';
import 'package:mason_logger_extension/mason_logger_extension.dart';

void main() {
  final logger = Logger();

  // logger.codikaLoggerExtensionExample();

  logger.info('123456789_123456789_123456789_123456789_123456789_');

  logger.info('');
  logger.info('Mason Logger Extension Example');
  logger.info('==============================');
  logger.info('');

  logger.paragraphFramed(
    '''
This is a paragraph.
It is a block of text that is displayed in a box.
- A list item.
- Another list item.
- A longer list item that will wrap to the next line if it is too long.

It is a block of text that is displayed in a box.

It is a block of text that is displayed in a box.
It is a block of text that is displayed in a box.
''',
    innerPadding: 5,
    verticalInnerPadding: 3,
    showBottomBorder: false,
    showUpperBorder: false,
  );
  logger.paragraphFramed(
    '''
This is a paragraph.
It is a block of text that is displayed in a box.
- A list item.
- Another list item.
- A longer list item that will wrap to the next line if it is too long.

It is a block of text that is displayed in a box.

It is a block of text that is displayed in a box.
It is a block of text that is displayed in a box.
''',
  );

  logger.paragraphFramed(
    '''
This should be bold. ${'piscine blue'.toBold}
It is a block of text that is displayed in a box.
- A list item. ${'piscine blue'.toLightCyan}
- Another list item.
- A longer list item that will wrap to the next line if it is too long.


It is a block of text that is displayed in a box.
It is a block of text that is displayed in a box.

- This is a list item.
''',
  );

  logger.paragraph(
    '''
This is a paragraph.
It is a block ${'piscine blue'.toBold} of text that is displayed in a box.
It is a block of text that is displayed ${'piscine blue'.toLightCyan} in a box.

- A list item. ${'piscine blue'.toLightCyan}
- Another list item.
- A longer list item that will wrap to the next line if it is too long.
''',
  );

  // Example of titled separator with description - centered (default)
  logger.titledSeparator(
    'Centered Title',
    description:
        'This is a description for the centered title. It will be displayed in a box below the title.',
  );

  logger.info('');

  // Example of titled separator with description - left aligned
  logger.titledSeparator(
    'Left-Aligned Title',
    description:
        'This is a description for the left-aligned title.  (${'description'.toBold.toLightCyan}) It will be displayed in a box below the title.',
    align: TableContentAlign.left,
  );

  logger.info('');

  // Example of titled separator with description - right aligned
  logger.titledSeparator(
    'Right-Aligned Title',
    description:
        'This is a description for the right-aligned title. It will be displayed in a box below the title.',
    align: TableContentAlign.right,
  );

  logger.info('');

  // Example with encloseFreeSide set to false
  logger.titledSeparator(
    'Title Without Enclosed Sides',
    description:
        'This example shows how it (${'description'.toBold.toLightCyan}) looks when encloseFreeSide is set to false.',
    encloseFreeSide: false,
  );

  logger.info('');

  // Example with long description that wraps
  logger.titledSeparator(
    'Title With Long Description',
    description:
        'This is a much longer (${'description'.toBold.toLightCyan}) that will need to wrap within the box. '
        'The text should automatically wrap to fit within the box width. '
        'This demonstrates(${'description'.toBold.toLightCyan})  how the text wrapping works for longer content '
        'that exceeds the width of a single line.',
    length: 60,
  );

  logger.info('');

  // Example with colored text in description
  logger.titledSeparator(
    'Colored Text Example',
    description:
        'This description contains ${lightCyan.wrap('colored text')} in the middle of a sentence. '
        'It should wrap correctly even when the ${lightRed.wrap('colored text is near')} the end of a line. '
        'Multiple colors like ${lightGreen.wrap('green')}, ${lightYellow.wrap('yellow')}, and ${lightMagenta.wrap('magenta')} '
        'should all render correctly with proper line wrapping.',
    length: 70,
  );
}

extension LoggerExtensionFrames on Logger {
  /// Creates a primary section title with sharp borders and cyan coloring.
  ///
  /// This is typically used for main section headers in the console output.
  ///
  /// Example:
  /// ```dart
  /// logger.sectionTitle('Configuration');
  /// ╔══════════════════════════════════╗
  /// ║          Configuration            ║
  /// ╚══════════════════════════════════╝
  /// ```
  ///
  /// Parameters:
  /// * [title] - The text to display in the frame
  /// * [length] - The total width of the frame (default: 80)
  void sectionTitle(String title, {int length = 80}) {
    frame(
      title,
      length: length,
      style: LoggerBorderStyle.doubled,
      color: cyan,
    );
  }

  /// Creates a secondary title with normal borders and blue coloring.
  ///
  /// This is typically used for subsections or less prominent headers.
  ///
  /// Example:
  /// ```dart
  /// logger.secondaryTitle('Details');
  /// ┌─ Details ────────────────────────┐
  /// └──────────────────────────────────┘
  /// ```
  ///
  /// Parameters:
  /// * [title] - The text to display in the frame
  /// * [length] - The total width of the frame (default: 80)
  void secondaryTitle(String title, {int length = 80}) {
    frame(
      title,
      length: length,
      centered: false,
      style: LoggerBorderStyle.normal,
      linesBefore: 1,
      color: blue,
    );
  }

  /// Creates an error section with sharp borders and red coloring.
  ///
  /// This is used to highlight error messages in the console output.
  ///
  /// Example:
  /// ```dart
  /// logger.errorSection('Failed to connect to the server');
  /// ╔══════════ An Error Occurred ════════════╗
  /// ║  Failed to connect to the server        ║
  /// ╚═════════════════════════════════════════╝
  /// ```
  ///
  /// Parameters:
  /// * [message] - The error message to display
  /// * [length] - The total width of the frame (default: 80)
  void errorSection(String message, {int length = 80}) {
    frame(
      'An Error Occurred',
      length: length,
      style: LoggerBorderStyle.doubled,
      color: red,
    );
    info(red.wrap(message));
    nextLine();
  }
}
