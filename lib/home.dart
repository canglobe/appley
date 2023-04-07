// ignore_for_file: prefer_const_constructors

import 'package:appley/addpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class My_appley extends StatefulWidget {
  const My_appley({super.key});

  @override
  State<My_appley> createState() => _My_appleyState();
}

class _My_appleyState extends State<My_appley> {
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
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: CupertinoTextField(),
            ),
            Center(
              child: Text("Hi"),
            ),
          ],
        ),
      ),
    );
  }
}
