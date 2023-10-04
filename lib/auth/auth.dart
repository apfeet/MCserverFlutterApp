import "package:appwrite/appwrite.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
// ignore_for_file: avoid_print

Client client = Client()
    .setEndpoint(dotenv.env['END_POINT'] ?? 'Endpoint not found')
    .setProject(dotenv.env['SET_PROG'] ?? 'secret ID not found')
    .setSelfSigned(status: true);
final account = Account(client);
final databases = Databases(client);

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

void getuser() async {
  try {
    final userId = await GetUserID(); // Attendere l'ottenimento dell'ID utente

    Future<bool> userExist() async {
      try {
        final response = await databases.listDocuments(
          databaseId: '651b24f731b2855ab92d',
          collectionId: '651b253f714e3fb0c8a7',
          queries: [Query.equal('UserID', userId)],
        );

        // Verifica se ci sono documenti nel risultato
        return response.documents.isNotEmpty;
      } catch (e) {
        print(e.toString());
        return false;
      }
    }

    if (await userExist()) {
      print('UserID already exists in the collection');
    } else {
      await databases.createDocument(
        databaseId: '651b24f731b2855ab92d',
        collectionId: '651b253f714e3fb0c8a7',
        documentId: ID.unique(),
        data: {
          'UserID': userId, // Utilizza l'ID utente ottenuto precedentemente
          'timeByUser': 'not_setted_yet',
        },
      );
      print("Document created");
    }
  } catch (e) {
    print(e.toString());
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
    print('----------');
    print('Error while logging in');
    print('----------');
    print('-👇Error👇-');
    print(e.toString());
    print('----------');
    return false;
  }
}

Future<String> GetUserName() async {
  try {
    final sessions = await account.getSession(sessionId: 'current');
    final userResponse = await account.get();
    final userName = userResponse.name;
    return userName ?? "Errore";
  } catch (e) {
    print(e.toString());
    return "Errore";
  }
}

Future<String> GetUserID() async {
  try {
    final sessions = await account.getSession(sessionId: 'current');
    final userResponse = await account.get();
    final userID = userResponse.$id.toString();
    return userID ?? "IDutente non trovato";
  } catch (e) {
    print(e.toString());
    return "Errore";
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
  return true;
}
