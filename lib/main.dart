import 'package:flutter/material.dart';
import 'package:oriki/Firestore/db_service.dart';
import 'package:oriki/Model/dob_model.dart';
import 'package:oriki/Screens/addedit.dart';
import 'package:oriki/Screens/home.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<DobModel>>(
            create: (_) => Repository().getUser(), initialData: const []),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home(),
        routes: {
          Home.routeName: (context) => const Home(),
          AddEdit.routeName: (context) => const AddEdit(),
        },
      ),
    );
  }
}
