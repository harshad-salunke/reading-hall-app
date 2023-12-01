import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class TimerHelper {
  static const String _timerKey = 'timer';

  StreamController<int> _timerController = StreamController<int>.broadcast();
  late Timer _timer;
  int _seconds = 0;

  Stream<int> get timerStream => _timerController.stream;

  void startTimer() async {
    // Retrieve the previous timer value from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int storedSeconds = prefs.getInt(_timerKey) ?? 0;

    _seconds = storedSeconds;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;
      _timerController.add(_seconds);

      // Store the current timer value in shared preferences
      prefs.setInt(_timerKey, _seconds);
    });
  }

  void stopTimer() async {
    _timer?.cancel();
    _timerController.close();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_timerKey);
  }

  void dispose() {
    _timer?.cancel();
    _timerController.close();
  }
}
