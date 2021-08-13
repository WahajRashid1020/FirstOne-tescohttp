import 'package:awesomeapp/models/cart.dart';
import 'package:awesomeapp/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: duplicate_import
import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore {
  CatalogModel catalog;
  CartModel cart;

  MyStore() {
    catalog = CatalogModel();
    cart = CartModel();
    cart.catalog = catalog;
  }
}
