import 'dart:async';

class TimerSingleton {
  static TimerSingleton? _instance;
  Timer? _timer;
  int _counter = 0;

  factory TimerSingleton() {
    _instance ??= TimerSingleton._();
    return _instance!;
  }

  TimerSingleton._();

  bool get isRunning => _timer != null && _timer!.isActive;
  int get counter => _counter;

  void startTimer(Function() callback) {
    if (!isRunning) {
      _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        print(_counter);
        callback();
        _counter++;
      });
    }
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    _counter = 0;
  }
}
