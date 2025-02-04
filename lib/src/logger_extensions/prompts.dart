import 'dart:io' show stdin, stdout;

import 'package:mason/mason.dart';
import 'package:mason_logger_extension/mason_logger_extension.dart';

extension LoggerExtensionPrompts on Logger {
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
      err('\nInput cannot be empty. Retry.\n');
      response = this.prompt(prompt, hidden: hideInput);
    }

    return response;
  }

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

  T askForSingleEnum<T extends Enum>(
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
