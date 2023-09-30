import "package:demo/auth/login.dart";
import "package:demo/home/home.dart";
import "package:demo/home/settings.dart";
import "package:flutter/material.dart";
import "package:demo/auth/auth.dart";
import "package:demo/!component/under_button.dart";

bool isInSettings = false;
bool isInHome = false;

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 77, 152, 212),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                height: 60,
                width: 330,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                        icon: Icons.logout,
                        backgroundColor: Colors.red),
                    BottoneFloat(
                        onPressed: () {
                          if (isInSettings == true || isInHome == false) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                              (route) => false,
                            );
                            isInSettings = false;
                            isInHome = true;
                          } else {
                            print('Already in Home');
                          }
                        },
                        labelText: 'Testo',
                        icon: Icons.home,
                        backgroundColor:
                            const Color.fromARGB(255, 10, 59, 166)),
                    BottoneFloat(
                        onPressed: () {
                          if (!isInSettings) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Settings()),
                              (route) => false,
                            );
                            isInSettings = true;
                          } else {
                            print('Already in Settings');
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
