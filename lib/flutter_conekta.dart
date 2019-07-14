import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// The entry point of the FlutterConekta SDK.
class FlutterConekta {
  static const MethodChannel _channel = const MethodChannel('flutter_conekta');

  /// Creates a token for a card which is ready
  /// to process using Conekta API.
  ///
  /// Errors:
  ///   • `ERROR_UNABLE_TO_TOKENIZE` - Indicates that the token could not be created.
  static Future<String> tokenizeCard({
    @required String publicKey,
    @required String cardholderName,
    @required String cardNumber,
    @required String cvv,
    @required String expiryMonth,
    @required String expiryYear,
  }) {
    return _channel.invokeMethod('tokenizeCard', <String, String>{
      'publicKey': publicKey,
      'cardholderName': cardholderName,
      'cardNumber': cardNumber,
      'cvv': cvv,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear
    });
  }
}
