import 'coin.dart';
import 'market.dart';

class Currency{
  String id;
  String companyId;
  Market company;
  String pairId;
  Coin pair;
  int unit;
  String timeStamp;
  double last;
  double high;
  double low;
  double bid;
  double ask;
  double open;
  double volume;
  double average;
  double daily;
  double dailyPercent;
  int order;

  Currency(
      {this.id,
      this.companyId,
      this.company,
      this.pairId,
      this.pair,
      this.unit,
      this.timeStamp,
      this.last,
      this.high,
      this.low,
      this.bid,
      this.ask,
      this.open,
      this.volume,
      this.average,
      this.daily,
      this.dailyPercent,
      this.order});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'];
    company =
        json['company'] != null ? new Market.fromJson(json['company']) : null;
    pairId = json['pairId'];
    pair = json['pair'] != null ? new Coin.fromJson(json['pair']) : null;
    unit = json['unit'];
    timeStamp = json['timeStamp'];
    last = json['last'];
    high = json['high'];
    low = json['low'];
    bid = json['bid'];
    ask = json['ask'];
    open = json['open'];
    volume = json['volume'];
    average = json['average'];
    daily = json['daily'];
    dailyPercent = json['dailyPercent'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyId'] = this.companyId;
    if (this.company != null) {
      data['company'] = this.company.toJson();
    }
    data['pairId'] = this.pairId;
    if (this.pair != null) {
      data['pair'] = this.pair.toJson();
    }
    data['unit'] = this.unit;
    data['timeStamp'] = this.timeStamp;
    data['last'] = this.last;
    data['high'] = this.high;
    data['low'] = this.low;
    data['bid'] = this.bid;
    data['ask'] = this.ask;
    data['open'] = this.open;
    data['volume'] = this.volume;
    data['average'] = this.average;
    data['daily'] = this.daily;
    data['dailyPercent'] = this.dailyPercent;
    data['order'] = this.order;
    return data;
  }
}

