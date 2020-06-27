import 'package:flutter/material.dart';

class CoinRow extends StatelessWidget {
  final Color color;
  final bool isSquare;
  final double size;
  final Color textColor;
  final String numerator;
  final String newPrice;
  final String denominator;
  final String balance;
  final String count;

  const CoinRow({
    Key key,
    this.color,
    this.numerator,
    this.denominator,
    this.balance,
    this.newPrice,
    this.count,
    this.isSquare,
    this.size = 48,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5),
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                  color: color,
                ),
              ),
              Text(
                numerator,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
              ),
            ],
          ),
          Text(
            count,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          ),
          Text(
            newPrice,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          ),
          Text(
            balance,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          ),
        ],
      ),
    );
  }
}
