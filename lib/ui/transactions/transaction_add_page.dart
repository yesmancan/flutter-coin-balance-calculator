import 'package:coin_balance_calculator/http/item_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coin_balance_calculator/model/currency.dart';
import 'package:coin_balance_calculator/ui/dialog/transaction_add_dialog.dart';

import 'package:flutter/material.dart';

class TransactionAddPage extends StatefulWidget {
  @override
  _TransactionAddPageState createState() => _TransactionAddPageState();
}

class _TransactionAddPageState extends State<TransactionAddPage> {
  ItemService _itemService;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  bool _labelSearching = false;
  String searchQuery = "";

  @override
  void initState() {
    _itemService = ItemService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching && !_labelSearching
            ? _buildSearchField()
            : Text("YENİ İŞLEM EKLE"),
        actions: _buildActions(),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('TÜMÜ'),
                    color: Colors.blue,
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                        _labelSearching = false;
                        _clearSearchQuery();
                      });
                    },
                  ),
                  FlatButton(
                    child: Text('TRY'),
                    color: Colors.blue,
                    onPressed: () {
                      _openLabelSearch("TRY");
                    },
                  ),
                  FlatButton(
                    child: Text('USDT'),
                    color: Colors.blue,
                    onPressed: () {
                      _openLabelSearch("USDT");
                    },
                  ),
                  FlatButton(
                    child: Text('BTC'),
                    color: Colors.blue,
                    onPressed: () {
                      _openLabelSearch("BTC");
                    },
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: FutureBuilder(
              future: _itemService.fetchCurrencies(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Currency>> snapshot) {
                if (snapshot.hasData && snapshot.data.length == 0)
                  return Center(
                      child: Text("İşlem geçmişiniz bulunmamaktadır."));

                if (snapshot.hasData) {
                  List<Currency> data = snapshot.data;
                  if (_isSearching && searchQuery.isNotEmpty) {
                    data = data
                        .where((element) =>
                                element.pair.denominator
                                    .contains(searchQuery) ||
                                element.pair.numerator.contains(searchQuery)
                            // || element.company.name.contains(searchQuery)
                            )
                        .toList();
                    if (_isSearching && _labelSearching) {
                      _isSearching = false;
                      _labelSearching = false;
                    }
                  }

                  return ListView.separated(
                    itemCount: data.length,
                    cacheExtent: 10000,
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      Currency item = data[index];

                      return ListTile(
                        title: Text(item.pair.numerator),
                        subtitle: RichText(
                          text: TextSpan(
                            text: '${item.last} ${item.pair.denominator}',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        leading: CachedNetworkImage(
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          imageUrl:
                              'https://raw.githubusercontent.com/yesmancan/all-crypto-coin-img-db/master/img/coins/64x64/${item.pair.numerator}.png',
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: imageProvider,
                          ),
                        ),
                        trailing: Expanded(
                          child: Stack(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text('${item.company.name}'),
                                  IconButton(
                                      icon: Icon(Icons.add),
                                      color: Colors.white,
                                      onPressed: () async {
                                        await _addTransacion(
                                            'https://raw.githubusercontent.com/yesmancan/all-crypto-coin-img-db/master/img/coins/64x64/${item.pair.numerator}.png',
                                            item.pair.numerator,
                                            item.companyId,
                                            item.pairId,
                                            item.last);
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                if (snapshot.hasError) return Text(snapshot.error.toString());

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _addTransacion(String img, String name, String market,
      String coin, double lastPrice) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return TransactionAddDialog(
          title: name,
          market: market,
          coin: coin,
          buttonText: "Okay",
          image: img,
          lastPrice: lastPrice,
        );
      },
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
      onSubmitted: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching && !_labelSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
      if (!_labelSearching) {
        _buildSearchField();
      }
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery.toUpperCase();
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  void _openLabelSearch(String label) {
    setState(() {
      _isSearching = true;
      _labelSearching = true;
      updateSearchQuery(label);
    });
  }
}
