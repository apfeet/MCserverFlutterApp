import "package:demo/auth/auth.dart";
import "package:demo/auth/register.dart";
import "package:flutter/material.dart";
import 'package:mc_rcon_dart/mc_rcon_dart.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

int port = 0;

void azione() async {
  try {
    String player = await GetUserName();
    createSocket(dotenv.env['IP_ADDR'] ?? '127.0.0.1', port: 25555);
    login("030907");
    sendCommand("give ${player} diamond_ore");
    close();
  } catch (e) {
    print('---------');
    print(e.toString());
    print('---------');
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  logout();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: Icon(
                  Icons.logout,
                  size: 23,
                  color: Colors.red[300],
                )),
          ),
          const SizedBox(
            width: 100,
          ),
          ElevatedButton(
              onPressed: () async {
                azione();
              },
              child: const Text('Test'))
        ],
      ),
    );
  }
}
