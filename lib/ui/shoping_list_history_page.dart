import 'dart:async';

import 'package:coin_balance_calculator/http/item_service.dart';
import 'package:coin_balance_calculator/model/item.dart';
import 'package:flutter/material.dart';

class ShoppingListHistoryPage extends StatefulWidget {
  @override
  _ShoppingListHistoryPageState createState() =>
      _ShoppingListHistoryPageState();
}

class _ShoppingListHistoryPageState extends State<ShoppingListHistoryPage> {
  StreamController<List<Item>> _streamController = StreamController();
  ItemService _itemService;
  final ScrollController _controller = ScrollController();
  int _currentPage = 0;

  List<Item> _items = List<Item>();

  @override
  void initState() {
    _itemService = ItemService();

    _fetchArchive(_currentPage);

    _controller.addListener(_onScrolled);

    super.initState();
  }

  Future<void> _fetchArchive(int page) async {
    int take = 20;

    List<Item> items =
        await _itemService.fetchArchive(take, take * page) as List<Item>;

    if (items.length == 0) return;

    _items.addAll(items);

    if (_streamController.isClosed) {
      _streamController = StreamController();
    }
    
    _streamController.add(_items);
  }

  @override
  void dispose() {
    _streamController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text("Shopping List History"),
        ),
        Expanded(
            child: StreamBuilder<List<Item>>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.done:
                    case ConnectionState.none:
                      return Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snapshot.data.length == 0) {
                        return Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(16),
                          child: Text("Archive is empty"),
                        );
                      }

                      return ListView.builder(
                          controller: _controller,
                          padding: EdgeInsets.all(0),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = snapshot.data[index];

                            return ListTile(
                              title: Text(item.name),
                            );
                          });
                      break;
                  }

                  return Center(child: CircularProgressIndicator());
                }))
      ],
    );
  }

  void _onScrolled() {
    if (_controller.position.maxScrollExtent == _controller.position.pixels) {
      _currentPage += 1;

      _fetchArchive(_currentPage);
    }
  }
}
