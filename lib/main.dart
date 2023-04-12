// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
//--Inbuild Packages

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
//--External Packages

import 'package:appley/model/contacts.dart';
import 'package:appley/widget/home.dart';
//--Local Files

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ContactsAdapter());
  await Hive.openBox<Contacts>("contacts");

  runApp(Myapp());
}

//--Main Class
class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: Myappley(),
    );
  }
}
