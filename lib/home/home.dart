import "package:demo/!component/under_button.dart";
import "package:demo/auth/auth.dart";
import "package:demo/auth/login.dart";
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
        title: const Text(
          'OxygenNetwork',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                height: 60,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BottoneFloat(
                        onPressed: () {},
                        labelText: 'Testo',
                        icon: Icons.logout,
                        backgroundColor: Colors.red),
                    BottoneFloat(
                        onPressed: () {},
                        labelText: 'Testo',
                        icon: Icons.home,
                        backgroundColor:
                            const Color.fromARGB(255, 10, 59, 166)),
                    BottoneFloat(
                        onPressed: () async {
                          bool isLoggedOut = await logout();
                          if (isLoggedOut == true) {
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                              (route) => false,
                            );
                          }
                        },
                        labelText: 'Testo',
                        icon: Icons.settings,
                        backgroundColor: const Color.fromARGB(255, 93, 93, 93)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
