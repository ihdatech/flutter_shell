import 'package:flutter_shell/flutter_shell.dart';

/// Entry point for testing the `ShellExecutor` utility via terminal.
///
/// This script demonstrates how to execute a sequence of shell commands
/// in a platform-aware way using the `flutter_shell` package.
///
/// ## Platform Support
/// - **Windows:** Executes commands using PowerShell or CMD.
/// - **macOS/Linux:** Uses `/bin/zsh`, `/bin/bash`, or `sh`.
/// - **Android/iOS:** Not supported (will return an error message).
///
/// ## Example
/// Run this script from the terminal using:
///
/// ```bash
/// dart run bin/main.dart
/// ```
///
/// Expected output:
/// ```text
/// 🚀 Running ShellExecutor from terminal...
///
/// 🔧 Command output:
/// Hello Ihda Mukhoyar
/// from flutter_shell!
/// ```
Future<void> main() async {
  print('🚀 Running ShellExecutor from terminal...\n');

  final result = await ShellExecutor.executeCommands(['echo Hello Ihda Mukhoyar', 'echo from flutter_shell!']);

  print('🔧 Command output:\n$result');
}
