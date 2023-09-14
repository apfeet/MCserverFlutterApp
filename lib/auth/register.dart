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
                  try {
                    await createAccount(email.text, password.text);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  } catch (e) {
                    if (e is AuthException) {
                      String errorMessage = 'Errore durante la registrazione';
                      switch (e.errorCode) {
                        case 400:
                          errorMessage =
                              'La password deve essere lunga almeno 8 caratteri';
                        case 429:
                          errorMessage = 'Troppe richieste Riprova piú tardi';
                      }
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                        ),
                      );
                    }
                  }
                },
                child: Text('Invia'),
              ),
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
