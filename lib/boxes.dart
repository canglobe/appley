import 'package:appley/model/contacts.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Contacts> getContacts() => Hive.box<Contacts>("contacts");
}
