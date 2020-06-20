import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:coin_balance_calculator/http/item_service.dart';
import 'package:coin_balance_calculator/model/transaction.dart';
import 'package:coin_balance_calculator/ui/transactions/transaction_add_page.dart';

class TransactionListPage extends StatefulWidget {
  @override
  _TransactionListPageState createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  ItemService _itemService;

  @override
  void initState() {
    _itemService = ItemService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar(
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
          Expanded(
            child: Stack(
              children: <Widget>[
                FutureBuilder(
                  future: _itemService.fetchTransactions(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Transaction>> snapshot) {
                    if (snapshot.hasData && snapshot.data.length == 0) {
                      return Center(
                          child: Text("İşlem geçmişiniz bulunmamaktadır."));
                    }

                    if (snapshot.hasData) {
                      
                      return ListView.separated(
                        padding: EdgeInsets.all(0),
                        itemCount: snapshot.data.length,
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          Transaction item = snapshot.data[index];

                          return GestureDetector(
                            onLongPress: () async {
                              setState(() {});
                            },
                            child: ListTile(
                              title: Text(item.coin.numerator),
                              subtitle: RichText(
                                text: TextSpan(
                                  text: '${item.coin.denominator}',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                              leading: CachedNetworkImage(
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                imageUrl:
                                    'https://raw.githubusercontent.com/yesmancan/all-crypto-coin-img-db/master/img/coins/64x64/${item.coin.numerator}.png',
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
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                                '${item.unit} ${item.coin.numerator}'),
                                            RichText(
                                              text: TextSpan(
                                                text: '${item.buyingPrice}',
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        ' ${item.coin.denominator}',
                                                    style:
                                                        TextStyle(fontSize: 12),
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
                        },
                      );
                    }
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
