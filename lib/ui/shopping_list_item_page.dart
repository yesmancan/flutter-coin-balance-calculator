// import 'package:coin_balance_calculator/http/item_service.dart';
// import 'package:coin_balance_calculator/model/coin.dart';
// import 'package:flutter/material.dart';

// class ShoppingListItemPage extends StatefulWidget {
//   @override
//   _ShoppingListItemPageState createState() => _ShoppingListItemPageState();
// }

// class _ShoppingListItemPageState extends State<ShoppingListItemPage> {
//   ItemService _itemService;

//   @override
//   void initState() {
//     _itemService = ItemService();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           AppBar(
//             title: Text("Fiyatlar"),
//           ),
//           Expanded(
//             child: Stack(
//               children: <Widget>[
//                 FutureBuilder(
//                   future: _itemService.fetchItems(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<List<Coin>> snapshot) {
//                     if (snapshot.hasData && snapshot.data.length == 0) {
//                       return Center(
//                           child: Text("Your shopping list is empty!"));
//                     }

//                     if (snapshot.hasData) {
//                       return ListView.builder(
//                         padding: EdgeInsets.all(0),
//                         itemCount: snapshot.data.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           Coin item = snapshot.data[index];

//                           return GestureDetector(
//                             onLongPress: () async {
//                               setState(() {});
//                             },
//                             child: ListTile(
//                               title: Text(item.numeratorSymbol +
//                                   "/" +
//                                   item.denominatorSymbol),
//                               subtitle: Text(item.dailyPercent.toString()),
//                               leading: IconButton(
//                                   icon: Icon(Icons.star), onPressed: null),
//                               trailing: Column(
//                                 children: <Widget>[
//                                   Text(item.average.toStringAsFixed(2)),
//                                   Text(
//                                     "${item.daily.toStringAsFixed(2)} (%${item.dailyPercent.toString()})",
//                                     style: TextStyle(
//                                         color: item.dailyPercent.isNegative
//                                             ? Colors.red
//                                             : Colors.green),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }
//                     if (snapshot.hasError) {
//                       return Text(snapshot.error.toString());
//                     }
//                     return Center(child: CircularProgressIndicator());
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
