import 'package:awesomeapp/add_to_cart.dart';
import 'package:awesomeapp/main.dart';
import 'package:awesomeapp/models/catalog.dart';
import 'package:awesomeapp/widget/image.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailsPage extends StatelessWidget {
  final Item catalog;
  final int i = 0;

  const DetailsPage({Key key, @required this.catalog})
      : assert(catalog != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Ink(
            // decoration: ShapeDecoration(
            //   color: Colors.grey[200],
            //   shape: CircleBorder(),
            // ),
            child: new IconButton(
                icon: new Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomePage()))),
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
          ),
          GestureDetector(
            child: Hero(
              tag: Key(catalog.id.toString()),
              child: Image.network(catalog.image)
                  .box
                  .rounded
                  .make()
                  .w64(context)
                  .h64(context),
            ).h40(context),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(catalog: catalog);
              }));
            },
          ),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: catalog.name.text.bold.xl
                                  .color(Colors.yellow[800])
                                  .make()
                                  .py12(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: catalog.desc.text.xl
                                .color(Colors.white)
                                .textStyle(context.captionStyle)
                                .make()
                                .py12(),
                          ),
                        )
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
