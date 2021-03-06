import 'package:coin_balance_calculator/ui/coin_balance_page.dart';
import 'package:coin_balance_calculator/ui/transactions/transaction_list_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    _pageController.addListener(() {
      int currentIndex = _pageController.page.round();
      if (currentIndex != _selectedIndex) {
        _selectedIndex = currentIndex;

        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.folder_open,
                color: Colors.blueAccent,
              ),
              title: Text("Fiyatlar")),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("Varlıklarım")),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), title: Text("History")),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTap,

      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          TransactionListPage(),
          CoinBalancePage(),
          CoinBalancePage(),
        ],
      ),
    );
  }

  void _onTap(int value) {
    setState(() {
      _selectedIndex = value;
    });

    _pageController.jumpToPage(value);
  }
}
