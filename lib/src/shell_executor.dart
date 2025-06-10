import 'dart:io';

/// A utility class for executing shell commands across platforms (Windows, macOS, and Linux).
///
/// This class handles platform-specific shell differences and attempts to
/// execute the provided [commands] sequentially in a single shell session.
///
/// ### Platform Support
/// - **Windows:** Uses `powershell` if available, otherwise falls back to `cmd.exe`.
/// - **macOS / Linux:** Uses `/bin/zsh` or `/bin/bash` if available, otherwise falls back to `sh`.
/// - **Android / iOS:** Not supported; returns an error message.
///
/// The provided list of [commands] will be joined using `&&`, ensuring each command
/// runs only if the previous one succeeds.
///
/// Returns:
/// - The trimmed standard output (`stdout`) on success.
/// - A formatted error message (`stderr`) if the command fails.
/// - A platform-specific unsupported message on mobile platforms.
///
/// ### Example
/// ```dart
/// final result = await ShellExecutor.executeCommands([
///   'echo Hello',
///   'echo World',
/// ]);
/// print(result); // Output: Hello\nWorld
/// ```
class ShellExecutor {
  /// Executes a list of shell [commands] using the appropriate shell for the platform.
  ///
  /// - On **Windows**, tries `powershell`, falls back to `cmd.exe` if needed.
  /// - On **macOS/Linux**, checks for `/bin/zsh`, `/bin/bash`, then falls back to `sh`.
  /// - On **Android/iOS**, execution is not supported.
  ///
  /// Returns trimmed `stdout` if successful, or an error message if failed.
  static Future<String> executeCommands(List<String> commands) async {
    if (Platform.isAndroid || Platform.isIOS) {
      return '❌ Shell execution is not supported on mobile platforms.';
    }

    String shell;
    List<String> args;

    if (Platform.isWindows) {
      // Try PowerShell first
      final powerShellCheck = await Process.run('where', ['powershell']);
      if (powerShellCheck.exitCode == 0) {
        shell = 'powershell';
        args = ['-Command', commands.join(' && ')];
      } else {
        // Fallback to cmd.exe
        shell = 'cmd';
        args = ['/C', commands.join(' && ')];
      }
    } else {
      // For macOS and Linux
      if (File('/bin/zsh').existsSync()) {
        shell = '/bin/zsh';
      } else if (File('/bin/bash').existsSync()) {
        shell = '/bin/bash';
      } else {
        shell = 'sh'; // fallback POSIX shell
      }
      args = ['-c', commands.join(' && ')];
    }

    try {
      final result = await Process.run(shell, args);

      if (result.exitCode != 0) {
        return '❌ Error: ${result.stderr}';
      }

      return result.stdout.toString().trim();
    } catch (e) {
      return '❌ Failed to execute command: $e';
    }
  }
}
