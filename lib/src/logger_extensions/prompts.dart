import 'dart:io' show stdin, stdout;

import 'package:mason/mason.dart';
import 'package:mason_logger_extension/mason_logger_extension.dart';

/// Extension on [Logger] that provides various prompting utilities for
/// interactive command line interfaces.
///
/// These methods enhance the base [Logger] functionality by adding support for:
/// * Default values in prompts
/// * Boolean prompts (yes/no questions)
/// * String input with various options
/// * Multi-line text input
/// * Enum selection
/// * Generic option selection
extension LoggerExtensionPrompts on Logger {
  /// Prompts the user for input with an optional default value.
  ///
  /// Example:
  /// ```dart
  /// final name = logger.promptWithDefault(
  ///   'What is your name?',
  ///   defaultValue: 'Guest',
  ///   showDefaultInAnswer: true,
  /// );
  /// ```
  ///
  /// Parameters:
  /// * [message] - The prompt message to display
  /// * [defaultValue] - Value to use if user input is empty
  /// * [hidden] - Whether to hide user input (useful for passwords)
  /// * [showDefaultInAnswer] - Whether to show "(default)" when default value is used
  String promptWithDefault(
    String message, {
    String? defaultValue,
    bool hidden = false,
    bool showDefaultInAnswer = false,
  }) {
    final resolvedMessage = message;
    stdout.write(resolvedMessage);

    final input =
        hidden ? stdin.readLineSync()?.trim() : stdin.readLineSync()?.trim();

    final response =
        (input == null || input.isEmpty) ? defaultValue ?? '' : input;

    // Clear the previous line
    stdout.write('\x1b[A\u001B[2K');

    // Print the question with the answer
    if (showDefaultInAnswer && (input == null || input.isEmpty)) {
      // If using default value, show it in a different style
      stdout.writeln(
        '$resolvedMessage${styleDim.wrap(lightCyan.wrap(response))} ${darkGray.wrap('(default)')}',
      );
    } else {
      // Otherwise just show the response
      stdout.writeln(
        '$resolvedMessage${styleDim.wrap(lightCyan.wrap(response))}',
      );
    }

    return response;
  }

  /// Prompts the user for a yes/no response.
  ///
  /// Example:
  /// ```dart
  /// if (logger.askForBool('Do you want to continue?')) {
  ///   // User answered yes
  /// }
  /// ```
  ///
  /// Parameters:
  /// * [prompt] - The question to ask
  /// * [defaultValue] - Default boolean value if user hits enter
  /// * [symbol] - Custom symbol to use instead of '?' (default)
  /// * [color] - Custom color for the prompt
  /// * [minQuestionLength] - Minimum length for question padding
  bool askForBool(
    String prompt, {
    bool? defaultValue = false,
    String symbol = '?',
    AnsiCode color = green,
    int? minQuestionLength,
  }) {
    var effectivePrompt =
        StringAppender.questionMark(prompt, symbol: symbol, color: color);

    // Add the (y/N) or (Y/n) suffix
    if (defaultValue != null) {
      effectivePrompt += defaultValue ? ' (Y/n)' : ' (y/N)';
    }

    // Pad the prompt if minQuestionLength is specified
    if (minQuestionLength != null) {
      effectivePrompt = effectivePrompt.padRight(minQuestionLength);
    }

    // Add a space after the prompt
    effectivePrompt += ' ';

    final defaultStr = defaultValue != null ? (defaultValue ? 'Y' : 'N') : null;
    final response = promptWithDefault(
      effectivePrompt,
      defaultValue: defaultStr,
    );

    if (response.isEmpty && defaultValue != null) {
      return defaultValue;
    }

    return response.toLowerCase() == 'y' || response.toLowerCase() == 'yes';
  }

  /// Prompts the user for a string input with various options.
  ///
  /// Example:
  /// ```dart
  /// final apiKey = logger.askForString(
  ///   'Enter your API key',
  ///   hideInput: true,
  ///   defaultValue: 'demo-key',
  /// );
  /// ```
  ///
  /// Parameters:
  /// * [prompt] - The prompt message
  /// * [enableEmpty] - Whether to allow empty input
  /// * [defaultValue] - Value to use if input is empty
  /// * [symbol] - Custom symbol to use instead of '?' (default)
  /// * [color] - Custom color for the prompt
  /// * [hideInput] - Whether to hide user input (for sensitive data)
  String askForString(
    String prompt, {
    bool enableEmpty = false,
    String? defaultValue,
    String symbol = '?',
    AnsiCode color = green,
    bool hideInput = false,
  }) {
    var effectivePrompt =
        StringAppender.questionMark(prompt, symbol: symbol, color: color);
    if (defaultValue != null) {
      effectivePrompt += ' ( default: $defaultValue )';
    }
    var response = this.prompt(effectivePrompt, hidden: hideInput);

    // We return the default value if the response is empty
    if (response.isEmpty && defaultValue != null) {
      return defaultValue;
    }

    // We keep asking for a non-empty response if we didn't enable empty
    while (!enableEmpty && response.isEmpty) {
      infoIsolated('Input cannot be empty. Retry.'.toLightYellow);
      response = this.prompt(prompt, hidden: hideInput);
    }

    return response;
  }

