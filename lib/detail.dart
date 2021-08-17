import 'package:awesomeapp/add_to_cart.dart';
import 'package:awesomeapp/models/catalog.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailsPage extends StatelessWidget {
  final Item catalog;

  const DetailsPage({Key key, @required this.catalog})
      : assert(catalog != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          "\$${catalog.price}"
              .text
              .color(Colors.lightGreenAccent[400])
              .xl
              .make(),
          addtocart(
            catalog: catalog,
          )
        ],
      ).p16().backgroundColor(Colors.indigo[900]),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
          ),
          Hero(
            tag: Key(catalog.id.toString()),
            child: Image.network(catalog.image)
                .box
                .rounded
                .make()
                .w64(context)
                .h64(context),
          ).h40(context),
          Expanded(
            child: VxArc(
                height: 30.0,
                arcType: VxArcType.CONVEY,
                edge: VxEdge.TOP,
                child: SafeArea(
                  child: Container(
                    width: context.screenWidth,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                        ),
                        catalog.name.text.bold.xl4.color(Colors.white).make(),
                        catalog.desc.text
                            .color(Colors.white)
                            .textStyle(context.captionStyle)
                            .make(),
                      ],
                    ).p32(),
                    color: Colors.indigo[900],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
