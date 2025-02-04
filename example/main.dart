// ignore_for_file: cascade_invocations

import 'package:mason/mason.dart';
import 'package:mason_logger_extension/mason_logger_extension.dart';

void main() {
  final logger = Logger();

  // Basic logging with checkmarks and x-marks
  logger
    ..info('\n1. Basic Logging Examples:'.toLink)
    ..checkmark('Task completed successfully')
    ..xmark('Task failed')
    ..nextLine();

  // Frames for important sections
  logger
    ..info('2. Frames Examples:'.toLink)
    ..sectionTitle('Configuration Settings')
    ..secondaryTitle('Database Options');

  // Tables for structured data
  logger
    ..info('\n3. Table Example:'.toLink)
    ..printTable(
      headers: ['Name', 'Status', 'Priority'],
      rows: [
        ['Task 1', 'Complete'.colorLightGreen, 'High'.colorLightRed],
        ['Task 2', 'Pending'.colorLightYellow, 'Medium'.colorLightBlue],
        ['Task 3', 'In Progress'.colorLightCyan, 'Low'.colorLightMagenta],
      ],
      headerColors: [cyan, cyan, cyan],
      columnAlignments: [
        TableContentAlign.left,
        TableContentAlign.center,
        TableContentAlign.right,
      ],
    );

  // Lists with bullets and anchors
  logger
    ..info('\n4. Lists Examples:'.toLink)
    ..listBullets(
      ['First item', 'Second item', 'Third item'],
      bulletColor: cyan,
    )
    ..nextLine()
    ..listAnchors(
      ['Step 1: Initialize', 'Step 2: Configure', 'Step 3: Run'],
      style: LoggerBorderStyle.rounded,
    );

  // QR Code generation
  logger
    ..info('\n5. QR Code Example:'.toLink)
    ..displayQRCode('https://github.com/codika-io/mason_logger_extension');

  // Interactive prompts (commented out as they require user input)
  logger.info('\n6. Prompts Examples:'.toLink);
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
  logger
    ..info('\n7. String Formatting Examples:'.toLink)
    ..info('This is a success message'.colorLightGreen)
    ..info('This is an error message'.colorLightRed)
    ..info('This is a warning message'.colorLightYellow)
    ..info('Visit our website'.toLink);

  // Prompt styling
  logger
    ..info('\n8. Prompt Styling Example:'.toLink)
    ..info('Are you sure?'.questionMark())
    ..info('Continue?'.questionMark(symbol: '❓', color: cyan));

  // Different border styles
  logger
    ..info('\n9. Border Styles Example:'.toLink)
    ..generalTitle(
      'Sharp Border',
      style: LoggerBorderStyle.sharp,
      color: lightGreen,
    )
    ..generalTitle(
      'Normal Border',
      style: LoggerBorderStyle.normal,
      color: lightBlue,
    )
    ..generalTitle(
      'Rounded Border',
      color: lightMagenta,
    );
}