  /// Prompts the user for multi-line text input.
  ///
  /// The input is terminated when the user enters two consecutive empty lines.
  ///
  /// Example:
  /// ```dart
  /// final description = logger.askForMultilineString(
  ///   'Enter project description',
  /// );
  /// ```
  ///
  /// Parameters:
  /// * [prompt] - The prompt message
  /// * [symbol] - Custom symbol to use instead of '?' (default)
  /// * [color] - Custom color for the prompt
  String askForMultilineString(
    String prompt, {
    String symbol = '?',
    AnsiCode color = green,
  }) {
    info(StringAppender.questionMark(prompt, symbol: symbol, color: color));
    info('Enter your input (press Enter two times to finish):');

    final lines = <String>[];
    String? line;

    while ((line = stdin.readLineSync()) != null) {
      if (line!.trim().isEmpty && lines.isNotEmpty) {
        break;
      }
      if (line.trim().isNotEmpty) {
        lines.add(line.trim());
      }
    }

    if (lines.isEmpty) {
      err('\nInput cannot be empty. Retry.\n');
      return askForMultilineString(prompt, symbol: symbol, color: color);
    }

    return lines.join('\n');
  }

  /// Prompts the user to select one option from a list of strings.
  ///
  /// Example:
  /// ```dart
  /// final choice = logger.askForEnum(
  ///   'Select a color',
  ///   ['red', 'green', 'blue'],
  /// );
  /// ```
  ///
  /// Parameters:
  /// * [prompt] - The prompt message
  /// * [options] - List of string options to choose from
  /// * [symbol] - Custom symbol to use instead of '?' (default)
  /// * [color] - Custom color for the prompt
  String askForEnum(
    String prompt,
    List<String> options, {
    String symbol = '?',
    AnsiCode color = green,
  }) {
    final response = chooseOne(
      StringAppender.questionMark(prompt, symbol: symbol, color: color),
      choices: options,
    );
    return response;
  }

  /// Prompts the user to select one item from a list of generic type [T].
  ///
  /// Example:
  /// ```dart
  /// final user = logger.askForOne(
  ///   'Select a user',
  ///   users,
  ///   displayFunction: (user) => user.name,
  /// );
  /// ```
  ///
  /// Parameters:
  /// * [prompt] - The prompt message
  /// * [options] - List of options to choose from
  /// * [symbol] - Custom symbol to use instead of '?' (default)
  /// * [color] - Custom color for the prompt
  /// * [displayFunction] - Optional function to convert T to display string
  T askForOne<T>(
    String prompt,
    List<T> options, {
    String symbol = '?',
    AnsiCode color = green,
    String Function(T)? displayFunction,
  }) {
    return chooseOne<T>(
      StringAppender.questionMark(prompt, symbol: symbol, color: color),
      choices: options,
      display: displayFunction,
    );
  }

  /// Prompts the user to select one value from a list of enum values.
  ///
  /// Example:
  /// ```dart
  /// enum Color { red, green, blue }
  /// final color = logger.askForEnumValue(
  ///   'Select a color',
  ///   Color.values,
  /// );
  /// ```
  ///
  /// Parameters:
  /// * [prompt] - The prompt message
  /// * [options] - List of enum values to choose from
  /// * [symbol] - Custom symbol to use instead of '?' (default)
  /// * [color] - Custom color for the prompt
  /// * [displayFunction] - Optional function to convert enum to display string
  T askForEnumValue<T extends Enum>(
    String prompt,
    List<T> options, {
    String symbol = '?',
    AnsiCode color = green,
    String Function(T)? displayFunction,
  }) {
    final stringOptions =
        options.map((e) => displayFunction?.call(e) ?? e.name).toList();
    final response = chooseOne(
      StringAppender.questionMark(prompt, symbol: symbol, color: color),
      choices: stringOptions,
    );
    return options[stringOptions.indexOf(response)];
  }
}
