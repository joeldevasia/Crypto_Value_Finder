import 'package:crypto_value/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'data_retriever.dart';
import 'dart:io' show Platform;

int defaultIndex = 9;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  late String fromBTC = '?';
  late String fromETH = '?';
  late String fromLTC = '?';

  CoinData coinData = CoinData();

  late String selectedCurrency = currenciesList[9];

  StatefulBuilder androidDropdown() {
    List<DropdownMenuItem<String>> list = [];
    for (String currency in currenciesList) {
      list.add(
        DropdownMenuItem(
          value: currency,
          child: Text(currency),
        ),
      );
    }
    return StatefulBuilder(
      builder: (BuildContext context, setState) => Column(
        children: [
          DropdownButton<String>(
            style: TextStyle(fontSize: 20),
            dropdownColor: Colors.blueGrey[800],
            iconEnabledColor: Colors.white,
            value: selectedCurrency,
            onChanged: (value) {
              setState(() {
                selectedCurrency = value!;
                defaultIndex = currenciesList.indexOf(value);
              });
            },
            items: list,
          ),
        ],
      ),
    );
  }

  Expanded iosPicker() {
    List<Text> list = [];
    for (String currency in currenciesList) {
      list.add(
        Text(
          currency,
          style: const TextStyle(fontSize: 20),
        ),
      );
    }
    return Expanded(
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: 9),
        onSelectedItemChanged: (int value) {
          selectedCurrency = currenciesList[value];
          defaultIndex = value;
        },
        itemExtent: 40,
        children: list,
      ),
    );
  }

  void updateUI() async {
    var currencyDataBTC = await CurrencyConverter()
        .getcurrencyData(crypto: 'BTC', fiat: selectedCurrency);
    var currencyDataETH = await CurrencyConverter()
        .getcurrencyData(crypto: 'ETH', fiat: selectedCurrency);
    var currencyDataLTC = await CurrencyConverter()
        .getcurrencyData(crypto: 'LTC', fiat: selectedCurrency);
    fromBTC = currencyDataBTC['rate'].toStringAsFixed(2) ?? 'NA';
    fromETH = currencyDataETH['rate'].toStringAsFixed(2) ?? 'NA';
    fromLTC = currencyDataLTC['rate'].toStringAsFixed(2) ?? 'NA';
    setState(() {});
    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Value Finder'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CryptoCard(name: cryptoList[0], value: fromBTC),
                CryptoCard(name: cryptoList[1], value: fromETH),
                CryptoCard(name: cryptoList[2], value: fromLTC),
              ],
            ),
          ),
          Container(
            height: 300,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            color: Colors.blueGrey,
            // child: Platform.isAndroid ? androidDropdown() : iosPicker(),
            // child: RotatedBox(quarterTurns: 1, child: iosPicker()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Platform.isAndroid ? iosPicker() : androidDropdown(),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    // style: ButtonStyle(
                    //     backgroundColor:
                    //         MaterialStateProperty.all(Colors.blueGrey)),
                    onPressed: () async {
                      context.loaderOverlay.show();
                      updateUI();
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 60),
                      child: Text(
                        'Calculate',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key? key,
    required this.value,
    required this.name,
  }) : super(key: key);

  final String value;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.lightBlue,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $name = $value ${currenciesList[defaultIndex]}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
