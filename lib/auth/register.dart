import "package:demo/auth/auth.dart";
import "package:demo/auth/login.dart";
import "package:flutter/material.dart";

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                    await createAccount(email.text, password.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ));
                  },
                  child: Text('invia')),
              SizedBox(
                width: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ));
                  },
                  child: Text('Login')),
            ],
          ),
        ],
      ),
    );
  }
}
