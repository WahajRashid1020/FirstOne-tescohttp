import 'package:flutter/material.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool changebtn = false;
  String name = "";
  final _formKey = GlobalKey<FormState>();
  movetoHome(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        changebtn = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, "/home");
      setState(() {
        changebtn = false;
      });
    }
  }

  final username = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login Page",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.black,
                          child: Card(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Welcome $name",
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Username is Empty";
                                    } else
                                      return null;
                                  },
                                  onChanged: (value) {
                                    name = value;
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      hintText: "Enter Username",
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Password is Empty";
                                    } else
                                      return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: "Password",
                                      hintText: "Enter Password",
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () => movetoHome(context),
                                  child: AnimatedContainer(
                                    duration: Duration(seconds: 1),
                                    height: 50,
                                    width: changebtn ? 45 : 90,
                                    alignment: Alignment.center,
                                    child: changebtn
                                        ? Icon(Icons.done, color: Colors.white)
                                        : Text("SignIn",
                                            style:
                                                TextStyle(color: Colors.white)),
                                    decoration: BoxDecoration(
                                      shape: changebtn
                                          ? BoxShape.circle
                                          : BoxShape.rectangle,
                                      color: Colors.indigo[900],
                                      // borderRadius:
                                      //     BorderRadius.circular(changebtn ? 10 : 5),
                                    ),
                                  ),
                                ),
                                // ElevatedButton(
                                //     onPressed: () {
                                //       Navigator.pushNamed(context, "/home");
                                //       // // Navigator.push(
                                //       // //     context,
                                //       // //     MaterialPageRoute(
                                //       // //         builder: (context) => HomePage()));
                                //     },
                                //     child: Text("SignIn")),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
