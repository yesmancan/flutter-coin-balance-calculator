import 'coin.dart';
import 'market.dart';

class Overview {
  double newPrice;
  double oldPrice;
  double profit;
  int profitRatio;
  List<CoinByCoin> coinByCoin;

  Overview(
      {this.newPrice,
      this.oldPrice,
      this.profit,
      this.profitRatio,
      this.coinByCoin});

  factory Overview.fromJson(Map<String, dynamic> json) {
    List<CoinByCoin> coinByCoin;
    if (json['coinByCoin'] != null) {
      coinByCoin = new List<CoinByCoin>();
      json['coinByCoin'].forEach((v) {
        coinByCoin.add(new CoinByCoin.fromJson(v));
      });
    }

    return Overview(
        coinByCoin: coinByCoin,
        newPrice: json['newPrice'],
        oldPrice: json['oldPrice'],
        profit: json['profit'],
        profitRatio: json['profitRatio']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newPrice'] = this.newPrice;
    data['oldPrice'] = this.oldPrice;
    data['profit'] = this.profit;
    data['profitRatio'] = this.profitRatio;
    if (this.coinByCoin != null) {
      data['coinByCoin'] = this.coinByCoin.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CoinByCoin {
  Coin coin;
  Market market;
  double oldPrice;
  double newPrice;
  double profit;
  double profitRatio;

  CoinByCoin(
      {this.coin,
      this.market,
      this.oldPrice,
      this.newPrice,
      this.profit,
      this.profitRatio});

  CoinByCoin.fromJson(Map<String, dynamic> json) {
    coin = json['coin'] != null ? new Coin.fromJson(json['coin']) : null;
    market =
        json['market'] != null ? new Market.fromJson(json['market']) : null;
    oldPrice = json['oldPrice'];
    newPrice = json['newPrice'];
    profit = json['profit'];
    profitRatio = json['profitRatio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coin != null) {
      data['coin'] = this.coin.toJson();
    }
    if (this.market != null) {
      data['market'] = this.market.toJson();
    }
    data['oldPrice'] = this.oldPrice;
    data['newPrice'] = this.newPrice;
    data['profit'] = this.profit;
    data['profitRatio'] = this.profitRatio;
    return data;
  }
}
