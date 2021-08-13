import 'dart:convert';

import 'package:awesomeapp/add_to_cart.dart';
import 'package:awesomeapp/cart_page.dart';
import 'package:awesomeapp/core/store.dart';
import 'package:awesomeapp/detail.dart';
import 'package:awesomeapp/info_page.dart';
import 'package:awesomeapp/login-page.dart';
import 'package:awesomeapp/models/cart.dart';
import 'package:awesomeapp/models/catalog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
// ignore: unused_import
import 'item_widget.dart';

void main() {
  runApp(
    VxState(
      store: MyStore(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Flutter App",
          home: HomePage(),
          theme: ThemeData(
              primarySwatch: Colors.indigo,
              primaryTextTheme: GoogleFonts.latoTextTheme()),
          routes: {
            "/login": (context) => MyLoginPage(),
            "/home": (context) => HomePage(),
            "/cart": (context) => Cart_page(),
            "/info": (context) => InfoPage(),
            "/details": (context) => DetailsPage(
                  catalog: null,
                ),
          }),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: unused_field
  // ignore: unused_field
  TextEditingController _nameController = TextEditingController();
  var mytext = "Change It";
  var data;
  // final url = 'http://jsonplaceholder.typicode.com/photos';
  final url = 'https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3';
  @override
  void initState() {
    super.initState();
    loadData();
    //  getData();
  }

  loadData() async {
    var catjson = await rootBundle.loadString("assets/files/catalog.json");
    final catdata = jsonDecode(catjson);
    var pd = catdata["products"];
    CatalogModel.items =
        List.from(pd).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {});
    // var catjson = await http.get(Uri.parse(url));
    // final catjs = catjson.body;
    // // await rootBundle.loadString("assets/files/catalog.json");
    // final catdata = jsonDecode(catjs);
    // var pd = catdata["products"];
    // CatalogModel.items =
    //     List.from(pd).map<Item>((item) => Item.fromMap(item)).toList();
    // setState(() {});
  }

  // getData() async {
  //   var res = await http.get(Uri.parse(url));
  //   data = jsonDecode(res.body);
  //   print(data);
  // }

  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
        backgroundColor: Colors.grey[350],
        floatingActionButton: VxBuilder(
          mutations: {AddMutation, RemoveMutation},
          builder: (ctx, _) => FloatingActionButton(
            backgroundColor: Colors.yellow[800],
            onPressed: () {
              Navigator.pushNamed(context, "/cart");
            },
            child: Icon(CupertinoIcons.cart).iconColor(Colors.black),
          ).badge(
              color: Vx.red500,
              size: 20,
              count: _cart.items.length,
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 15,
              )),
        ),

        // appBar: AppBar(
        //     centerTitle: true,
        //     title:
        //         Text("MY FLUTTER APP", style: TextStyle(color: Colors.black))),
        body: SafeArea(
          child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Tesco App".text.xl5.bold.color(Colors.indigo[900]).make(),
                "On Sell ".text.xl2.color(Colors.indigo[900]).make(),
                if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                  Cataloglist().expand()
                else
                  CircularProgressIndicator().centered().expand(),
              ],
            ),
          ),
        )
        // Padding(
        //   padding: const EdgeInsets.all(18.0),
        //   child: (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
        //       ? GridView.builder(
        //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //               mainAxisSpacing: 16, crossAxisCount: 3),
        //           itemCount: CatalogModel.items.length,
        //           itemBuilder: (context, index) {
        //             return Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: ItemWidget(
        //                 item: CatalogModel.items[index],
        //               ),
        //             );
        //           })
        //       : Center(child: CircularProgressIndicator()),
        //   // child: data != null
        //   //     ? ListView.builder(
        //   //         itemBuilder: (context, index) {
        //   //           return Padding(
        //   //             padding: const EdgeInsets.all(8.0),
        //   //             child: ListTile(
        //   //               leading: Icon(Icons.edit),
        //   //               // leading: Image.network(data[index]["thumbnailUrl"]),
        //   //               title: Text(data[index]["title"]),
        //   //               subtitle: Text("ID ${data[index]["id"]}"),
        //   //               tileColor: Colors.lime,
        //   //               contentPadding: EdgeInsets.all(20),
        //   //             ),
        //   //           );
        //   //         },
        //   //         itemCount: data.length,
        //   //       )
        //   //     : Center(child: CircularProgressIndicator()),
        // ),
        // drawer: Drawer(
        //   child: ListView(
        //     children: [
        //       // DrawerHeader(
        //       //     child: Text("My Drawer", style: TextStyle(color: Colors.white)),
        //       //     decoration: BoxDecoration(color: Colors.purple))
        //       UserAccountsDrawerHeader(
        //         accountName: Text("Wahaj Rashid"),
        //         accountEmail: Text("wahaj1020@gmails.com"),
        //         // currentAccountPicture: Image.network(src),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.person),
        //         title: Text("Accont"),
        //         subtitle: Text("Personal Data"),
        //         trailing: Icon(Icons.edit),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.email),
        //         title: Text("Email"),
        //         subtitle: Text("Email Settings"),
        //         trailing: Icon(Icons.edit),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.info_rounded),
        //         title: Text("Info"),
        //         subtitle: Text("Personal Information"),
        //         trailing: Icon(Icons.edit),
        //       ),
        //     ],
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //       mytext = _nameController.text;
        //       setState(() {});
        //     },
        //     child: Icon(Icons.refresh)),
        // bottomSheet: FloatingActionButton(
        //     onPressed: () {
        //       Navigator.pushNamed(context, "/login");
        //     },
        //     child: Icon(Icons.logout_rounded))

        );
  }
}

class Cataloglist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: CatalogModel.items.length,
        itemBuilder: (context, index) {
          final catalog = CatalogModel.items[index];
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(catalog: catalog)),
            ),
            child: Catalogitems(catalog: catalog),
          );
        });
  }
}

class Catalogitems extends StatelessWidget {
  final Item catalog;

  const Catalogitems({Key key, @required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
      children: [
        Hero(
            tag: Key(catalog.id.toString()),
            child: Catalogimage(image: catalog.image)),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            catalog.name.text.xl.color(Colors.white).make(),
            catalog.desc.text
                .color(Colors.white)
                .textStyle(context.captionStyle)
                .make(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  "\$${catalog.price}"
                      .text
                      .color(Colors.lightGreenAccent[400])
                      .bold
                      .xl
                      .make(),
                  addtocart(catalog: catalog)
                ],
              ),
            )
          ],
        ))
      ],
    )).color(Colors.indigo[900]).rounded.square(150).make().py16();
  }
}

// ignore: camel_case_types
// ignore: camel_case_types

class Catalogimage extends StatelessWidget {
  final String image;

  const Catalogimage({Key key, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(image)
        .box
        .roundedSM
        .shadowOutline(outlineColor: Colors.black)
        .color(Colors.white)
        .make()
        .w24(context)
        .h20(context);
  }
}
