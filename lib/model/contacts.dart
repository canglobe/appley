import 'package:hive/hive.dart';

part 'contacts.g.dart';

@HiveType(typeId: 0)
class Contacts extends HiveObject {
  @HiveField(0)
  late String imagepath;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late int number;

  Contacts({
    required this.imagepath,
    required this.name,
    required this.number,
  });
}
