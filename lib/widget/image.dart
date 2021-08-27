import 'package:awesomeapp/models/catalog.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Item catalog;

  const DetailScreen({Key key, @required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: Key(catalog.id.toString()),
            child: Image.network(catalog.image),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
