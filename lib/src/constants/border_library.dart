/// Represents the visual style of borders used in logger outputs.
///
/// This enum provides different border styles that can be used when drawing
/// boxes, tables, or frames in console output:
/// * [doubled] - Uses doubled-line box drawing characters with sharp corners (╔═╗)
/// * [normal] - Uses single-line box drawing characters with sharp corners (┌─┐)
/// * [rounded] - Uses single-line box drawing characters with rounded corners (╭─╮)
/// * [heavy] - Uses bold/thick box drawing characters with sharp corners (┏━┓)
enum LoggerBorderStyle {
  /// Double-line border style
  doubled,

  /// Normal border style
  normal,

  /// Rounded border style
  rounded,

  /// Heavy border style
  heavy;
}

/// Defines the different components that make up a border in console output.
///
/// This enum represents all possible parts of a border that can be used
/// when constructing boxes, tables, or frames:
/// * Corner pieces: [topLeft], [topRight], [bottomLeft], [bottomRight]
/// * Lines: [horizontal], [vertical]
/// * Junction pieces:
///   * [teeRight] - T-junction opening to the right (├)
///   * [teeLeft] - T-junction opening to the left (┤)
///   * [teeDown] - T-junction opening downward (┬)
///   * [teeUp] - T-junction opening upward (┴)
///   * [cross] - Four-way intersection (┼)
enum BorderPart {
  /// Top left corner
  topLeft,

  /// Top right corner
  topRight,

  /// Bottom left corner
  bottomLeft,

  /// Bottom right corner
  bottomRight,

  /// Horizontal line
  horizontal,

  /// Vertical line
  vertical,

  /// T-junction opening to the right
  teeRight,

  /// T-junction opening to the left
  teeLeft,

  /// T-junction opening downward
  teeDown,

  /// T-junction opening upward
  teeUp,

  /// Four-way intersection
  cross;
}

/// A utility class that provides access to box-drawing characters for different border styles.
///
/// This class maintains a mapping of border characters for different styles and parts,
/// allowing consistent border rendering across different logger features.
///
/// Example:
/// ```dart
/// // Get the top-left corner character for a sharp border
/// final corner = LoggerBorder.getChar(LoggerBorderStyle.sharp, BorderPart.topLeft);
/// print(corner); // Prints: ╔
///
/// // Get a horizontal line character for a rounded border
/// final line = LoggerBorder.getChar(LoggerBorderStyle.rounded, BorderPart.horizontal);
/// print(line); // Prints: ─
/// ```
class LoggerBorder {
  // Box drawing characters
  static final Map<LoggerBorderStyle, Map<BorderPart, String>> _borderChars = {
    LoggerBorderStyle.doubled: {
      BorderPart.topLeft: '╔',
      BorderPart.topRight: '╗',
      BorderPart.bottomLeft: '╚',
      BorderPart.bottomRight: '╝',
      BorderPart.horizontal: '═',
      BorderPart.vertical: '║',
      BorderPart.teeRight: '╠',
      BorderPart.teeLeft: '╣',
      BorderPart.teeDown: '╦',
      BorderPart.teeUp: '╩',
      BorderPart.cross: '╬',
    },
    LoggerBorderStyle.normal: {
      BorderPart.topLeft: '┌',
      BorderPart.topRight: '┐',
      BorderPart.bottomLeft: '└',
      BorderPart.bottomRight: '┘',
      BorderPart.horizontal: '─',
      BorderPart.vertical: '│',
      BorderPart.teeRight: '├',
      BorderPart.teeLeft: '┤',
      BorderPart.teeDown: '┬',
      BorderPart.teeUp: '┴',
      BorderPart.cross: '┼',
    },
    LoggerBorderStyle.rounded: {
      BorderPart.topLeft: '╭',
      BorderPart.topRight: '╮',
      BorderPart.bottomLeft: '╰',
      BorderPart.bottomRight: '╯',
      BorderPart.horizontal: '─',
      BorderPart.vertical: '│',
      BorderPart.teeRight: '├',
      BorderPart.teeLeft: '┤',
      BorderPart.teeDown: '┬',
      BorderPart.teeUp: '┴',
      BorderPart.cross: '┼',
    },
    LoggerBorderStyle.heavy: {
      BorderPart.topLeft: '┏',
      BorderPart.topRight: '┓',
      BorderPart.bottomLeft: '┗',
      BorderPart.bottomRight: '┛',
      BorderPart.horizontal: '━',
      BorderPart.vertical: '┃',
      BorderPart.teeRight: '┣',
      BorderPart.teeLeft: '┫',
      BorderPart.teeDown: '┳',
      BorderPart.teeUp: '┻',
      BorderPart.cross: '╋',
    },
  };

  /// Returns the border character for the given [style] and [part].
  ///
  /// Parameters:
  /// * [style] - The desired border style (doubled, normal, rounded, or heavy)
  /// * [part] - The specific part of the border to retrieve
  ///
  /// Returns an empty string if the style or part is not found.
  ///
  /// Example:
  /// ```dart
  /// final topLeft = LoggerBorder.getChar(LoggerBorderStyle.doubled, BorderPart.topLeft); // Returns '╔'
  /// ```
  static String getChar(LoggerBorderStyle style, BorderPart part) {
    return _borderChars[style]?[part] ?? '';
  }
}
