abstract interface class OrganizationI {
  late final String uuid;
  late final String name;

  Future<int> getTotalStep();
}
