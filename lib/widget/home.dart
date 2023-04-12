// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:appley/boxes.dart';
import 'package:appley/model/contacts.dart';
import 'package:appley/widget/addpage.dart';

class Myappley extends StatefulWidget {
  const Myappley({super.key});

  @override
  State<Myappley> createState() => _MyappleyState();
}

class _MyappleyState extends State<Myappley> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: GestureDetector(
            child: Icon(CupertinoIcons.airplane),
            onTap: () async {
              //
              bool val = await Hive.boxExists("CONTACTS");
              print(val);
              var box = Hive.box("CONTACTS");
              box.clear();
            },
          ),
          middle: Text(" WELCOME TO APPLEY"),
          trailing: CupertinoButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => AddContact()));
            },
          ),
        ),
        child: ValueListenableBuilder<Box<Contacts>>(
            valueListenable: Boxes.getContacts().listenable(),
            builder: (context, box, _) {
              final contacts = box.values.toList().cast<Contacts>();
              return buildContent(contacts);
            }));
  }

  Widget buildContent(List<Contacts> contacts) {
    if (contacts.isEmpty) {
      return Center(
        child: Text(
          'No contacts yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 24),
          Text(
            'Net Expense: newExpenseString',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              // color: color,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                final contact = contacts[index];
                return GestureDetector(
                  onLongPress: () {
                    //
                  },
                  child: Column(
                    children: [
                      Text(contact.name),
                      Image.file(
                        File(contact.imagepath),
                      ),
                    ],
                  ),
                );
              },
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            ),
          ),
        ],
      );
    }
  }

  void editContacts(
    Contacts contacts,
    String imagepath,
    String name,
    int phonenumber,
    String relationship,
  ) {
    contacts.name = name;
    contacts.number = phonenumber;
    contacts.relative = relationship;

    contacts.save();
  }

  void deleteContacts(Contacts contact) {
    contact.delete();
  }
}
