class SchoolData {
  late final String uuid;
  late final String name;
  late final List<String> classesUuid;
  late int latestSumOfSteps;
  late DateTime latestSumWhen;

  SchoolData({
    required this.uuid,
    required this.name,
    required this.classesUuid,
    required this.latestSumOfSteps,
    required this.latestSumWhen,
  });
}