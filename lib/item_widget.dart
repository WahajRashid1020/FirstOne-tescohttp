import 'package:awesomeapp/models/catalog.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({Key key, @required this.item})
      : assert(item != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: GridTile(
        // onTap: () {
        //   print("${item.name} pressed");
        // },
        header: Text(
          item.name,
          style: TextStyle(
              color: Colors.limeAccent, backgroundColor: Colors.black),
        ),
        child: Image.network(item.image),
        // subtitle: Text(item.desc),
        footer: Text(
          "\$${item.price}",
          textAlign: TextAlign.right,
          style: TextStyle(
              color: Colors.limeAccent,
              backgroundColor: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),

        // tileColor: Colors.lime[300],
      ),
    );
  }
}
