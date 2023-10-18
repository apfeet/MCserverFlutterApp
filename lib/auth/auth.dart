import "package:appwrite/appwrite.dart";
import "package:appwrite/models.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import 'package:mc_rcon_dart/mc_rcon_dart.dart';
// ignore_for_file: avoid_print

Client client = Client()
    .setEndpoint(dotenv.env['END_POINT'] ?? 'Endpoint not found')
    .setProject(dotenv.env['SET_PROG'] ?? 'secret ID not found')
    .setSelfSigned(status: true);
final account = Account(client);
final databases = Databases(client);
Functions functions = Functions(client);

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

DateTime? datenow;
String datenow_ = 'temp';
String remainingTime = '';
void reward_24(String playerName) async {
  await createSocket(dotenv.env['IP_ADDR'] ?? '127.0.0.1', port: 25555);
  login(dotenv.env['PASSWD'] ?? 'Password_Not_Found');
  sendCommand("give $playerName diamond_ore");
  close();
}

void givereward() async {
  String playerName = await GetUserName();
  var data = {
    'key1': playerName,
  };

  try {
    final result = await functions.createExecution(
      functionId: dotenv.env['isplayer_online'] ?? 'function id not found',
      xasync: false,
      path: '/',
      method: 'GET',
      headers: data,
    );

    if (result != null) {
      String response = result.responseBody;
      if (response.contains('False')) {
        print('La risposta é "False"');
      } else {
        print('La risposta é "True"');
      }
    } else {
      print('La risposta è null');
    }
  } catch (e) {
    print('Errore: $e');
  }
}

Future<String> getuser() async {
  try {
    final userId = await GetUserID();
    Future<bool> userExist() async {
      try {
        final response = await databases.listDocuments(
          databaseId: dotenv.env['DB_ID'] ?? '',
          collectionId: dotenv.env['collectionid'] ?? '',
          queries: [Query.equal('UserID', userId)],
        );
        return response.documents.isNotEmpty;
      } catch (e) {
        print(e.toString());
        return false;
      }
    }

    if (await userExist() != false) {
      print('');
      print('🪪UserID already exists in the collection🪪');
      print('');
      Document response = await databases.getDocument(
        databaseId: dotenv.env['DB_ID'] ?? '',
        collectionId: dotenv.env['collectionid'] ?? '',
        documentId: userId,
      );
      datenow_ = response.data['timeByUser'];
    } else {
      final functions = Functions(client);
      final execution = await functions.createExecution(
          functionId: '651ad9e53adf8e5b3fe1',
          xasync: false,
          path: '/',
          method: 'GET');
      Map<String, dynamic> executionData = execution.toMap();
      String datenow = await executionData['responseBody'];
      datenow_ = datenow.toString();
      await databases.createDocument(
        databaseId: dotenv.env['DB_ID'] ?? '',
        collectionId: dotenv.env['collectionid'] ?? '',
        documentId: userId,
        data: {
          'UserID': userId,
          'timeByUser': datenow_,
        },
      );
      checklastuserclick();
      print("📃Document created📃");
    }
  } catch (e) {
    print(e.toString());
  }
  return await checklastuserclick();
}

Future<String> checklastuserclick() async {
  final userId = await GetUserID();
  Document result = await databases.getDocument(
    databaseId: dotenv.env['DB_ID'] ?? '',
    collectionId: dotenv.env['collectionid'] ?? '',
    documentId: userId,
  );
  final lastUserTime = result.data['timeByUser'];
  String savedDate = '⚙️Loading⚙️';
  final functions = Functions(client);
  try {
    final execution = await functions.createExecution(
        functionId: '651ad9e53adf8e5b3fe1',
        xasync: false,
        path: '/',
        method: 'GET');
    Map<String, dynamic> executionData = execution.toMap();
    String date = await executionData['responseBody'];
    savedDate = date;
    print('------🖥️SERVER🖥️------');
    print('Date and time in UTC: $savedDate');
    print('------🖥️SERVER🖥️------');
  } catch (e) {
    print(e.toString());
  }

  DateTime dateTimeA = DateTime.parse(savedDate);
  DateTime currentDateTime = DateTime.parse(datenow_);

  Duration difference = dateTimeA.difference(currentDateTime);
  if (difference.inHours > 24) {
    print('------🟩-----');
    print('> di 24');
    print('------🟩-----');
    await databases.updateDocument(
      databaseId: dotenv.env['DB_ID'] ?? 'not found',
      collectionId: dotenv.env['collectionid'] ?? 'not found',
      documentId: userId,
      data: {'timeByUser': savedDate},
    );
    getuser();

    print('');
    return '';
  } else {
    print('');
    print('------🟥-----');
    print('Difference of 24h: $difference');
    print('------🟥-----');
    print('');
    String difference_ = difference.toString();
    return '$difference_ di 24H';
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
