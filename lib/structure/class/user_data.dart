import 'package:flutter/cupertino.dart';

class UserData {
  late int id;
  late int _steps;
  late int secondsActive;
  late String belongClassId;

  final List<(State, VoidCallback)> _listeners = [];

  int get steps => _steps;
  set steps(int v) {
    onStepUpdate();
    _steps = v;
  }

  UserData({
    required this.id,
    required steps,
    required this.secondsActive,
    required this.belongClassId
  }) : _steps = steps;

  void addListener(State listener, VoidCallback callback) {
    _listeners.add((listener, callback));
  }

  void removeListener(State listener) {
    for (var (listenerState, callback) in _listeners) {
      if (listenerState == listener) {
        _listeners.remove((listenerState, callback));
        return;
      }
    }
  }

  void onStepUpdate() {
    int idx = 0;
    late State listener;
    late VoidCallback callback;

    for (int i = 0; i < _listeners.length; i++) {
      (listener, callback) = _listeners[idx];
      if (!listener.mounted) {
        removeListener(listener);
        continue;
      }
      callback();
      idx++;
    }
  }
}
