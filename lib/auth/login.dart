import "package:demo/auth/auth.dart";
import "package:demo/home/home.dart";
import "package:flutter/material.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogIn'),
      ),
      body: Column(
        children: [
          TextField(
            controller: email,
            textAlign: TextAlign.center,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: password,
            textAlign: TextAlign.center,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await loginUser(email.text, password.text).then((value) {
                      if (value) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('errore')));
                      }
                    });
                  },
                  child: Text('invia')),
            ],
          ),
        ],
      ),
    );
  }
}
