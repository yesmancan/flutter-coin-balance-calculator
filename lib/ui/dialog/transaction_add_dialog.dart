import 'package:coin_balance_calculator/http/item_service.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 36.0;
}

class TransactionAddDialog extends StatelessWidget {
  final String market, coin;
  final String title, buttonText;
  final double lastPrice, unit;
  final String image;

  TransactionAddDialog({
    @required this.title,
    @required this.buttonText,
    @required this.coin,
    @required this.market,
    @required this.lastPrice,
    @required this.unit,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    final unitController = TextEditingController(text: this.unit.toString());
    final buyingpriceController =
        TextEditingController(text: lastPrice.toString());

    ItemService _itemService = ItemService();
    String buyingprice;
    double unit;

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Adet",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                controller: unitController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  hintText: 'Lütfen adet giriniz',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Lütfen boş geçmeyiniz';
                  }
                  return value;
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Satın Alınan Fiyat",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                controller: buyingpriceController,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  hintText: 'Lütfen satın aldığınız fiyatı giriniz',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Lütfen boş geçmeyiniz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  color: Colors.blueAccent,
                  onPressed: () async {
                    unit = double.parse(unitController.text);
                    buyingprice = buyingpriceController.text;

                    await _itemService.addTransaction(
                        market, coin, buyingprice, unit);

                    Navigator.popUntil(context, (route) {
                      return route.settings.name == "/";
                    });
                  },
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
        CachedNetworkImage(
          imageUrl: image,
          imageBuilder: (context, imageProvider) => Align(
            alignment: Alignment.topCenter,
            heightFactor: 1,
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: Consts.avatarRadius,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
