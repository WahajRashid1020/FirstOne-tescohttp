import 'dart:convert';

import 'package:awesomeapp/AboutUs.dart';
import 'package:awesomeapp/add_to_cart.dart';
import 'package:awesomeapp/cart_page.dart';
import 'package:awesomeapp/core/store.dart';
import 'package:awesomeapp/detail.dart';
// import 'package:awesomeapp/drawer.dart';
import 'package:awesomeapp/info_page.dart';
import 'package:awesomeapp/login-page.dart';
// import 'package:awesomeapp/maps.dart';
import 'package:awesomeapp/models/cart.dart';
import 'package:awesomeapp/models/catalog.dart';
import 'package:awesomeapp/widget/search_widget.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
// ignore: unused_import
import 'item_widget.dart';

void main() {
  runApp(
    VxState(
      store: MyStore(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Tesco App",
          home: HomePage(),
          theme: ThemeData(
              primarySwatch: Colors.indigo,
              primaryTextTheme: GoogleFonts.latoTextTheme()),
          routes: {
            "/login": (context) => MyLoginPage(),
            "/home": (context) => HomePage(),
            "/cart": (context) => Cart_page(),
            "/info": (context) => InfoPage(),
            "/about": (context) => Aboutus(),
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
  // final url = 'https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3';
  final url = 'https://qasim-electronics.herokuapp.com/api/products/';

  _HomePageState();
  @override
  void initState() {
    super.initState();
    loadData();
    //  getData();
  }

  loadData() async {
    // var catjson = await rootBundle.loadString("assets/files/catalog.json");
    // final catdata = jsonDecode(catjson);
    // var pd = catdata["products"];
    // CatalogModel.items =
    //     List.from(pd).map<Item>((item) => Item.fromMap(item)).toList();
    // setState(() {});
    var catjson = await http.get(Uri.parse(url));
    final catjs = catjson.body;
    // await rootBundle.loadString("assets/files/catalog.json");
    final catdata = jsonDecode(catjs);
    // var pd = catdata["products"];
    CatalogModel.items =
        List.from(catdata).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {});
  }

  // getData() async {
  //   var res = await http.get(Uri.parse(url));
  //   data = jsonDecode(res.body);
  //   print(data);
  // }

  Widget build(BuildContext context) {
    final String lat = "25.3622";
    final String lng = "86.0835";

    launchEmail() async {
      launch(
          "mailto:rakhi@aeologic.com?subject=TestEmail&body=How are you%20plugin");
    }

    _launchMap() async {
      final String googleMapsUrl = "comgooglemaps://?center=$lat,$lng";
      final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";

      if (await canLaunch(googleMapsUrl)) {
        await launch(googleMapsUrl);
      }
      if (await canLaunch(appleMapsUrl)) {
        await launch(appleMapsUrl, forceSafariVC: false);
      } else {
        throw "Couldn't launch URL";
      }
    }

    _launchURL() async {
      launch("tel://03433093451");
    }

    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          centerTitle: true,
          actions: [
            OutlinedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context, builder: (context) => Aboutus());
              },
              child: BlinkText(
                'Card',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                beginColor: Colors.grey[350],
                endColor: Colors.indigo[900],
                times: 300,
                duration: Duration(seconds: 1),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.yellow[800],
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
            ),
          ],
          title: "Tesco App"
              .text
              .italic
              .bold
              .xl4
              .center
              .color(Colors.grey[350])
              .make(),
          backgroundColor: Colors.indigo[900],
          shadowColor: Colors.grey[350],
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.indigo[900],
            child: ListView(
              children: [
                // DrawerHeader(
                //     child: Text("My Drawer", style: TextStyle(color: Colors.white)),
                //     decoration: BoxDecoration(color: Colors.purple))
                UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,

                  decoration: BoxDecoration(color: Colors.indigo[900]),
                  currentAccountPicture: new Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
                        ),
                      ),
                    ),
                  ),
                  accountName: "Wahaj Rashid".text.color(Colors.white).make(),
                  accountEmail:
                      "wahaj1020@gmails.com".text.color(Colors.white).make(),
                  // currentAccountPicture: Image.network(src),
                ),
                ListTile(
                  onTap: launchEmail,
                  leading: Icon(
                    Icons.email,
                    color: Colors.yellow[800],
                  ),
                  title: "Email Address".text.color(Colors.white).make(),
                  subtitle:
                      "Tap to write Email".text.color(Colors.white).make(),
                ),
                ListTile(
                  onTap: _launchMap,
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.yellow[800],
                  ),
                  title: "Location".text.color(Colors.white).make(),
                  subtitle: "Tap to find our location"
                      .text
                      .color(Colors.white)
                      .make(),
                ),
                ListTile(
                  onTap: _launchURL,
                  leading: Icon(
                    Icons.call,
                    color: Colors.yellow[800],
                  ),
                  title: "Contact Us".text.color(Colors.white).make(),
                  subtitle:
                      "Tap to directly call us".text.color(Colors.white).make(),
                ),
                ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Aboutus()),
                  ),
                  leading: Icon(
                    Icons.info,
                    color: Colors.yellow[800],
                  ),
                  title: "About Us".text.color(Colors.white).make(),
                  subtitle: "Tap to get information about us"
                      .text
                      .color(Colors.white)
                      .make(),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: VxBuilder(
        //   mutations: {AddMutation, RemoveMutation},
        //   builder: (ctx, _) => FloatingActionButton(
        //     backgroundColor: Colors.yellow[800],
        //     onPressed: () {
        //       Navigator.pushNamed(context, "/cart");
        //     },
        //     child: Icon(CupertinoIcons.cart).iconColor(Colors.black),
        //   ).badge(
        //       color: Vx.red500,
        //       size: 20,
        //       count: _cart.items.length,
        //       textStyle: TextStyle(
        //         color: Colors.black,
        //         fontSize: 15,
        //       )),
        // ),
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text("Search...", style: TextStyle(color: Colors.white)),
        //   actions: [
        //     IconButton(
        //         icon: Icon(Icons.search),
        //         onPressed: () {
        //           showSearch(
        //               context: context,
        //               delegate: DataSearch(CatalogModel.items));
        //         }),
        //   ],
        // ),
        body: SafeArea(
          child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlinkText(
                  'Available Items',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  beginColor: Colors.indigo[900],
                  endColor: Colors.yellow[900],
                  times: 30,
                  duration: Duration(seconds: 1),
                ),
                // "Available Items ".text.xl2.color(Colors.indigo[900]).make(),
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

class DataSearch extends SearchDelegate<String> {
  final List list = [];
  final List l;

  final rl = [
    "wahaj",
    "bilal",
    "qasim",
    "wahaj",
    "bilal",
    "qasim",
    "wahaj",
    "bilal",
    "qasim",
  ];
  // final l = [
  //   "bilal",
  //   "qasim",
  //   "wahaj",
  //   "bilal",
  //   "qasim",
  //   "wahaj",
  //   "bilal",
  //   "qasim",
  // ];

  DataSearch(this.l);
  // final Item catalog;

  // DataSearch(this.catalog);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];

    // throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });

    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // final sl = query.isEmpty
    //     ? l
    //     : l.where((element) => element.startsWith(query)).toString();

    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    l.where((element) => element.startsWith(query)).toString();

    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final catalog = l[index];
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(catalog: catalog)),
            ),
            child: Catalogitems(catalog: catalog),
          );
        });
    // throw UnimplementedError();
  }
}

