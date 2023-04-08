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
            onTap: () {
              //
            },
          ),
          middle: Text(" WELCOME TO APPLEY"),
          trailing: CupertinoButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => Add_Newone()));
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
                    deleteContacts(contact);
                  },
                  child: Column(
                    children: [
                      Text(contact.name),
                      Image.file(
                        File(contact.image_path),
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

  void editTransaction(
    Contacts contacts,
    String image_path,
    String name,
    int phone_number,
    String relationship,
  ) {
    contacts.name = name;
    contacts.phone_number = phone_number;
    contacts.relationship = relationship;

    // final box = Boxes.getTransactions();
    // box.put(transaction.key, transaction);

    contacts.save();
  }

  void deleteContacts(Contacts contacts) {
    // final box = Boxes.getContactss();
    // box.delete(Contacts.key);
    print(contacts.name);
    // contacts.delete();

    //setState(() => Contactss.remove(Contacts));
  }
}


// SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(5),
//               child: CupertinoTextField(),
//             ),
//             Divider(),
//             Expanded(
//               child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 4),
//                   itemCount: 9,
//                   itemBuilder: (context, index) {
//                     return Card();
//                   }),
//             )
//           ],
//         ),
//       ),
    