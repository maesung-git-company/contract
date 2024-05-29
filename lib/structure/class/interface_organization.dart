import 'package:uuid/uuid.dart';

abstract interface class OrganizationI {
  late final Uuid id;
  late final String name;

  Future<int> getTotalStep();
}
