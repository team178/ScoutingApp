# Scouting App

A scouting app for FRC Team 178 used to organize and gather information at competitions.

## Contributing

### Contributing code

Try to use pull requests as much as possible, so we can keep the commit clutter to a minimum. For this, make a fork of the repository using the `Fork` button, and commit your changes to that. You can follow [this guide](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork) for how to create a pull request from that fork.

When commiting, use `dart format` or `flutter format` to format your code, to keep it neat.

Always make sure that your code runs and works the way it should *before* you commit. Run any tests we may have. We don't want broken code.

Make sure your commit messages are descriptive enough to know what you did by just looking at it. You can read here on how to [write descriptive commit messages](https://cbea.ms/git-commit/).

### Running

The `bs.bat` script file can be used for running and building the app and server from one place on Windows. It will run `[dart|fltter] pub get`, along with the command to build or run the part.
```zsh
./bs <run|build> <app|server> [args]
```

If you don't want to use this script, or it dosen't work for you, you can use the following commands:
```zsh
dart run lib/server.dart # Run the server
flutter run # Run the app
dart compile exe lib/server.dart # Build the server
flutter build apk # Build the app as an APK file
```

The app can be run as long as Flutter and an emulator is available. You can install [Android Studio](https://developer.android.com/studio/) in order to get an emulator, so you can test the application without needing an actual android tablet. *Running the server does not require an emulator, but may require Flutter to be installed.*

### Flutter

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