class Cataloglist extends StatefulWidget {
  final List catalog;

  const Cataloglist({Key key, this.catalog}) : super(key: key);
  @override
  _CataloglistState createState() => _CataloglistState();
}

class _CataloglistState extends State<Cataloglist> {
  String query = '';
  List<Item> bk;

  _CataloglistState();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // buildSerach(),
        Expanded(
          child: ListView.builder(
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
              }),
        ),
      ],
    );
  }

  Widget buildSerach() => SearchWidget(
        text: query,
        hintText: "Search...",
        onChanged: SearchBox,
      );

  void SearchBox(String query) {
    final url = 'https://qasim-electronics.herokuapp.com/api/products/';

    loadData1(query) async {
      // var catjson = await rootBundle.loadString("assets/files/catalog.json");
      // final catdata = jsonDecode(catjson);
      // var pd = catdata["products"];
      // CatalogModel.items =
      //     List.from(pd).map<Item>((item) => Item.fromMap(item)).toList();
      // setState(() {});
      var catjson = await http.get(Uri.parse(url));
      final catjs = catjson.body;
      // await rootBundle.loadString("assets/files/catalog.json");
      final catdata = jsonDecode(catjs);
      // var pd = catdata["products"];
      CatalogModel.items =
          List.from(catdata).map<Item>((item) => Item.fromMap(item)).toList();
      setState(() {
        this.query = query;
        this.bk = bk;
      });
    }

    ;
  }
}

class Catalogitems extends StatelessWidget {
  final Item catalog;

  const Catalogitems({Key key, @required this.catalog, list})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Padding(
      padding: const EdgeInsets.all(18.0),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: "${catalog.name}".text.xl.color(Colors.white).make(),
                  ),
                ),
              ),

              // catalog.desc.text
              //     .color(Colors.white)
              //     .textStyle(context.captionStyle)
              //     .make(),
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
                    addtocart(catalog: catalog),
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    )).color(Colors.indigo[900]).rounded.square(130).make().py1();
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
        .h15(context);
  }
}
