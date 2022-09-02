import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'price_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
          appBarTheme: const AppBarTheme(color: Colors.blueGrey),
          cardColor: Colors.blueGrey,
          scaffoldBackgroundColor: Colors.white),
      home: const PriceScreen(),
    );
  }
}
