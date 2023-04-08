// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:appley/widget/addpage.dart';
import 'package:appley/boxes.dart';
import 'package:appley/model/contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class My_appley extends StatefulWidget {
  const My_appley({super.key});

  @override
  State<My_appley> createState() => _My_appleyState();
}

class _My_appleyState extends State<My_appley> {
  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: Icon(CupertinoIcons.airplane),
          middle: Text(" WELCOME TO APPLEY"),
          trailing: CupertinoButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => Add_Newone()));
            },
          ),
        ),
        child: ValueListenableBuilder(
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
                final transaction = contacts[index];
                return Column(
                  children: [
                    Text(transaction.name),
                    Image.file(
                      File(transaction.image_path),
                    ),
                  ],
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

  void deleteTransaction(Contacts contacts) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);

    contacts.delete();
    //setState(() => transactions.remove(transaction));
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
    