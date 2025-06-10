import 'package:flutter/material.dart';
import 'package:flutter_shell/flutter_shell.dart';

/// A simple Flutter app demonstrating the use of `ShellExecutor` to run
/// shell commands on desktop platforms (Windows, macOS, Linux).
///
/// This app executes two shell commands (`echo Hello` and `echo from ShellExecutor!`)
/// during initialization and displays the combined output in the UI.
///
/// ## Platform Support
/// - ✅ **Windows, macOS, Linux:** Shell commands executed normally.
/// - ❌ **Android, iOS:** Execution is not supported. An error message will be displayed.
///
/// ## How It Works
/// - `ShellExecutor.executeCommands()` is called before `runApp()` to ensure
///   the command finishes executing before the UI loads.
/// - The output is passed to the widget tree and rendered as selectable text.
///
/// ## How to Run
/// ```bash
/// flutter run -d macos   # or windows / linux
/// ```
///
/// ## Example Output
/// ```text
/// Hello Ihda Mukhoyar
/// from ShellExecutor!
/// ```
void main() async {
  // Ensures that Flutter bindings are initialized before executing shell code.
  WidgetsFlutterBinding.ensureInitialized();

  // Execute shell commands and capture the output
  final result = await ShellExecutor.executeCommands(['echo Hello Ihda Mukhoyar', 'echo from ShellExecutor!']);

  // Launch the app with the result displayed in the UI
  runApp(MyApp(output: result));
}

/// Root widget of the Flutter app.
class MyApp extends StatelessWidget {
  /// The shell command output to be displayed.
  final String output;

  const MyApp({super.key, required this.output});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShellExecutor Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('ShellExecutor Example')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SelectableText(output, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
