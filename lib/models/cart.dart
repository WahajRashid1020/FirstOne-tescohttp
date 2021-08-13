import 'package:awesomeapp/core/store.dart';
import 'package:awesomeapp/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModel {
  CatalogModel _catalog;
  // ignore: non_constant_identifier_names
  final List<int> _Itemids = [];

  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  List<Item> get items => _Itemids.map((id) => _catalog.getById(id)).toList();
  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  void remove(Item item) {
    _Itemids.remove(item.id);
  }
}

class AddMutation extends VxMutation<MyStore> {
  final Item item;
  AddMutation(this.item);
  @override
  perform() {
    // ignore: todo
    // TODO: implement perform
    store.cart._Itemids.add(item.id);
  }
}

class RemoveMutation extends VxMutation<MyStore> {
  final Item item;
  RemoveMutation(this.item);
  @override
  perform() {
    // ignore: todo
    // TODO: implement perform
    store.cart._Itemids.remove(item.id);
  }
}
