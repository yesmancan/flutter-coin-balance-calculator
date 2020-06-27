import 'package:coin_balance_calculator/http/item_service.dart';
import 'package:coin_balance_calculator/model/overview.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'coin_row.dart';
import 'indicator.dart';

class CoinBalancePage extends StatefulWidget {
  @override
  _CoinBalancePageState createState() => _CoinBalancePageState();
}

class _CoinBalancePageState extends State<CoinBalancePage> {
  final ItemService _itemService = ItemService();
  int touchedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Durum")),
      body: FutureBuilder(
        future: _itemService.fetchOverview(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 2,
                      child: buildPieChart(snapshot.data),
                    ),
                  ),
                  buildIndicator(snapshot.data),
                  Container(
                    color: Colors.black45,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            "numerator".toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "count".toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "newPrice".toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "balance".toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  buildCoins(snapshot.data)
                ],
              ),
            );
          }

          if (snapshot.hasError) return Text(snapshot.error.toString());

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  PieChart buildPieChart(Overview data) {
    return PieChart(
      PieChartData(
          pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
            setState(() {
              if (pieTouchResponse.touchInput is FlLongPressEnd ||
                  pieTouchResponse.touchInput is FlPanEnd) {
                touchedIndex = -1;
              } else {
                touchedIndex = pieTouchResponse.touchedSectionIndex;
              }
            });
          }),
          startDegreeOffset: 180,
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 2,
          centerSpaceRadius: 0,
          sections: showingSections(data)),
    );
  }

  Expanded buildIndicator(Overview data) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          cacheExtent: 50000,
          padding: EdgeInsets.all(0),
          itemCount: data.coinByCoin.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            var _data = data.coinByCoin[index];
            return Indicator(
              color: const Color(0xff0293ee),
              text: _data.coin.numerator,
              isSquare: true,
              size: touchedIndex == 0 ? 18 : 16,
              textColor: touchedIndex == 0 ? Colors.white : Colors.grey,
            );
          }),
    );
  }

  List<PieChartSectionData> showingSections(Overview overview) {
    double other = 0;
    List<PieChartSectionData> list = [];
    int i = 0;
    overview.coinByCoin.forEach((element) {
      final isTouched = i == touchedIndex;
      final double opacity = isTouched ? 1 : 0.6;
      var _data = overview.coinByCoin[i];
      var ratio = _data.newPrice / overview.newPrice * 100;

      if (ratio < 0.8) {
        other += ratio;
      } else {
        list.add(PieChartSectionData(
          color: const Color(0xff0293ee).withOpacity(opacity),
          value: ratio,
          title: _data.coin.numerator,
          radius: 100,
          titleStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xff044d7c)),
        ));
        i++;
      }
    });
    i++;
    final isTouched = i == touchedIndex;
    final double opacity = isTouched ? 1 : 0.6;
    list.add(PieChartSectionData(
      color: const Color(0xff0293ee).withOpacity(opacity),
      value: other,
      title: "Others",
      radius: 100,
      titleStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color(0xff044d7c)),
    ));

    return list;
  }

  Expanded buildCoins(Overview data) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        cacheExtent: 50000,
        padding: EdgeInsets.all(0),
        itemCount: data.coinByCoin.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          var _data = data.coinByCoin[index];
          return CoinRow(
            color: const Color(0xff0293ee),
            denominator: _data.coin.denominator,
            numerator: _data.coin.numerator,
            newPrice: _data.newPrice.toString(),
            balance: _data.profit.toString(),
            count: "100",
            isSquare: false,
            size: touchedIndex == 0 ? 18 : 16,
            textColor: touchedIndex == 0 ? Colors.white : Colors.grey,
          );
        },
      ),
    );
  }
}
