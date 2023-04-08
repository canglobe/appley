import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:appley/boxes.dart';
import 'package:appley/model/contacts.dart';
// import 'package:appley/widget/Contacts_dialog.dart';
// import 'package:intl/intl.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Hive Expense Tracker'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<Contacts>>(
          valueListenable: Boxes.getContacts().listenable(),
          builder: (context, box, _) {
            final Contactss = box.values.toList().cast<Contacts>();

            return buildContent(Contactss);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => ContactsDialog(
              onClickedDone: addContacts,
            ),
          ),
        ),
      );

  Widget buildContent(List<Contacts> Contactss) {
    if (Contactss.isEmpty) {
      return Center(
        child: Text(
          'No expenses yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      final netExpense = Contactss.fold<double>(
        0,
        (previousValue, Contacts) => Contacts.isExpense
            ? previousValue - Contacts.amount
            : previousValue + Contacts.amount,
      );
      final newExpenseString = '\$${netExpense.toStringAsFixed(2)}';
      final color = netExpense > 0 ? Colors.green : Colors.red;

      return Column(
        children: [
          SizedBox(height: 24),
          Text(
            'Net Expense: $newExpenseString',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: color,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: Contactss.length,
              itemBuilder: (BuildContext context, int index) {
                final Contacts = Contactss[index];

                return buildContacts(context, Contacts);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildContacts(
    BuildContext context,
    Contacts Contacts,
  ) {
    final color = Contacts.isExpense ? Colors.red : Colors.green;
    final date = DateFormat.yMMMd().format(Contacts.createdDate);
    final amount = '\$' + Contacts.amount.toStringAsFixed(2);

    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          Contacts.name,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(date),
        trailing: Text(
          amount,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          buildButtons(context, Contacts),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Contacts Contacts) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: Text('Edit'),
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ContactsDialog(
                    Contacts: Contacts,
                    onClickedDone: (name, amount, isExpense) =>
                        editContacts(Contacts, name, amount, isExpense),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Delete'),
              icon: Icon(Icons.delete),
              onPressed: () => deleteContacts(Contacts),
            ),
          )
        ],
      );

  Future addContacts(String name, double amount, bool isExpense) async {
    final Contacts = Contacts()
      ..name = name
      ..createdDate = DateTime.now()
      ..amount = amount
      ..isExpense = isExpense;

    final box = Boxes.getContactss();
    box.add(Contacts);
    //box.put('mykey', Contacts);

    // final mybox = Boxes.getContactss();
    // final myContacts = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  void editContacts(
    Contacts Contacts,
    String name,
    double amount,
    bool isExpense,
  ) {
    Contacts.name = name;
    Contacts.amount = amount;
    Contacts.isExpense = isExpense;

    // final box = Boxes.getContactss();
    // box.put(Contacts.key, Contacts);

    Contacts.save();
  }

  void deleteContacts(Contacts Contacts) {
    // final box = Boxes.getContactss();
    // box.delete(Contacts.key);

    Contacts.delete();
    //setState(() => Contactss.remove(Contacts));
  }
}
