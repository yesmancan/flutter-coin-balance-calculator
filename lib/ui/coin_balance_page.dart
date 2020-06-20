import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CoinBalancePage extends StatelessWidget {
  const CoinBalancePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series> seriesList = _createSampleData();

    return Container(
      child: Column(
        children: <Widget>[
          new charts.PieChart(
            seriesList,
            animate: true,
            defaultRenderer: new charts.ArcRendererConfig(
              arcWidth: 50,
              strokeWidthPx: 4,
              arcRendererDecorators: [
                charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.outside,
                  insideLabelStyleSpec: new charts.TextStyleSpec(
                    fontSize: 16,
                    color: charts.Color.fromHex(code: "#FFFFFF"),
                  ),
                ),
                charts.ArcLabelDecorator()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<charts.Series<LinearSales, int>> _createSampleData() {
  final data = [
    new LinearSales(
      0,
      54.7,
      charts.ColorUtil.fromDartColor(Colors.lightBlue),
      charts.TextStyleSpec(
        color: charts.ColorUtil.fromDartColor(Colors.white),
      ),
    ),
    new LinearSales(
      1,
      17.8,
      charts.ColorUtil.fromDartColor(Colors.yellowAccent),
      charts.TextStyleSpec(
        color: charts.ColorUtil.fromDartColor(Colors.white),
      ),
    ),
    new LinearSales(
      2,
      13.8,
      charts.ColorUtil.fromDartColor(Colors.blueAccent),
      charts.TextStyleSpec(
        color: charts.ColorUtil.fromDartColor(Colors.white),
      ),
    ),
    new LinearSales(
      3,
      13.7,
      charts.ColorUtil.fromDartColor(Colors.blueGrey),
      charts.TextStyleSpec(
        color: charts.ColorUtil.fromDartColor(Colors.white),
      ),
    ),
  ];

  return [
    new charts.Series<LinearSales, int>(
      id: 'BTC',
      domainFn: (LinearSales sales, _) => sales.id,
      measureFn: (LinearSales sales, _) => sales.tutar,
      colorFn: (LinearSales sales, _) => sales.color,
      data: data,
      outsideLabelStyleAccessorFn: (LinearSales sales, _) => sales.textStyle,
      labelAccessorFn: (LinearSales row, _) => '${row.tutar}',
    )
  ];
}

class LinearSales {
  final int id;
  final double tutar;
  final charts.Color color;
  final charts.TextStyleSpec textStyle;

  LinearSales(this.id, this.tutar, this.color, this.textStyle);
}
