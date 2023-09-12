import "package:appwrite/appwrite.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

Client client = Client()
    .setEndpoint(dotenv.env['END_POINT'] ?? 'Endpoint not found')
    .setProject(dotenv.env['SET_PROG'] ?? 'secret ID not found')
    .setSelfSigned(status: true);
final account = Account(client);

Future<String> createAccount(String email, String password) async {
  try {
    final user = await account.create(
      userId: ID.unique(),
      email: email,
      password: password,
    );
    return "success";
  } catch (e) {
    print(e.toString());
    return "error";
  }
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
