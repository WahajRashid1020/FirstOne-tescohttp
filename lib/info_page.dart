// ignore: unused_import
import 'dart:async';

import 'package:awesomeapp/core/store.dart';
import 'package:awesomeapp/models/cart.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/services.dart';
import 'package:share/share.dart';
// ignore: unused_import
import 'package:url_launcher/url_launcher.dart';

import 'package:velocity_x/velocity_x.dart';

// ignore: camel_case_types
class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: "Place Your Order On WhatsApp"
            .text
            .bold
            .color(Colors.grey[350])
            .make(),
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
                shrinkWrap: true,
                itemCount: _cart.items?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.black12,
                    title: _cart.items[index].name.text
                        .color(Colors.white)
                        .bold
                        .make(),
                  );
                }),
      ),
    );
  }
}

class Mytotal extends StatefulWidget {
  @override
  _MytotalState createState() => _MytotalState();
}

class _MytotalState extends State<Mytotal> {
  final CartModel _cart = (VxState.store as MyStore).cart;

  @override
  Widget build(BuildContext context) {
    _launchURL() async {
      launch("tel://03433093451");
    }

    num size = _cart.items.length;
    // var arr = [size];
    List<String> list = [];
    return SizedBox(
      height: 140,
      child: Column(
        children: [
          "Note".text.center.color(Colors.red).make(),
          "Place your order on WhatsApp after saving the number"
              .text
              .color(Colors.green)
              .make()
              .p16(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: _launchURL,
                  child: BlinkText(
                    'Click Here to Save The Number',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        background: Paint()
                          ..strokeWidth = 30.0
                          ..color = Colors.yellow[800]
                          ..style = PaintingStyle.stroke
                          ..strokeJoin = StrokeJoin.round),
                    beginColor: Colors.lightGreenAccent[400],
                    endColor: Colors.red,
                    times: 30,
                    duration: Duration(seconds: 1),
                  )),

              // Center(

              //         child: SelectableText(
              //           "03433093451",
              //           style: TextStyle(
              //               color: Colors.lightGreenAccent[400],
              //               fontWeight: FontWeight.bold,
              //               fontSize: 15),
              //           textAlign: TextAlign.left,
              //           onTap: () => print('Tapped'),
              //           toolbarOptions: ToolbarOptions(
              //             copy: true,
              //             selectAll: true,
              //           ),
              //           showCursor: true,
              //           cursorWidth: 2,
              //           cursorColor: Colors.red,
              //           cursorRadius: Radius.circular(5),
              //         ),
              //         )
              //     .p12(),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    // const oneSec = Duration(seconds: 200);
                    // Timer.periodic(oneSec, (Timer t) =>).cancel();

                    dialog(context);
                    opp(size, list, _cart);
                    // ;
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.indigo[900])),
                  child: Text(
                    'Place Order',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.black,
                        background: Paint()
                          ..strokeWidth = 30.0
                          ..color = Colors.yellow[800]
                          ..style = PaintingStyle.stroke
                          ..strokeJoin = StrokeJoin.round),
                  )).w20(context)
            ],
          ).centered(),
        ],
      ),
    );
  }
}

void opp(size, list, _cart) {
  for (int i = 0; i <= size - 1; i++) {
    list.add("\n" + "${i + 1}-" + _cart.items[i].name);

    // arr.add("${_cart.items[i].name}");

  }
  list.insert(size, "\n" + "Total Price \$${_cart.totalPrice}");

  Share.share(list.toString());
}

void dialog(context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Note'),
      content: const Text(
          'Place your order on our WhatsApp number which is given below'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
