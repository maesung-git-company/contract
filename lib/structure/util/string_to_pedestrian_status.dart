import '../enum/custom_pedestrian_status.dart';

final Map<String, CustomPedestrianStatus> _pedestrianStatusDict = {
  'walking': CustomPedestrianStatus.walking,
  'stopped': CustomPedestrianStatus.stopped
};

CustomPedestrianStatus string2pedestrianStatus(String str) {
  try {
    return _pedestrianStatusDict[str]!;
  } on NoSuchMethodError {
    return CustomPedestrianStatus.unknown;
  }
}