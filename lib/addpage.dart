import 'package:flutter/cupertino.dart';

class Add_Newone extends StatefulWidget {
  const Add_Newone({super.key});

  @override
  State<Add_Newone> createState() => _Add_NewoneState();
}

class _Add_NewoneState extends State<Add_Newone> {
  final namecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Enter Name Here"),
                Padding(
                  padding: const EdgeInsets.all(9),
                  child: CupertinoTextField(
                    controller: namecontroller,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Enter Number Here"),
                Padding(
                  padding: const EdgeInsets.all(9),
                  child: CupertinoTextField(
                    controller: namecontroller,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("  Enter Relationship Here"),
                Padding(
                  padding: const EdgeInsets.all(9),
                  child: CupertinoTextField(
                    controller: namecontroller,
                  ),
                ),
              ],
            ),
            CupertinoButton.filled(
                child: Text("Select photo"), onPressed: () {}),
            SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}
