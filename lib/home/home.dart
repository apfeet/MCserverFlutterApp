import "package:demo/!component/bottombar.dart";
import "package:demo/auth/auth.dart";
import "package:flutter/material.dart";
import 'package:mc_rcon_dart/mc_rcon_dart.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

void azione() async {
  try {
    String player = await GetUserName();
    await createSocket(dotenv.env['IP_ADDR'] ?? '127.0.0.1', port: 25555);
    await login(dotenv.env['PASSWD'] ?? 'Password_Not_Found');
    await sendCommand("give ${player} diamond_ore");
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
      backgroundColor: const Color.fromARGB(255, 77, 152, 212),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'OxygenNetwork',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Container(),
      bottomSheet: const BottomBar(),
    );
  }
}
