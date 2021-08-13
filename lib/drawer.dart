import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.red,
        child: ListView(
          children: [
            // DrawerHeader(
            //     child: Text("Hello There"),
            //     decoration: BoxDecoration(color: Colors.blueGrey))
            UserAccountsDrawerHeader(
                accountName: Text("User Name"),
                accountEmail: Text("Email@gmail.com")),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Accont"),
              subtitle: Text("Personal Data"),
              trailing: Icon(Icons.edit),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Email"),
              subtitle: Text("Email Settings"),
              trailing: Icon(Icons.edit),
            ),
            ListTile(
              leading: Icon(Icons.info_rounded),
              title: Text("Info"),
              subtitle: Text("Personal Information"),
              trailing: Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
