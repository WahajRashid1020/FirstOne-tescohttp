import 'package:awesomeapp/core/store.dart';
import 'package:awesomeapp/models/cart.dart';
import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

// ignore: camel_case_types
class Cart_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
        title: "My Cart".text.bold.color(Colors.indigo[900]).make(),
      ),
      body: Column(
        children: [
          Cartlist().p32().expand(),
          Divider(),
          Mytotal(),
        ],
      ),
    );
  }
}

class Mytotal extends StatelessWidget {
  final CartModel _cart = (VxState.store as MyStore).cart;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VxBuilder(
            mutations: {RemoveMutation},
            builder: (context, _) {
              return "\$${_cart.totalPrice}"
                  .text
                  .xl2
                  .bold
                  .color(Colors.white)
                  .make();
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/info");
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber)),
            child: "Proceed".text.black.make(),
          ).w32(context)
        ],
      ),
    );
  }
}

class Cartlist extends StatelessWidget {
  final CartModel _cart = (VxState.store as MyStore).cart;

  @override
  Widget build(BuildContext context) {
    VxState.listen(context, to: [RemoveMutation]);
    return SafeArea(
      child: Container(
        // ignore: null_aware_in_condition
        child: _cart.items?.isEmpty
            ? "Notihng To Show".text.xl2.color(Colors.white).makeCentered()
            : ListView.builder(
                itemCount: _cart.items?.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(
                    Icons.done,
                    color: Colors.green,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      RemoveMutation(_cart.items[index]);

                      // setState(() {});
                    },
                    icon: Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                    ),
                  ),
                  title: _cart.items[index].name.text.bold
                      .color(Colors.white)
                      .make(),
                ),
              ),
      ),
    );
  }
}
