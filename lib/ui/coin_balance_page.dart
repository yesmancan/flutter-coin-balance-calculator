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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                buildPieChart(snapshot.data),
                buildCoins(snapshot.data),
              ],
            );
          }

          if (snapshot.hasError) return Text(snapshot.error.toString());

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Expanded buildPieChart(Overview data) {
    return Expanded(
      child: Column(
        children: <Widget>[
          PieChart(
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
                // startDegreeOffset: 180,
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 2,
                centerSpaceRadius: 80,
                sections: showingSections(data)),
          ),
          buildIndicator(data),
        ],
      ),
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
        },
      ),
    );
  }

  Container buildTableHeader() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "Para Birimi",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            "Toplam Varlık",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            "newPrice",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            "balance",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildCoins(Overview data) {
    return Expanded(
      child: Column(
        children: [
          buildTableHeader(),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              cacheExtent: 50000,
              separatorBuilder: (context, index) => Container(
                height: 2,
              ),
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
          ),
        ],
      ),
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
      final double radius = isTouched ? 60 : 50;
      if (ratio < 0.8) {
        other += ratio;
      } else {
        list.add(
          PieChartSectionData(
            color: const Color(0xff0293ee).withOpacity(opacity),
            value: ratio,
            title: "", //_data.coin.numerator,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xff044d7c),
            ),
          ),
        );
        i++;
      }
    });
    i++;
    final isTouched = i == touchedIndex;
    final double opacity = isTouched ? 1 : 0.6;
    final double radius = isTouched ? 60 : 50;

    list.add(
      PieChartSectionData(
        color: const Color(0xff0293ee).withOpacity(opacity),
        value: other,
        title: "", //"Others",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color(0xff044d7c),
        ),
      ),
    );

    return list;
  }
}
