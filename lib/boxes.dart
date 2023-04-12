import 'package:hive/hive.dart';
import 'package:appley/model/contacts.dart';

class Boxes {
  static Box<Contacts> getContacts() => Hive.box<Contacts>("contacts");
}
