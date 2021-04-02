import 'package:flutter/material.dart';
import 'package:solid_erp/web_viewer.dart';
import 'package:solid_erp/start_page.dart';
import 'package:solid_erp/Database.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  DBProvider db = DBProvider.db;
  await db.initDB();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: StartPage.id,
      routes: {
        StartPage.id : (context) => StartPage(),
        WebViewer.id : (context) => WebViewer(),
      },
    );
  }
}
