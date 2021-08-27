import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Aboutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo[800],
        body: Container(
          height: 1000,
          child: ListView(
            children: [
              ListTile(
                tileColor: Colors.yellow[800],
                title: "Visiting Card".text.xl5.bold.italic.center.make(),
              ),
              ListTile(
                tileColor: Colors.yellow[800],
                title: "Monday to Saturday".text.make(),
                leading: Icon(Icons.event_available, color: Colors.black),
              ),
              ListTile(
                tileColor: Colors.yellow[800],
                title: "Addresss Here".text.make(),
                leading: Icon(Icons.location_on, color: Colors.black),
              ),
              ListTile(
                tileColor: Colors.yellow[800],
                title: "03433093451".text.make(),
                leading: Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
