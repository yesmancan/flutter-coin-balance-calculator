import 'package:coin_balance_calculator/ui/main_page.dart';
import 'package:flutter/material.dart';
void main() => runApp(CryptoApp());

class CryptoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.white,
        primaryColorDark: Colors.white,
        brightness: Brightness.dark,
      ),
      home: MainPage(),
    );
  }
}
