import 'package:flutter/foundation.dart';

import 'networking.dart';
import 'constants.dart';

class CurrencyConverter {
  getcurrencyData({required String crypto, required String fiat}) async {
    NetworkHelper networkHelper =
        NetworkHelper('$coinAPI_URL/$crypto/$fiat?apikey=$apiKey');

    var currencyData = await networkHelper.getData();
    if (kDebugMode) {
      print("currencyData = $currencyData");
    }
    return currencyData;
  }
}
