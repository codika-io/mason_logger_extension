import 'package:mason/mason.dart';
import 'package:mason_logger_extension/mason_logger_extension.dart';
import 'package:qr/qr.dart';

/// Extension methods for [Logger] to display QR codes in the terminal.
///
/// This extension provides functionality to render QR codes using ASCII/Unicode
/// block characters, making them scannable directly from the terminal output.
extension LoggerExtensionQR on Logger {
  /// Displays a QR code in the terminal for the given data.
  ///
  /// The QR code is rendered using Unicode block characters to create a scannable
  /// output directly in the terminal. The implementation uses a 2x2 block mapping
  /// to create a more compact and cleaner looking QR code.
  ///
  /// Example:
  /// ```dart
  /// logger.displayQRCode('https://example.com');
  /// ```
  ///
  /// [data] The string data to encode in the QR code
  /// [spacingTop] Number of empty lines to add before the QR code (defaults to 1)
  /// [spacingBottom] Number of empty lines to add after the QR code (defaults to 1)
  /// [indentation] Number of spaces to indent the QR code (defaults to 0)
  /// [centerInWidth] Total width to center the QR code within (if specified and wider than the QR code)
  void qrCode(
    String data, {
    int spacingTop = 1,
    int spacingBottom = 1,
    int indentation = 0,
    int? centerInWidth,
  }) {
    final qrCode = QrCode.fromData(
      data: data,
      errorCorrectLevel: QrErrorCorrectLevel.L,
    );

    final qrImage = QrImage(qrCode);

    // Create indentation prefix
    final indent = ' ' * indentation;

    // Calculate the actual width of the QR code in terminal characters
    // Since we're iterating through x one by one in the rendering loop,
    // the actual width is exactly qrImage.moduleCount characters
    final qrWidth = qrImage.moduleCount;

    // Calculate centering padding if centerInWidth is provided and greater than QR width
    var centeringPadding = '';
    if (centerInWidth != null && centerInWidth > qrWidth) {
      final extraSpace = centerInWidth - qrWidth;
      centeringPadding = ' ' * (extraSpace ~/ 2);
    }

    // Combined padding (indentation + centering)
    final padding = indent + centeringPadding;

    nextLine(count: spacingTop);
    for (var y = 0; y < qrImage.moduleCount; y += 2) {
      write(padding); // Apply padding at the start of each line
      for (var x = 0; x < qrImage.moduleCount; x++) {
        final topLeft = qrImage.isDark(y, x);
        final topRight =
            x + 1 < qrImage.moduleCount && qrImage.isDark(y, x + 1);
        final bottomLeft =
            y + 1 < qrImage.moduleCount && qrImage.isDark(y + 1, x);
        final bottomRight = x + 1 < qrImage.moduleCount &&
            y + 1 < qrImage.moduleCount &&
            qrImage.isDark(y + 1, x + 1);
        write(
          getBlockCharacter(topLeft, topRight, bottomLeft, bottomRight),
        );
      }
      info('');
    }
    nextLine(count: spacingBottom);
  }

  /// Determines the appropriate Unicode block character for a 2x2 QR code section.
  ///
  /// Maps a 2x2 grid of QR code modules to a single Unicode block character,
  /// creating a more compact representation of the QR code.
  ///
  /// [topLeft] Whether the top-left module is dark
  /// [topRight] Whether the top-right module is dark
  /// [bottomLeft] Whether the bottom-left module is dark
  /// [bottomRight] Whether the bottom-right module is dark
  ///
  /// Returns a Unicode block character representing the 2x2 grid state.
  static String getBlockCharacter(
    bool topLeft,
    bool topRight,
    bool bottomLeft,
    bool bottomRight,
  ) {
    return switch ((topLeft, topRight, bottomLeft, bottomRight)) {
      (false, false, false, false) => ' ',
      (true, false, false, false) => '▘',
      (false, true, false, false) => '▝',
      (true, true, false, false) => '▀',
      (false, false, true, false) => '▖',
      (true, false, true, false) => '▌',
      (false, true, true, false) => '▞',
      (true, true, true, false) => '▛',
      (false, false, false, true) => '▗',
      (true, false, false, true) => '▚',
      (false, true, false, true) => '▐',
      (true, true, false, true) => '▜',
      (false, false, true, true) => '▄',
      (true, false, true, true) => '▙',
      (false, true, true, true) => '▟',
      (true, true, true, true) => '█',
    };
  }
}
