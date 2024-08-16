import 'dart:ui';

class UserData {
  late int _id;
  late int _steps;
  late int _secondsActive;
  late List<String> _belongClassesUuid;

  final List<VoidCallback> _listeners = [];

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

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void onUpdate() {
    for (var listener in _listeners) {
      listener();
    }
  }

}
