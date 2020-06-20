import 'dart:convert';

import 'coin.dart';
import 'market.dart';

class Transaction {
  String id;
  String userId;
  String marketId;
  Market market;
  String coinId;
  Coin coin;
  double unit;
  double buyingPrice;
  bool isSold;
  double sellPrice;
  int status;
  String createDt;

  Transaction(
      {this.id,
      this.userId,
      this.marketId,
      this.market,
      this.coinId,
      this.coin,
      this.unit,
      this.buyingPrice,
      this.isSold,
      this.sellPrice,
      this.status,
      this.createDt});

  factory Transaction.fromJson(Map<String, dynamic> map) {
    return Transaction(
        id: map['id'],
        userId: map['userId'],
        marketId: map['marketId'],
        market:
            map['market'] != null ? new Market.fromJson(map['market']) : null,
        coinId: map['coinId'],
        coin: map['coin'] != null ? new Coin.fromJson(map['coin']) : null,
        unit: map['unit'],
        buyingPrice: map['buyingPrice'],
        isSold: map['isSold'],
        sellPrice: map['sellPrice'],
        status: map['status'],
        createDt: map['createDt']);
  }

  String toJson() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['id'] = this.id;
    map['userId'] = this.userId;
    map['marketId'] = this.marketId;
    if (this.market != null) {
      map['market'] = this.market.toJson();
    }
    map['coinId'] = this.coinId;
    if (this.coin != null) {
      map['coin'] = this.coin.toJson();
    }
    map['unit'] = this.unit;
    map['buyingPrice'] = this.buyingPrice;
    map['isSold'] = this.isSold;
    map['sellPrice'] = this.sellPrice;
    map['status'] = this.status;
    map['createDt'] = this.createDt;

    return json.encode(map);
  }
}
