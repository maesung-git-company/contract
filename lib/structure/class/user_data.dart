import 'dart:ui';

import 'package:flutter/cupertino.dart';

class UserData {
  late int _id;
  late int _steps;
  late int _secondsActive;
  late List<String> _belongClassesUuid;

  final List<(State, VoidCallback)> _listeners = [];

  int get id => _id;
  set id(int value) {
    _id = value;
    onUpdate();
  }

  int get steps => _steps;
  set steps(int value) {
    _steps = value;
    onUpdate();
  }

  int get secondsActive => _secondsActive;
  set secondsActive(int value) {
    _secondsActive = value;
    onUpdate();
  }

  List<String> get belongClassesUuid => _belongClassesUuid;
  set belongClassesUuid(List<String> value) {
    _belongClassesUuid = value;
    onUpdate();
  }

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

  void onUpdate() {
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
