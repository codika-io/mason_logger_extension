import 'package:mason/mason.dart';
import 'package:mason_logger_extension/mason_logger_extension.dart';

extension LoggerExtensionExample on Logger {
  void codikaLoggerExtensionExample() {
    // Basic logging with checkmarks and x-marks
    info('\n1. Basic Logging Examples:'.toLink);
    checkmark('Task completed successfully');
    xmark('Task failed');
    nextLine();

    // Frames for important sections
    info('2. Frames Examples:'.toLink);
    frame('Configuration Settings');
    frame('Database Options');

    // Tables for structured data
    info('\n3. Table Example:'.toLink);
    table(
      indentation: 4,
      title: 'Task List',
      headers: ['Name', 'Status', 'Priority'],
      rows: [
        ['Task 1', 'Complete'.toLightGreen, 'High'.toLightRed],
        ['Task 2', 'Pending'.toLightYellow, 'Medium'.toLightBlue],
        ['Task 3', 'In Progress'.toLightCyan, 'Low'.toLightMagenta],
      ],
      headerColors: [cyan, cyan, cyan],
      columnAlignments: [
        TableContentAlign.left,
        TableContentAlign.center,
        TableContentAlign.right,
      ],
    );
    table(
      indentation: 1,
      headers: ['Name', 'Status', 'Priority'],
      rows: [
        ['Task 1', 'Complete'.toLightGreen, 'High'.toLightRed],
        ['Task 2', 'Pending'.toLightYellow, 'Medium'.toLightBlue],
        ['Task 3', 'In Progress'.toLightCyan, 'Low'.toLightMagenta],
      ],
      title: 'Task List',
      stretchTitle: true,
    );
    table(
      indentation: 4,
      headers: ['Name', 'Status', 'Priority'],
      rows: [
        ['Task 1', 'Complete'.toLightGreen, 'High'.toLightRed],
        ['Task 2', 'Pending'.toLightYellow, 'Medium'.toLightBlue],
        ['Task 3', 'In Progress'.toLightCyan, 'Low'.toLightMagenta],
      ],
      title: 'Task List',
    );

    info('\n4. Titled Separator Example:'.toLink);
    titledSeparator(
      'Center Title ',
    );
    titledSeparator(
      'Left Title',
      description: '''
This is a paragraph containing a lot of stuf. It should return to the line automatically and show bullets :
- First item
- Second item
- Third item
''',
      align: TableContentAlign.left,
    );
    titledSeparator(
      'Right Title',
      align: TableContentAlign.right,
    );

    info('\n5. Paragraph Example:'.toLink);
    paragraph(
      '''
This is a paragraph containing a lot of stuf. It should return to the line automatically and show bullets :
- First item
- Second item
- Third item
''',
    );
    paragraph(
      '''
This is a paragraph containing a lot of stuf. It should return to the line automatically and show bullets :
- First item
- Second item
- Third item
''',
      frame: true,
    );

    // Lists with bullets and anchors
    info('\n5. Lists Examples:'.toLink);
    listBullets(
      ['First item', 'Second item', 'Third item'],
      bulletColor: cyan,
    );
    nextLine();
    listAnchors(
      ['Step 1: Initialize', 'Step 2: Configure', 'Step 3: Run'],
      style: LoggerBorderStyle.rounded,
    );

    // QR Code generation
    info('\n6. QR Code Example:'.toLink);
    qrCode('https://github.com/codika-io/mason_logger_extension');
    qrCode(
      'https://github.com/codika-io/mason_logger_extension',
      indentation: 4,
    );
    qrCode(
      'https://github.com/codika-io/mason_logger_extension',
      centerInWidth: 34,
    );

    // Interactive prompts (commented out as they require user input)
    info('\n7. Prompts Examples:'.toLink);
    // Uncomment to try interactive features:
    /*
  final name = logger.askForString('What is your name?');
  final age = logger.askForString('How old are you?');
  final likesCoding = logger.askForBool('Do you like coding?');
  final bio = logger.askForMultilineString('Tell us about yourself:');
  final favoriteColor = logger.askForEnum(
    'Choose your favorite color:',
    ['Red', 'Blue', 'Green', 'Yellow'],
  );
  */

    // String extensions for colors and formatting
    info('\n8. String Formatting Examples:'.toLink);
    info('This is a success message'.toLightGreen);
    info('This is an error message'.toLightRed);
    info('This is a warning message'.toLightYellow);
    info('Visit our website'.toLink);

    // Prompt styling
    info('\n9. Prompt Styling Example:'.toLink);
    info('Are you sure?'.questionMark());
    info('Continue?'.questionMark(symbol: '❓', color: cyan));

    // Different border styles
    info('\n10. Border Styles Example:'.toLink);
    frame(
      'Sharp Border',
      style: LoggerBorderStyle.doubled,
      color: lightGreen,
    );
    frame(
      'Normal Border',
      style: LoggerBorderStyle.normal,
      color: lightBlue,
    );
    frame(
      'Rounded Border',
      color: lightMagenta,
    );
    frame(
      'Heavy Border',
      style: LoggerBorderStyle.heavy,
      color: lightRed,
    );
  }
}
