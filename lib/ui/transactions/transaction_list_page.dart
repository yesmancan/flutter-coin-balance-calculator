import 'package:coin_balance_calculator/ui/dialog/transaction_add_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:coin_balance_calculator/http/item_service.dart';
import 'package:coin_balance_calculator/model/transaction.dart';
import 'package:coin_balance_calculator/ui/transactions/transaction_add_page.dart';

class TransactionListPage extends StatefulWidget {
  @override
  _TransactionListPageState createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  Future<List<Transaction>> transactions;
  ItemService _itemService = ItemService();

  @override
  void initState() {
    super.initState();
    setState(() {
      transactions = _itemService.fetchTransactions();
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İşlemlerim"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransactionAddPage(),
                ),
              );
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: transactions,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Transaction> data = snapshot.data;
            return _buildListView(data);
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ListView _buildListView(List<Transaction> data) {
    return ListView.separated(
      shrinkWrap: true,
      cacheExtent: 50000,
      padding: EdgeInsets.all(0),
      itemCount: data.length,
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemBuilder: (BuildContext context, int index) {
        if (data.length == 0) {
          return Center(child: Text("İşlem geçmişiniz bulunmamaktadır."));
        }
        if (data != null && data.length > 0) {
          Transaction item = data[index];

          return Slidable(
            key: Key(item.id),
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            actions: <Widget>[
              IconSlideAction(
                caption: 'Archive',
                color: Colors.blue,
                icon: Icons.archive,
                onTap: () => Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("$item dismissed"))),
              ),
              IconSlideAction(
                caption: 'Share',
                color: Colors.indigo,
                icon: Icons.share,
                onTap: () => Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("$item dismissed"))),
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Edit',
                color: Colors.black45,
                icon: Icons.more_horiz,
                onTap: () async {
                  await _addTransacion(
                      'https://raw.githubusercontent.com/yesmancan/all-crypto-coin-img-db/master/img/coins/64x64/${item.coin.numerator}.png',
                      item.coin.numerator,
                      item.marketId,
                      item.coinId,
                      item.buyingPrice,
                      item.unit);
                },
              ),
              IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () async {
                    await _deleteToTransaction(item.id, item.coin.numerator);
                  }),
            ],
            child: ListTile(
              title: Text(item.coin.numerator),
              subtitle: RichText(
                text: TextSpan(
                  text: '${item.coin.denominator}',
                  style: TextStyle(fontSize: 11),
                ),
              ),
              leading: CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageUrl:
                    'https://raw.githubusercontent.com/yesmancan/all-crypto-coin-img-db/master/img/coins/64x64/${item.coin.numerator}.png',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: imageProvider,
                ),
              ),
              trailing: Expanded(
                child: Stack(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('${item.unit} ${item.coin.numerator}'),
                            RichText(
                              text: TextSpan(
                                text: '${item.buyingPrice}',
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' ${item.coin.denominator}',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<void> _deleteToTransaction(String id, String name) async {
    bool retStatus = await _itemService.deleteToTransaction(id);
    if (retStatus) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("$name Removed"),
        ),
      );
      setState(() {
        transactions = _itemService.fetchTransactions();
      });
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Has a Error"),
        ),
      );
    }
  }

  Future<Null> _addTransacion(String img, String name, String market,
      String coin, double lastPrice, double unit) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return TransactionAddDialog(
          title: name,
          market: market,
          unit: unit,
          coin: coin,
          buttonText: "Okay",
          image: img,
          lastPrice: lastPrice,
        );
      },
    );
  }
}
