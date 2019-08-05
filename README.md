# flutter_conekta

A flutter plugin to tokenize cards using [Conekta](https://www.conekta.com/)

[![pub package](https://img.shields.io/pub/v/flutter_conekta.svg)](https://pub.dartlang.org/packages/flutter_conekta)

## Installation

First, add _flutter_conekta_ as a dependency in [your pubspec.yaml file](https://flutter.io/platform-plugins/).

```
flutter_conekta: ^1.0.7+1
```

### Android

Add

```
<uses-permission android:name="android.permission.INTERNET"/>
```

before `<application>` to your app's `AndroidManifest.xml` file. This is required due to Conekta using its remote API to tokenize the card.

### iOS

For tokenizing the card information correctly, you need to add some keys to your iOS app's _Info.plist_ file, located in `<project root>/ios/Runner/Info.plist`:

- **_UIBackgroundModes_** with the **_fetch_** and **_remote-notifications_** keys - Required. Describe why your app needs to access background taks, suck talking to an external API (to tokenize the card). This is called _Required background modes_, with the keys _App download content from network_ and _App downloads content in response to push notifications_ respectively in the visual editor (since both methods aren't actually overriden, not adding this property/keys may only display a warning, but shouldn't prevent its correct usage).

  ```
  <key>UIBackgroundModes</key>
  <array>
     <string>fetch</string>
     <string>remote-notification</string>
  </array>
  ```

- **NSAppTransportSecurity** - Required since Conekta makes arbitrary loads from its API. Describe why your app needs permission to allow arbitrary loads. This is called _App Transport Security Settings_ in the visual editor.

  ```
  <key>NSAppTransportSecurity</key>
  <dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
  </dict>
  ```

## Usage

There is only one method that should be used with this package:

#### `FlutterConekta.tokenizeCard()`

Will let you tokenize a card. This receives six required parameters: the `publicKey` to specify your Conekta public key, the `cardholderName`, the `cardNumber`, the `cvv`, the `expiryMonth` and the `expiryYear`. Returns a `String` with the token representing the card.

## Currently supported features

- [x] Tokenize card using **Conekta**.

## Demo App

![Demo](https://github.com/MiguelGT98/flutter_conekta/blob/master/example/example.png)

## Example

See example app.
