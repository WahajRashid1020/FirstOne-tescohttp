import 'dart:convert';

import 'package:awesomeapp/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login-page1.dart';

void main() {
  runApp(MaterialApp(
    title: "Practice Flutter",
    home: LoginPage(),
    theme: ThemeData(primarySwatch: Colors.blueGrey),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _nameControlller = TextEditingController();
  var mytext = "Change";

  var data;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var res =
        await http.get(Uri.parse('http://jsonplaceholder.typicode.com/photos'));
    data = jsonDecode(res.body);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Application"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: data != null
              ? ListView.builder(
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListTile(
                        leading: Image.network(data[index]["thumbnailUrl"]),
                        title: Text(data[index]["title"]),
                        subtitle: Text("ID ${data[index]["id"]}"),
                      ),
                    );
                  },
                  itemCount: data.length,
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mytext = _nameControlller.text;
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialApp(
//     title: "Flutter",
//     home: HomePage(),
//     theme: ThemeData(primarySwatch: Colors.lime),
//   ));
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController _nameController = TextEditingController();
//   var mytext = "Change It";
//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white30,
//         appBar: AppBar(
//             title:
//                 Text("MY FLUTTER APP", style: TextStyle(color: Colors.black))),
//         body: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: SingleChildScrollView(
//             child: Card(
//               child: Column(children: [
//                 Image.asset("mg.jpg", fit: BoxFit.cover),
//                 SizedBox(height: 20),
//                 Text(mytext),
//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: TextField(
//                     controller: _nameController,
//                     decoration: InputDecoration(
//                         hintText: "Enter Input",
//                         labelText: "Name",
//                         border: OutlineInputBorder()),
//                   ),
//                 ),
//                 Image.asset("mg1.jpg", fit: BoxFit.cover),
//               ]),
//             ),
//           ),
//         ),
//         drawer: Drawer(
//           child: ListView(
//             children: [
//               // DrawerHeader(
//               //     child: Text("My Drawer", style: TextStyle(color: Colors.white)),
//               //     decoration: BoxDecoration(color: Colors.purple))
//               UserAccountsDrawerHeader(
//                 accountName: Text("Wahaj Rashid"),
//                 accountEmail: Text("wahaj1020@gmails.com"),
//                 // currentAccountPicture: Image.network(src),
//               ),
//               ListTile(
//                 leading: Icon(Icons.person),
//                 title: Text("Accont"),
//                 subtitle: Text("Personal Data"),
//                 trailing: Icon(Icons.edit),
//               ),
//               ListTile(
//                 leading: Icon(Icons.email),
//                 title: Text("Email"),
//                 subtitle: Text("Email Settings"),
//                 trailing: Icon(Icons.edit),
//               ),
//               ListTile(
//                 leading: Icon(Icons.info_rounded),
//                 title: Text("Info"),
//                 subtitle: Text("Personal Information"),
//                 trailing: Icon(Icons.edit),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               mytext = _nameController.text;
//               setState(() {});
//             },
//             child: Icon(Icons.refresh)));
//   }
// }

