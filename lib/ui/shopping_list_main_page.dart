import 'package:coin_balance_calculator/ui/coin_balance_page.dart';
import 'package:flutter/material.dart';

class ShoppingListMainPage extends StatefulWidget {
  ShoppingListMainPage({Key key}) : super(key: key);

  @override
  _ShoppingListMainPageState createState() => _ShoppingListMainPageState();
}

class _ShoppingListMainPageState extends State<ShoppingListMainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  bool animate;

  @override
  void initState() {
    animate = true;
    _tabController = TabController(vsync: this, length: 2, initialIndex: 1);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  floating: true,
                  title: Text("Bakiye"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    )
                  ],
                )
              ];
            },
            body: Column(
              children: <Widget>[
                TabBar(
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.camera),
                    ),
                    Tab(
                      text: "Chats",
                    ),
                    Tab(
                      text: "Status",
                    ),
                    Tab(
                      text: "Calls",
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        CoinBalancePage(),
                        Container(
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
