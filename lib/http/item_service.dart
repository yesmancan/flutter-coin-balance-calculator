import 'dart:convert';
import 'package:coin_balance_calculator/model/PostModel/transaction_post_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_guid/flutter_guid.dart';

import 'package:coin_balance_calculator/model/coin.dart';
import 'package:coin_balance_calculator/model/currency.dart';
import 'package:coin_balance_calculator/model/overview.dart';
import 'package:coin_balance_calculator/model/transaction.dart';

class ItemService {
  final String _serviceUrl = 'crypto-app-api.herokuapp.com';

  Future<List<Transaction>> fetchTransactions() async {
    Uri uri = Uri.https(_serviceUrl, "api/transactions");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Iterable items = json.decode(response.body)["data"];
      var liste = items.map((item) => Transaction.fromJson(item)).toList();
      liste.sort((a, b) => b.createDt.compareTo(a.createDt));
      return liste;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<List<Currency>> fetchCurrencies() async {
    Uri uri = Uri.https(_serviceUrl, "/api/currencies");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Iterable items = json.decode(response.body)["data"];

      return items.map((item) => Currency.fromJson(item)).toList();
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<List<Coin>> fetchItems() async {
    Uri uri = Uri.https(_serviceUrl, "api/v2/ticker");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Iterable items = json.decode(response.body)["data"];

      return items.map((item) => Coin.fromJson(item)).toList();
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<void> addTransaction(
      String market, String coin, String buyingprice, double unit) async {
    var _body = TransactionPostModel(
        userId: "00000000-0000-0000-0000-000000000000",
        buyingPrice: double.parse(buyingprice),
        coin: new Guid(coin),
        market: new Guid(market),
        isSold: false,
        status: 1,
        unit: unit,
        sellPrice: 0,
        createDt: new DateTime.now().toIso8601String());

    Map<String, String> user = {
      "userId": "00000000-0000-0000-0000-000000000000"
    };
    var uri = Uri.https(_serviceUrl, "api/transaction/create", user);
    try {
      final response = await http.post(
        uri,
        headers: {'content-type': 'application/json'},
        body: _body.toJson(),
      );

      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addToArchive() async {
    Uri uri = Uri.https(_serviceUrl, "history");
    final response = await http.post(uri);

    if (response.statusCode != 201) {
      throw Exception("Something went wrong");
    }
  }

  Future<void> fetchArchive(int take, int skip) async {
    Map<String, String> parameters = {
      "take": take.toString(),
      "skip": skip.toString()
    };

    var uri = Uri.https(_serviceUrl, "history", parameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Iterable items = json.decode(response.body);

      return items.map((item) => Coin.fromJson(item)).toList();
    } else {
      throw Exception("Something went wrong");
    }
  }

  // Future<Coin> editItem(Coin item) async {
  //   Uri uri = Uri.https(_serviceUrl, "item");

  //   final response = await http.patch('$uri/${item.pairNormalized}',
  //       headers: {'content-type': 'application/json'}, body: item.toJson());

  //   if (response.statusCode == 200) {
  //     Map item = json.decode(response.body);

  //     return Coin.fromJson(item);
  //   } else {
  //     throw Exception("Something went wrong");
  //   }
  // }

  Future<Overview> overview() async {
    return new Overview();
  }
}
