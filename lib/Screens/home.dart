import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oriki/Model/dob_model.dart';
import 'package:oriki/Screens/addedit.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static const routeName = '/Home';
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('MMMM dd, yyyy');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Oriki Staff'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed(AddEdit.routeName,
              arguments: DobModel(
                  name: '',
                  email: '',
                  date: Timestamp.now(),
                  number: 0,
                  uid: '')),
          child: const Icon(Icons.add),
        ),
        body: Consumer<List<DobModel>>(
          builder: (context, value, child) => ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: value.length,
              separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                  ),
              itemBuilder: ((context, index) => ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(AddEdit.routeName,
                          arguments: value[index]);
                    },
                    title: Text(value[index].name),
                    trailing: Text(format.format(value[index].date.toDate())),
                  ))),
        ));
  }
}
