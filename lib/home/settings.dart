import "package:demo/!component/bottombar.dart";
import "package:flutter/material.dart";

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'OxygenNetwork Settings',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Container(),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
