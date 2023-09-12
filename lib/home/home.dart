import "package:demo/auth/auth.dart";
import "package:demo/auth/register.dart";
import "package:flutter/material.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
            onPressed: () {
              logout();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Register()));
            },
            child: Icon(
              Icons.logout,
              size: 23,
              color: Colors.red[300],
            )),
      ),
    );
  }
}
