# Shell Executor

A cross-platform utility for executing shell commands in Dart/Flutter apps.![Pub Version]

(https://img.shields.io/pub/v/flutter_shell.svg)
![Build Status](https://img.shields.io/github/workflow/status/ihdatech/flutter_shell/Dart%20CI)
![License](https://img.shields.io/github/license/ihdatech/flutter_shell)

---

## 🔧 Features

- Supports Windows (`powershell` / `cmd.exe`)
- Supports macOS/Linux (`zsh`, `bash`, `sh`)
- Gracefully rejects execution on Android/iOS with a clear message
- Executes multiple commands sequentially with `&&` chaining
- Returns trimmed standard output or detailed error messages
- Simple static method API for quick integration

---

## 🚀 Usage

```dart
import 'package:flutter_shell/flutter_shell.dart';

void main() async {
  final result = await ShellExecutor.executeCommands([
    'echo Hello',
    'echo World',
  ]);

  print(result);
}
````

---

## 🧩 API Reference

### `ShellExecutor.executeCommands`

```dart
static Future<String> executeCommands(List<String> commands)
```

* Executes the provided list of shell commands sequentially in a platform-appropriate shell.
* Returns a `Future<String>` which is:

  * The trimmed standard output (`stdout`) on success.
  * An error message string prefixed with ❌ on failure.
  * A platform-specific unsupported message on mobile platforms.

---

## 🛠️ Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_shell: ^0.0.1
```

Then run:

```bash
flutter pub get
```

---

## 📂 Example

Example CLI usage in `bin/main.dart`:

```dart
import 'package:flutter_shell/flutter_shell.dart';

Future<void> main() async {
  print('🚀 Running ShellExecutor from terminal...\n');

  final result = await ShellExecutor.executeCommands([
    'echo Hello',
    'echo from flutter_shell!',
  ]);

  print('🔧 Command output:\n$result');
}
```

---

## ⚠️ Supported Platforms

* Windows, macOS, Linux
* **Not supported:** Android and iOS (returns an error message)

---

## 💰 Support

If you find this project helpful, consider [sponsoring me on GitHub](https://github.com/sponsors/ihdatech) 💖

---

## 🤝 Contributing

Contributions and suggestions are welcome! Feel free to open issues or submit pull requests.

---

## 📄 License

MIT License © 2025 Your Name

---

## 📬 Contact

GitHub: [https://github.com/ihdatech/flutter_shell](https://github.com/ihdatech/flutter_shell)
