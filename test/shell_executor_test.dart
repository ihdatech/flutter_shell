import 'dart:io';

import 'package:flutter_shell/flutter_shell.dart';
import 'package:test/test.dart';

void main() {
  group('ShellExecutor', () {
    test('returns output from a simple command', () async {
      final output = await ShellExecutor.executeCommands([Platform.isWindows ? 'echo Hello' : 'echo "Hello"']);

      expect(output, contains('Hello'));
    });

    test('handles multiple commands with &&', () async {
      final output = await ShellExecutor.executeCommands([
        Platform.isWindows ? 'echo One' : 'echo "One"',
        Platform.isWindows ? 'echo Two' : 'echo "Two"',
      ]);

      expect(output, contains('One'));
      expect(output, contains('Two'));
    });

    test('returns error for invalid command', () async {
      final output = await ShellExecutor.executeCommands(['invalid_command_xyz']);

      expect(output, contains('❌'));
    });

    test('returns not supported message on mobile platforms', () async {
      if (Platform.isAndroid || Platform.isIOS) {
        final output = await ShellExecutor.executeCommands(['echo Hello']);
        expect(output, contains('not supported'));
      }
    });
  });
}
