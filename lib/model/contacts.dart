import 'package:hive/hive.dart';

part 'contacts.g.dart';

@HiveType(typeId: 0)
class Contacts {
  @HiveField(0)
  late String image_path;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late int phone_number;

  @HiveField(3)
  late String relationship;

  void delete() {}
}
