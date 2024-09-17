# Y Auth Project
A Flutter package to handle the authentication

## How this project was created?
### Set up Flutter
```
export PATH="$PATH:./flutter/sdk/flutter/bin"
```

### Create the flutter package
First, run this Flutter command.
```
flutter create --template=package y_auth
```

### Create the example Android & iOS package
First, run this Flutter command in the `y_auth` package folder.
```
flutter create example --platforms=android,ios
```

Next, link the module with the example app.
Import the library in `example/pubspec.yaml`.
```
y_auth:
    path: ../
```

After that, export the classes you want to share in `lib/y_auth.dart`:
```
export 'presentation/widget/passwordless_widget.dart';
```

You can now use `passwordless_widget.dart` in the example app.
