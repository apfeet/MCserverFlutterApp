import "package:appwrite/appwrite.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
// ignore_for_file: avoid_print

Client client = Client()
    .setEndpoint(dotenv.env['END_POINT'] ?? 'Endpoint not found')
    .setProject(dotenv.env['SET_PROG'] ?? 'secret ID not found')
    .setSelfSigned(status: true);
final account = Account(client);

Future<bool> createAccount(
    String username, String email, String password) async {
  try {
    await account.create(
      name: username,
      userId: ID.unique(),
      email: email,
      password: password,
    );
    print('----------');
    print('Account Created');
    print('----------');
    return true;
  } on AppwriteException catch (e) {
    print('----------');
    print('Error cant create the account');
    print('----------');
    print(e.toString());
    throw AuthException(e.code, e.toString());
  }
}

class AuthException implements Exception {
  final int? errorCode;
  final String message;

  AuthException(this.errorCode, this.message);
}

Future loginUser(String email, String password) async {
  try {
    await account.createEmailSession(email: email, password: password);
    print('----------');
    print('LoggedIn');
    print('----------');
    return true;
  } catch (e) {
    e.toString();
    print('----------');
    print('Error while logging in');
    print('----------');
    return false;
  }
}

Future checkuserlogged() async {
  try {
    account.getSession(sessionId: 'current');
    return false;
  } catch (e) {
    e.toString();
    return true;
  }
}

Future logout() async {
  await account.deleteSession(sessionId: 'current');
}
