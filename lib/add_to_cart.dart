import 'package:awesomeapp/core/store.dart';
import 'package:awesomeapp/models/cart.dart';
import 'package:awesomeapp/models/catalog.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: camel_case_types
class addtocart extends StatelessWidget {
  final Item catalog;

  addtocart({Key key, this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VxState.listen(context, to: [AddMutation, RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    bool isAdded = _cart.items.contains(catalog) ?? false;
    return ElevatedButton(
        onPressed: () {
          AddMutation(catalog);
          // setState(() {});
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.yellow[800]),
            shape: MaterialStateProperty.all(StadiumBorder())),
        child: isAdded
            ? Icon(Icons.done).iconColor(Colors.black)
            : "BUY".text.color(Colors.black).make());
  }
}
