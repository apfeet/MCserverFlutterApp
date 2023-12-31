import "dart:async";
import "package:demo/!component/bottombar.dart";
import "package:demo/auth/auth.dart";
import "package:flutter/material.dart";

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String player = "Caricamento in corso...";
  String userID = "Caricamento in corso...";
  Timer? _timer;
  int elapsedTime = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadUserID();
    _loadUserName();
  }

  void startTimer() {
    _timer?.cancel();
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          elapsedTime = elapsedTime + 1;
        },
      ),
    );
  }

  Future<void> _loadUserName() async {
    try {
      String loadedPlayer = await GetUserName();
      setState(() {
        player = loadedPlayer;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        player = "Errore";
      });
    }
  }

  Future<void> _loadUserID() async {
    try {
      String loadUserID = await GetUserID();
      setState(() {
        userID = loadUserID;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        player = "Errore";
      });
    }
  }

  int parseTime(String timeString) {
    var timeParts = timeString.split(':');
    if (timeParts.length < 3) {
      print(
          'Error: timeString "$timeString" should be in the format "hh:mm:ss"');
      return 0;
    }

    var parsedTimeParts = timeParts.map((part) {
      var numberPart = part.split('.')[0];
      try {
        return double.parse(numberPart);
      } catch (e) {
        print(
            'Error parsing "$numberPart" into a double🟩this is normal if the 24h is passed');
        return 0.0;
      }
    }).toList();

    return ((parsedTimeParts[0] * 60 + parsedTimeParts[1]) * 60 +
            parsedTimeParts[2])
        .round();
  }

  String formatTime(int timeInSeconds) {
    int hours = timeInSeconds ~/ 3600;
    int minutes = (timeInSeconds % 3600) ~/ 60;
    int seconds = timeInSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} su 24H';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 77, 152, 212),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'OxygenNetwork',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bentornato $player",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final newRemainingTimeString = await getuser();
                    final newRemainingTime = parseTime(newRemainingTimeString);
                    setState(() {
                      elapsedTime = newRemainingTime;
                    });
                    startTimer();
                  },
                  child: Text('Clicca ${formatTime(elapsedTime)}'),
                ),
                ElevatedButton(
                    onPressed: () {
                      givereward();
                    },
                    child: Text('debug'))
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: const BottomBar(),
      ),
    );
  }
}
