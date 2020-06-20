import 'dart:convert';

import 'package:flutter_guid/flutter_guid.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TransactionPostModel {
  String userId;
  Guid market;
  Guid coin;
  double unit;
  double buyingPrice;
  bool isSold;
  double sellPrice;
  int status;
  String createDt;

  TransactionPostModel(
      {
      this.userId,
      this.market,
      this.coin,
      this.unit,
      this.buyingPrice,
      this.isSold,
      this.sellPrice,
      this.status,
      this.createDt});

  String toJson() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['UserId'] = this.userId;
    map['Market'] = this.market.value;
    map['Coin'] = this.coin.value;
    map['Unit'] = this.unit;
    map['BuyingPrice'] = this.buyingPrice;
    map['IsSold'] = this.isSold;
    map['SellPrice'] = this.sellPrice;
    map['Status'] = this.status;
    map['CreateDt'] = this.createDt;
    return json.encode(map);
  }
}
